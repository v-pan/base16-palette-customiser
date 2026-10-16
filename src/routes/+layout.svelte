<script lang="ts">
	import './layout.css';
	import favicon from '#lib/assets/favicon.svg';
	import type { LayoutProps } from './$types';
	import { ModeWatcher, toggleMode } from 'mode-watcher';
	import { Button } from '../lib/components/ui/button';
	import { SunIcon, MoonIcon } from '@lucide/svelte';

	let { children }: LayoutProps = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<ModeWatcher/>

<header>
	<h1 class="scroll-m-20 text-4xl font-heading text-center font-extrabold tracking-tight text-balance">Base 16 Palette Editor</h1>

	<Button onclick={toggleMode} variant="outline" size="icon">
		<SunIcon
			class="h-[1.2rem] w-[1.2rem] scale-100 rotate-0 !transition-all dark:scale-0 dark:-rotate-90"
		/>
		<MoonIcon
			class="absolute h-[1.2rem] w-[1.2rem] scale-0 rotate-90 !transition-all dark:scale-100 dark:rotate-0"
		/>
		<span class="sr-only">Toggle theme</span>
	</Button>
</header>

<main>
	{@render children()}
</main>
