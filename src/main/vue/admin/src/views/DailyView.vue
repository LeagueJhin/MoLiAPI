<script async lang="ts" setup>
import {get, post} from '@/util/request'
import {ref} from 'vue'
// @ts-ignore
import calendar from '@/util/lunnerDay'
import type {CalendarInstance} from 'element-plus'
import type {DailyMap} from '@/type/Daily'

const res = await get('daily/check')
const signed = ref(true)
if (!res || res.length == 0) {
  signed.value = false
}
// res 当日签到的数组 长度为0时未签到
const url = ref('')
const param = await get('daily/param')
const month = ref<Date>(new Date())
const options = ref<Array<string>>()
const calendarInstance = ref<CalendarInstance>()
const dailyMap = ref<DailyMap>({})
if (param) {
  options.value = [...param.urls]
} else {
  options.value = ['testa', 'testb']
}
const sign = async () => {
  const dailyList = await get('daily?key=moli')
  for (let i of dailyList) {
    window.open(i, '_blank')
  }
  const signResult = await post('daily/signed', dailyList)
  console.log('签到结果: ', signResult ? '成功' : '失败')
}
const change = async () => {
  query()
}

const query = async () => {
  const date = new Date(month.value)
  const firstDayOfMonth = new Date(date.getFullYear(), date.getMonth(), 1)
  const lastDayOfMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0)
  let requestUrl =
    'daily/query?startDate=' +
    firstDayOfMonth.toLocaleDateString() +
    '&endDate=' +
    lastDayOfMonth.toLocaleDateString()
  if (url.value) {
    requestUrl = requestUrl + '&urls=' + url.value
  }
  dailyMap.value = await get(requestUrl)
}
query()

const randomMusic = async () => {
  const musicLink = await get('music/random', {
    headers: {
      'cache-control': 'no-store',
      'pragma': 'no-store',
      'sec-fetch-mode': 'no-cors'
    }
  })
  window.open(musicLink, '_blank')
}
</script>

<template>
  <div style="width: 100%; height: 100vh">
    <el-calendar ref="CalendarInstance" v-model="month">
      <template #date-cell="{ data }">
        <p :class="{
          'is-selected': data.isSelected,
          singed: dailyMap[data.day],
          'no-sign': !dailyMap[data.day] && new Date(data.day) < new Date()
        }">
          <span style="font-size: 28px; display: block; margin-top: 20px">{{
            calendar.solar2lunar(
              data.day.split('-')[0],
              data.day.split('-')[1],
              data.day.split('-')[2]
            ).cDay
          }}日</span>

          <br />
          <span style="font-size: 12px">{{
            calendar.solar2lunar(
              data.day.split('-')[0],
              data.day.split('-')[1],
              data.day.split('-')[2]
            ).IMonthCn
          }}-{{
              calendar.solar2lunar(
                data.day.split('-')[0],
                data.day.split('-')[1],
                data.day.split('-')[2]
              ).IDayCn
            }}</span>
        </p>
      </template>
      <template #header="{ date }">
        {{ date }}
        <span>
          <span style="margin-right: 20px"><span style="color: red">红色</span>: 未签到</span>
          <span><span style="color: green">绿色</span>: 已签到</span>
        </span>
        <div style="display: flex">
          <div class="block" style="margin-left: 20px">
            <span class="demonstration">url: </span>
            <el-select v-model="url" clearable multiple placeholder="Select" style="width: 240px" @change="change">
              <el-option v-for="item in options" :key="item" :label="item" :value="item" />
            </el-select>
          </div>
          <div class="block" style="margin-left: 20px">
            <span class="demonstration">月份: </span>
            <el-date-picker v-model="month" placeholder="Pick a month" type="month" @change="change" />
          </div>
        </div>
        <el-button :disabled="signed" round type="success" @click="sign">签到</el-button>
        <el-button @click="randomMusic"> 随机一首音乐</el-button>
      </template>
    </el-calendar>
  </div>
</template>

<style scoped>
:deep(.el-calendar-table) {
  height: 80vh;
  min-height: 100%;
}

:deep(.el-calendar-day) {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  text-align: center;
  height: 100%;
  width: 100%;
}
.demonstration{
  padding-right: 5px;
}
.singed {
  color: green;
}

.no-sign {
  color: red;
}
</style>
