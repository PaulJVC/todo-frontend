<template>
  <q-page class="row flex-center">
    <div class="col-4">
      <q-card class="q-pa-md">
        <q-card-section>
          <div class="row flex-center">
            <h5 class="q-mt-xs">Register a new account</h5>
          </div>
          
          <div>
            <q-form
              @submit.prevent="authenticate('register', formData)"
              class="w-1/2 mx-auto space-y-6"
            >
              <q-input class="q-mb-sm" type="text" placeholder="Name" v-model="formData.name" filled />
              <p v-if="errors.name" class="text-negative">{{ errors.name[0] }}</p>

              <q-input class="q-mb-sm" type="text" placeholder="Email" v-model="formData.email" filled />
              <p v-if="errors.email" class="text-negative">{{ errors.email[0] }}</p>

              <q-input
                class="q-mb-sm"
                type="password"
                placeholder="Password"
                v-model="formData.password"
                filled
              />
              <p v-if="errors.password" class="text-negative">{{ errors.password[0] }}</p>

              <q-input
                class="q-mb-sm"
                type="password"
                placeholder="Confirm Password"
                v-model="formData.password_confirmation"
                filled
              />

              <q-card-actions vertical class="q-px-none q-mt-md">
                <q-btn type="submit" color="primary">Register</q-btn>
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
  name: "",
  email: "",
  password: "",
  password_confirmation: "",
});

onMounted(() => (errors.value = {}));
</script>