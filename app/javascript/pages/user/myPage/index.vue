<template>
  <UserForm :title="title">
    <template #form-card-content>
      <label>ユーザー名</label>
      <v-text-field
        :value="user.name"
        solo
        readonly
        flat
      />
      <v-simple-table>
        <thead>
          <tr>
            <th class="text-left">
              １食の摂取量
            </th>
            <th class="text-left">
              数値(g)
            </th>
          </tr>
        </thead>
        <tbody id="nutrient">
          <tr
            v-for="nutrient in nutrients"
            :key="nutrient.name"
          >
            <td>{{ nutrient.name }}</td>
            <td>{{ nutrient.number }}</td>
          </tr>
        </tbody>
      </v-simple-table>
      <v-row
        justify="center"
        style="margin-top: 80px"
      >
        <v-btn
          color="#1c65ac"
          dark
          x-large
          elevation="3"
          @click="toUserEditPage"
        >
          編集する
        </v-btn>
      </v-row>
    </template>
  </UserForm>
</template>

<script>
import { mapGetters } from "vuex";
import UserForm from "../components/UserForm.vue";

export default {
  components: {
    UserForm,
  },
  data() {
    return {
      title: "マイページ",
      nutrients: [
        {
          name: "カロリー",
          number: 0,
        },
        {
          name: "たんぱく質",
          number: 0,
        },
        {
          name: "炭水化物",
          number: 0,
        },
        {
          name: "脂質",
          number: 0,
        },
      ],
    };
  },
  computed: {
    ...mapGetters(["user"]),
  },
  created() {
    this.nutrients[0].number = this.user.calorie;
    this.nutrients[1].number = this.user.protein;
    this.nutrients[2].number = this.user.carbohydrate;
    this.nutrients[3].number = this.user.lipid;
  },
  methods: {
    toUserEditPage() {
      this.$router.push("edit");
    },
  },
};
</script>