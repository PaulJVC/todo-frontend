<template>
  <q-dialog ref="dialogRef" @hide="onDialogHide">
    <q-card class="q-pa-md">
      <q-card-section>
        <div class="row flex-center">
          <h5 class="q-mt-xs">Create a new task</h5>
        </div>
        <div>
          <q-form @submit.prevent="createUserTask(formData)">
            <q-input
              class=""
              filled
              v-model="formData.title"
              placeholder="Title"
              :dense="dense"
            />
          </q-form>
        </div>
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { storeToRefs } from "pinia";
import { onMounted, reactive, ref, defineProps, defineEmits } from "vue";
import { useTasksStore } from "@/stores/tasks";
import { useDialogPluginComponent } from "quasar";

const { createUserTask } = useTasksStore();
const { errors } = storeToRefs(useTasksStore());

const {
  dialogRef,
  onDialogHide,
  onDialogOK,
  onDialogCancel,
} = useDialogPluginComponent();

const formData = reactive({
  title: "",
  description: "",
  due_date: "",
  priority: "",
  attachment: null,
  tags: [],
});

const newTag = ref("");

const handleFileUpload = (event) => {
  formData.attachment = event.target.files[0];
};

const addTag = () => {
  if (newTag.value.trim() && !formData.tags.includes(newTag.value)) {
    formData.tags.push(newTag.value.trim());
  }
  newTag.value = ""; // Reset input
};

const removeTag = (index) => {
  formData.tags.splice(index, 1);
};

onMounted(() => {
  errors.value = {};
});
</script>

<style></style>
