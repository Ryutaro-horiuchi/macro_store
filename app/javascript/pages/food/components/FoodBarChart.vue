<script>
import { HorizontalBar } from 'vue-chartjs'

Chart.plugins.register({
  beforeRender: function (chart) {
    if (chart.config.options.showAllTooltips) {
      // ツールチップの配列を作成する
      // チャートごとにツールチップは1つしかないため。
      chart.pluginTooltips = [];
      chart.config.data.datasets.forEach(function (dataset, i) {
        chart.getDatasetMeta(i).data.forEach(function (sector, j) {
          chart.pluginTooltips.push(new Chart.Tooltip({
            _chart: chart.chart,
            _chartInstance: chart,
            _data: chart.data,
            _options: chart.options.tooltips,
            _active: [sector]
          }, chart));
        });
      });

      // 通常のツールチップをオフにする
      chart.options.tooltips.enabled = false;
    }
  },
  afterDraw: function (chart, easing) {
    if (chart.config.options.showAllTooltips) {
      /* 常設のツールチップをアニメーションさせたくないので、
          アニメーションが少なくとも1回実行されるまで何もしないでください。 */
      if (!chart.allTooltipsOnce) {
        if (easing !== 1)
          return;
        chart.allTooltipsOnce = true;
      }

      // ツールチップの表示
      chart.options.tooltips.enabled = true;
      Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
        tooltip.initialize();
        tooltip.update();
        // ツールチップをアニメーションさせていないので、実際には必要ありません
        tooltip.transition(easing).draw();
      });
      chart.options.tooltips.enabled = false;
    }
  }
})

export default {
  extends: HorizontalBar,
  name: 'chart',
  props: {
    food: {
      type: Object,
      default: null
    }
  },
  mounted() {
    this.renderChart(
      {
        labels: ["たんぱく質", "炭水化物", "脂質"],
        datasets: [{
          data:  [this.food.protein, this.food.carbohydrate, this.food.lipid],
          backgroundColor: [
            'rgba(255, 212, 29, 0.5)',
            'rgba(139, 248, 119, 0.5)',
            'rgba(39, 87, 245, 0.5)',
          ],
          borderColor: [
            'rgba(255, 212, 29, 1)',
            'rgba(139, 248, 119, 1)',
            'rgba(39, 87, 245, 1)',
          ],
          borderWidth: 2
        }],
      },
      { 
        showAllTooltips: true,
        legend: {
          display: false　//凡例の省略
        },
        scales: {
          xAxes:[
            {
              ticks: {
                min: 0,
                max: 100
              }
            }
          ]
        }
      },
    )
  }
}
</script>
