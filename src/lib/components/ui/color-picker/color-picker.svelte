<script lang="ts">
	import Color from "colorjs.io";
	import Card from "../card/card.svelte";
	import Slider from "../slider/slider.svelte";
	import { untrack } from "svelte";

    let {color = $bindable(new Color("hwb", [20, 100, 100])), ...props}: { color?: Color, onChange?: (color: Color) => void } = $props();

    let hue = $derived(color.hwb.h);
    let gradientColor = $derived(new Color("hwb", [hue, 0, 0]))
    let x = $state(color.hwb.w ?? 0);
    let y = $state(color.hwb.b ?? 0);

    $effect(() => {
        color = new Color("hsv", [hue, x, 100 - y]);
    });
</script>

<Card class="p-6 grid grid-cols-[max-content_max-content] grid-rows-[1fr_max-content]">
    <Slider
        type="single"
        orientation="vertical"
        dir="rtl"
        max={100}
        bind:value={y}
    />
    <div class="relative isolate w-40 h-40">
        <div class="
        absolute top-0 left-0 w-full h-full
        before:block before:absolute before:inset-0 before:-z-10 before:w-full before:h-full before:bg-linear-to-r before:from-0% before:from-white before:to-(--gradient-to) before:to-100%
        after:block after:absolute after:inset-0 after: -z-10 after:bg-linear-to-b after:from-0% after:from-transparent after:to-black after:to-100%
        "
        style={`--gradient-to: ${gradientColor.display()};`}
        ></div>
        
        <div class="absolute w-2 h-2 bg-transparent border border-black -translate-x-1/2 -translate-y-1/2" style={`left: ${x}%; top: ${y}%;`}></div>
    </div>
    <div></div>
    <Slider type="single" dir="rtl" max={100} bind:value={() => 100 - x, (v) => x = 100 - v} />
</Card>