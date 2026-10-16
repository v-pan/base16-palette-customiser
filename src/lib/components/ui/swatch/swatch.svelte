<script lang="ts">
    import Color from "colorjs.io";
    import Button from "../button/button.svelte";
    import Input from "../input/input.svelte";
    import { mode } from "mode-watcher";
    import { untrack } from "svelte";
	import type { HTMLButtonAttributes } from "svelte/elements";

    let {name, color = $bindable(new Color("#000")), ...buttonProps}: { name: string, color: Color, onChange?: (value: Color) => void } & Omit<HTMLButtonAttributes, "color"> = $props();

    let focus = $state(false);

    let colorHex = $derived(color.display({ format: "hex", collapse: false }).toUpperCase());
    let is_dark = $derived(color.luminance < 0.5);

    let textClass = $derived.by(() => {
        if (mode.current == "light") {
            if (is_dark) {
                return "text-accent"
            } else {
                return "text-primary"
            }
        } else {
            if (is_dark) {
                return "text-primary"
            } else {
                return "text-accent"
            }
        }
    });

    // svelte-ignore state_referenced_locally
    let inputValue = $state(colorHex);

    $effect(() => {
        color;
        if (untrack(() => !focus)) {
            inputValue = colorHex;
        }
    });

    const parse = (str: string): Color | null => {
        try {
            const color = new Color(str);

            return color;
        } catch (e) {
            return null;
        }
    }
</script>

<Button
    size="xl"
    class="p-6 shadow-[inset_0px_-0.5rem_0px_0px_#00000024] {textClass}"
    style="background-color: {color.display()};"

    {...buttonProps}
>
    <div class="flex flex-col max-w-20">
        <span class="text-xl font-heading">{name}</span>
        <Input
            class="field-sizing-content border-b-0 focus-visible:border-b-0"
            onfocus={() => { focus = true; }}
            onblur={() => { focus = false; }}

            bind:value={
                () => inputValue,
                (v) => {
                    inputValue = v;

                    const parsed = parse(v);
                    if (parsed) {
                        color = parsed;
                    }
                }
            }
        />
    </div>
</Button>