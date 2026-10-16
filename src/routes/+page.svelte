<script lang="ts">
	import Color from "colorjs.io";
	import Swatch from "../lib/components/ui/swatch/swatch.svelte";
	import Input from "../lib/components/ui/input/input.svelte";
	import ColorPicker from "../lib/components/ui/color-picker/color-picker.svelte";

	let color = $state(new Color("#000"));

    let inputValue = $state("#000");
</script>

<Swatch name="Base 0" bind:color={color} onChange={
    (v) => {

    }
} />

<ColorPicker bind:color={color} />

<Input bind:value={
    () => inputValue,
    (v) => {
        inputValue = v;
        try {
            const newColor = new Color(v);
            color = newColor;
        } catch (e) { }
    }
} />