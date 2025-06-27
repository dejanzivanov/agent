<template>
  <div class="grid grid-cols-2 sm:grid-cols-5 gap-4">
    <div v-for="(button, index) in buttons" :key="index" class="relative flex justify-center">
      <button
        class="text-white font-semibold py-2 px-4 rounded w-full"
        :style="{ backgroundColor: button.color }"
        @click="showNumber(index)"
      >
        Button {{ index + 1 }}
      </button>
      <div class="absolute bottom-full left-0 right-0 flex flex-col items-center pointer-events-none overflow-visible">
        <transition-group name="pop" tag="div">
          <div v-for="pop in button.pops" :key="pop.id" class="relative">
            <span :style="{ color: button.color }" class="font-bold">{{ pop.number }}</span>
          </div>
        </transition-group>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

function randomColor() {
  return `hsl(${Math.floor(Math.random()*360)},70%,60%)`;
}

const buttons = ref(Array.from({ length: 10 }, () => ({ color: '', pops: [] })));

function assignColors() {
  const used = new Set();
  buttons.value.forEach(btn => {
    let color;
    do {
      color = randomColor();
    } while (used.has(color));
    used.add(color);
    btn.color = color;
  });
}
assignColors();

function showNumber(index) {
  const btn = buttons.value[index];
  const pop = { id: Date.now() + Math.random(), number: Math.floor(Math.random()*100) + 1 };
  btn.pops.push(pop);
  setTimeout(() => {
    btn.pops = btn.pops.filter(p => p.id !== pop.id);
  }, 1000);
}
</script>

<style scoped>
.pop-enter-from { opacity: 0; transform: translateY(0); }
.pop-enter-to   { opacity: 1; transform: translateY(-20px); }
.pop-leave-from { opacity: 1; transform: translateY(-20px); }
.pop-leave-to   { opacity: 0; transform: translateY(-40px); }
.pop-enter-active,
.pop-leave-active { transition: all 0.5s ease-out; }
</style>
