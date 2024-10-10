<template>
  <q-page class="row flex-center">
    <div class="col-4">
      <q-card class="q-pa-md">
        <q-card-section>
          <div class="row flex-center">
            <h5 class="q-mt-xs">Login to your account</h5>
          </div>
          
          <div>
            <q-form @submit.prevent="authenticate('login', formData)">
              <q-input class="q-mb-sm" filled v-model="formData.email" placeholder="Email" :dense="dense" />
              <p v-if="errors.email" class="text-negative">{{ errors.email[0] }}</p>

              <q-input
                filled
                type="password"
                placeholder="Password"
                v-model="formData.password"
                :dense="dense"
              />
              <p v-if="errors.password" class="text-negative">{{ errors.password[0] }}</p>

              <q-card-actions vertical class="q-px-none q-mt-md">
                <q-btn type="submit" color="primary">Login</q-btn>
              </q-card-actions>
            </q-form>
          </div>
        </q-card-section>
      </q-card>
    </div>
  </q-page>
</template>

<script setup>
import { useAuthStore } from "@/stores/auth";
import { storeToRefs } from "pinia";
import { onMounted, reactive } from "vue";

const { errors } = storeToRefs(useAuthStore());
const { authenticate } = useAuthStore();

const formData = reactive({
  email: "",
  password: "",
});

onMounted(() => (errors.value = {}));
</script>

<style scoped>

</style>