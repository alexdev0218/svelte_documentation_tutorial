<script>
	import Nested from './nested.svelte';
	import PackageInfo from '$lib/PackageInfo.svelte';

	const pkg = {
		name: 'svelte',
		speed: 'blazing',
		version: 4,
		website: 'https://svelte.dev'
	};

	let name = '<strong> Alex </strong>';
	let src =
		'https://cdn.pficdn.com/cms1/pgim4/sites/default/files/styles/768x500_16_9_/public/2022-05/Cryptocurrency-investing-megatrends-chapter-3.jpg';
	let count = 0;
	let numbers = [1, 2, 3, 4];
	let colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange', 'pink'];
	let selected = colors[0];
	$: doubled = count * 2;

	function increment() {
		count += 1;
	}

	function addNumber() {
		numbers = [...numbers, numbers.length + 1];
	}

	$: sum = numbers.reduce((total, currentNumber) => total + currentNumber, 0);
</script>

<PackageInfo {...pkg} />

<h1>Hello {@html name.toUpperCase()}!</h1>
<img {src} alt="background crypto img" />
<p>This is a paragraph</p>

<Nested answer={42} />
<Nested />

<button on:click={increment}>
	Clicked {count}
	{count === 1 ? 'time' : 'times'}
</button>

<p>{count} doubled is {doubled}</p>
{#if count > 10}
	<p>{count} is greater than 10</p>
{:else if count < 5}
	<p>{count} is less than 5</p>
{:else}
	<p>{count} is between 5 and 10</p>
{/if}

<p>{numbers.join(' + ')} = {sum}</p>
<button on:click={addNumber}>Add a Number</button>

<h1 style="color: {selected}">Pick a colour</h1>
<div class="color-picker">
	{#each colors as color, i}
		<button
			class="color-button"
			aria-current={selected === color}
			aria-label={color}
			style="background: {color}"
			on:click={() => (selected = color)}>{i + 1}</button
		>
	{/each}
</div>

<style>
	p {
		color: goldenrod;
		font-family: 'Comic Sans MS', cursive;
		font-size: 2em;
	}
	h1 {
		transition: color 0.2s;
	}

	.color-picker {
		display: grid;
		grid-template-columns: repeat(7, 1fr);
		grid-gap: 5px;
		max-width: 400px;
	}

	.color-button {
		aspect-ratio: 1;
		border-radius: 50%;
		background: var(--color, #fff);
		transform: translate(-2px, -2px);
		filter: drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2));
		transition: all 0.1s;
	}

	.color-button[aria-current='true'] {
		transform: none;
		filter: none;
		box-shadow: inset 3px 3px 4px rgba(0, 0, 0, 0.2);
	}
</style>
