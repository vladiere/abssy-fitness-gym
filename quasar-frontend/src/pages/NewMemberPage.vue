<template>
  <q-page padding class="q-pb-xl fit">
    <!-- content -->
    <div v-if="!isClickedReg" class="column q-gutter-y-sm">
      <h1 class="text-center text-h6">ABBSY Fitness Gym Membership form</h1>
      <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
        <span class="text-h6">Member Details</span>
        <div class="row items-center">
          <q-input
            filled
            v-model="form.first_name"
            label="First Name"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter trainer first name']"
          />
          <q-input
            filled
            v-model="form.middle_name"
            label="Middle Name"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter trainer middle name']"
          />
          <q-input
            filled
            v-model="form.last_name"
            label="Last Name"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Enter trainer last name']"
          />
        </div>

        <div class="row items-center">
          <q-input
            filled
            v-model="form.phone_number"
            label="Phone Number"
            class="col-12 col-md q-mr-md"
            :rules="[
              (val) => !!val || 'Enter phone number',
              (val) =>
                validatePhoneNumber(val) ||
                'Mobile/Telephone number is invalid',
            ]"
          />
          <q-input
            type="email"
            filled
            v-model="form.email_address"
            label="E-mail"
            class="col-12 col-md"
            :rules="[
              (val) => !!val || 'Enter email address',
              (val) => validateEmailAddress(val) || 'Email address is invalid',
            ]"
          />
        </div>

        <div class="row items-center">
          <q-input
            type="date"
            filled
            v-model="form.date_of_birth"
            label="Date of Birth"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter date of birth']"
          />
          <q-select
            filled
            v-model="form.gender"
            :options="options"
            label="Select gender"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Select gender']"
          />
        </div>

        <div class="row items-center">
          <q-select
            label="Health Conditions"
            filled
            v-model="health_cond"
            use-input
            use-chips
            multiple
            bottom-slots
            hide-dropdown-icon
            input-debounce="0"
            new-value-mode="add-unique"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Enter health conditions']"
          >
            <template v-slot:hint>
              Just type 'none' if no health condition
            </template>
          </q-select>
        </div>

        <q-separator class="q-my-lg" />

        <span class="text-h6">Address Details</span>

        <div class="row items-center">
          <q-input
            filled
            v-model="form.street"
            label="Street"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter street address']"
          />
          <q-input
            filled
            v-model="form.brgy"
            label="Brgy"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Enter brgy address']"
          />
        </div>

        <div class="row items-center">
          <q-input
            filled
            v-model="form.city"
            label="City"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter city']"
          />
          <q-input
            filled
            v-model="form.province"
            label="Province"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Enter province']"
          />
        </div>

        <q-separator class="q-my-lg" />

        <span class="text-h6">Emergency Contact</span>

        <div class="row items-center">
          <q-input
            filled
            v-model="form.ec_first_name"
            label="First name"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter first name']"
          />
          <q-input
            filled
            v-model="form.ec_last_name"
            label="Last name"
            class="col-12 col-md"
            :rules="[(val) => !!val || 'Enter last name']"
          />
        </div>

        <div class="row items-center">
          <q-input
            filled
            v-model="form.ec_relationship"
            label="Relationship"
            class="col-12 col-md q-mr-md"
            :rules="[(val) => !!val || 'Enter relationship']"
          />
          <q-input
            filled
            v-model="form.ec_phone_number"
            label="Phone Number"
            class="col-12 col-md"
            :rules="[
              (val) => !!val || 'Enter phone number',
              (val) =>
                validatePhoneNumber(val) ||
                'Mobile/Telephone number in invalid',
            ]"
          />
        </div>

        <q-separator class="q-my-lg" />

        <span class="text-h6">Package</span>

        <div class="row q-mb-lg">
          <q-input
            filled
            readonly
            v-model="packages.package_name"
            label="Package"
            class="col-12 col-md-2 q-mr-md"
          />
          <q-input
            filled
            readonly
            v-model="packages.package_price"
            label="Price"
            class="col-12 col-md-2"
          />
        </div>

        <div class="row items-center">
          <q-toggle
            v-model="accept"
            label="I accept the license and terms"
            class="q-mr-md"
          />
          <q-btn
            flat
            dense
            rounded
            size="sm"
            icon="mdi-information"
            @click="basic = !basic"
          />
        </div>

        <div>
          <q-btn
            label="Submit"
            type="submit"
            color="secondary"
            :loading="isLoading"
          />
          <q-btn label="Reset" type="reset" color="dark" flat class="q-ml-sm" />
        </div>
      </q-form>
    </div>
    <div v-else class="fit column items-center justify-center">
      <p class="text-h6 text-md-h4">
        You have successfully register in ABBSY Fitness GYM
      </p>
      <p class="text-positive text-md-h5">
        Please check your email for verification.
      </p>
    </div>
  </q-page>

  <q-dialog
    v-model="basic"
    transition-show="scale"
    transition-hide="scale"
    persistent
  >
    <q-card>
      <q-card-section>
        <div class="text-h6">Terms of Agreement</div>
      </q-card-section>

      <q-card-section class="q-pt-none">
        <p v-for="n in 15" :key="n">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum
          repellendus sit voluptate voluptas eveniet porro. Rerum blanditiis
          perferendis totam, ea at omnis vel numquam exercitationem aut, natus
          minima, porro labore.
        </p>
      </q-card-section>

      <q-card-actions align="right">
        <q-btn flat label="Close" color="primary" v-close-popup />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Notify, debounce } from 'quasar';
import { useRouter } from 'vue-router';

import MemberService from 'src/services/member.service';
import { MemberForCreate } from 'src/types/member.type';
import {
  validatePhoneNumber,
  validateEmailAddress,
} from 'src/utils/validator.util';

const memberService = new MemberService();
const paymentUrl = ref('');
const isClickedReg = ref(false);
const options = ref(['male', 'female', 'other']);
const packages = ref<{
  package_id: number;
  package_name: string;
  package_price: number;
}>({
  package_id: 0,
  package_name: '',
  package_price: 0,
});
const isLoading = ref(false);
const basic = ref(false);
const health_cond = ref(null);
const router = useRouter();

const accept = ref(false);
const form = ref<MemberForCreate>({
  first_name: '',
  middle_name: '',
  last_name: '',
  phone_number: '',
  email_address: '',
  date_of_birth: '',
  gender: '',
  street: '',
  brgy: '',
  city: '',
  province: '',
  ec_first_name: '',
  ec_last_name: '',
  ec_relationship: '',
  ec_phone_number: '',
  package_id: 0,
  health_condition: '',
});

const onSubmit = async () => {
  isLoading.value = true;
  if (accept.value !== true) {
    isLoading.value = false;
    Notify.create({
      position: 'top-right',
      color: 'red-5',
      textColor: 'white',
      icon: 'mdi-alert',
      message: 'You need to accept the license and terms first',
    });
  } else {
    sendMemberForm();
  }
};

const sendMemberForm = debounce(() => {
  form.value.health_condition = health_cond.value.join(', ');
  form.value.package_id = packages.value.package_id;

  memberService.create(form.value).then((res) => {
    if (res.result.status !== 201) {
      return;
    }
    isClickedReg.value = true;
    isLoading.value = false;
  });
}, 1200);

const onReset = () => {
  accept.value = false;
};

onMounted(() => {
  packages.value.package_id = Number(router.currentRoute.value.query.pid);
  packages.value.package_name = String(router.currentRoute.value.query.package);
  packages.value.package_price = Number(router.currentRoute.value.query.p);
});
</script>
