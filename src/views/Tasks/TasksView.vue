<script setup>
import { storeToRefs } from "pinia";
import { useAuthStore } from "@/stores/auth";
import { useTasksStore } from "@/stores/tasks";
import { ref, reactive, onMounted, onBeforeMount } from "vue";
import CreateTask from "./components/CreateTask.vue";
import { useQuasar } from "quasar";

const { tasks } = storeToRefs(useTasksStore());
const { getUserTasks, deleteUserTask } = useTasksStore();
const authStore = useAuthStore();
getUserTasks(authStore.user.id);
const listTask = tasks;
const $q = useQuasar();

const filterOptions = reactive({
  completed: "",
  priority: "",
  due_date_from: "",
  due_date_to: "",
  archived: 1,
  searchTitle: "",
});

const prioOptions = [
  { label: "Urgent", value: "1" },
  { label: "High", value: "2" },
  { label: "Normal", value: "3" },
  { label: "Low", value: "4" },
];
const compOptions = [
  { label: "Completed", value: "2" },
  { label: "Not Completed", value: "1" },
  { label: "None", value: "0" },
];

const sortOptions = [
  { label: "Due Date", value: "due_date" },
  { label: "Priority", value: "priority" },
  { label: "Title", value: "title" },
  { label: "Order", value: "order" },
];

const pagination = ref({
  page: 1,
  rowsPerPage: 5,
  rowsNumber: 3,
});

const columns = [
  {
    name: "title",
    required: true,
    align: "left",
    field: (row) => row.title,
    sortable: true,
    label: "Title",
  },
  {
    name: "description",
    align: "center",
    label: "Description",
    field: (row) => row.description,
  },
  { name: "due_date", label: "Due Date", sortable: true, field: (row) => row.due_date },
  { name: "priority", label: "Priority", field: (row) => row.name },
  { name: "attachment", label: "Attachment", field: (row) => row.attachment_name },
  { name: "tags", label: "Tags", field: (row) => row.tags },
  {
    name: "completed",
    label: "Completed",
    field: (row) => (row.completed == 1 ? "Yes" : "No"),
  },
  { name: "created_at", labe: "Created at", field: (row) => row.created_at },
  { name: "actions", label: "Actions" },
];

const onDelete = (id) => {
  deleteUserTask(id);
};

const newTask = () => {
  $q.dialog({
    component: CreateTask,
  });
};
</script>

<template>
  <q-page class="row">
    <div class="col">
      <q-table
        title="My Tasks"
        :rows="listTask"
        :columns="columns"
        row-key="id"
        flat
        v-model:pagination="pagination"
      >
        <template #top-right>
          <div>
            <q-btn
              color="primary"
              icon="add_circle"
              label="Create Task"
              @click="newTask()"
            ></q-btn>
          </div>
        </template>

        <template #top-left>
          <q-btn-dropdown color="primary" label="Filter">
            <q-list class="rounded-borders" dense bordered padding>
              <q-item-label header class="q-pb-sm">Completed?</q-item-label>
              <q-item>
                <q-item-section>
                  <q-select
                    class="q-mb-sm"
                    dense
                    v-model="filterOptions.completed"
                    :options="compOptions"
                  />
                </q-item-section>
              </q-item>

              <q-separator spaced />

              <q-item-label header class="q-pb-sm">Priority Level</q-item-label>
              <q-item>
                <q-item-section>
                  <q-select
                    class="q-mb-sm"
                    dense
                    v-model="filterOptions.priority"
                    :options="prioOptions"
                  />
                </q-item-section>
              </q-item>

              <q-separator spaced />

              <q-item-label header class="q-pb-sm">Due Date</q-item-label>
              <q-item>
                <q-item-section>
                  <q-input
                    dense
                    v-model="filterOptions.due_date_from"
                    mask="date"
                    label="From"
                  >
                    <template v-slot:append>
                      <q-icon name="event" class="cursor-pointer">
                        <q-popup-proxy
                          cover
                          transition-show="scale"
                          transition-hide="scale"
                        >
                          <q-date v-model="filterOptions.due_date_from">
                            <div class="row items-center justify-end">
                              <q-btn v-close-popup label="Close" color="primary" flat />
                            </div>
                          </q-date>
                        </q-popup-proxy>
                      </q-icon>
                    </template>
                  </q-input>
                  <q-input
                    class="q-mt-sm q-mb-sm"
                    dense
                    v-model="filterOptions.due_date_to"
                    mask="date"
                    label="To"
                  >
                    <template v-slot:append>
                      <q-icon name="event" class="cursor-pointer">
                        <q-popup-proxy
                          cover
                          transition-show="scale"
                          transition-hide="scale"
                        >
                          <q-date v-model="filterOptions.due_date_to">
                            <div class="row items-center justify-end">
                              <q-btn v-close-popup label="Close" color="primary" flat />
                            </div>
                          </q-date>
                        </q-popup-proxy>
                      </q-icon>
                    </template>
                  </q-input>
                </q-item-section>
              </q-item>

              <q-item class="q-mt-md justify-end">
                <q-btn class="" label="Apply" color="primary"></q-btn>
              </q-item>
            </q-list>
          </q-btn-dropdown>
          <q-input
            class="q-ml-sm"
            dense
            v-model="filterOptions.searchTitle"
            label="Search Title"
          >
            <template v-slot:append>
              <q-icon clickable v-ripple name="search" />
            </template>
          </q-input>
        </template>

        <template #body-cell-actions="props">
          <q-td :props="props">
            <q-btn
              icon="mode_edit"
              :to="{ name: 'update', params: { id: props.row.id } }"
            ></q-btn>
            <q-btn icon="delete" @click="onDelete(props.row.id)"></q-btn>
          </q-td>
        </template>
      </q-table>
    </div>
  </q-page>
</template>
