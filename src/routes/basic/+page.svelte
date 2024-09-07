<script>
	import Nested from '../../components/nested.svelte';
	import Thing from '../../components/thing.svelte';
	import Outter from '../../components/outter.svelte';
	import PackageInfo from '../../components/package-info.svelte';
	import BigRedButton from '../../components/big-red-button.svelte';
	import { getRandomPokemon } from '../../services/get-random-pokemon.js';
	import { paint } from '$lib/gradient.js';
	import { browser } from '$app/environment';
	import { onMount } from 'svelte';
	import { tick } from 'svelte';

	onMount(() => {
		const canvas = document.querySelector('canvas');
		const context = canvas.getContext('2d');

		let frame = requestAnimationFrame(function loop(t) {
			frame = requestAnimationFrame(loop);
			paint(context, t);
		});

		return () => {
			cancelAnimationFrame(frame);
		};
	});
	/**
	 * @type {HTMLAudioElement}
	 */
	let audio;

	const pkg = {
		name: 'svelte',
		speed: 'blazing',
		version: 4,
		website: 'https://svelte.dev'
	};

	let name = 'Alex';
	let count = 0;
	let numbers = [1, 2, 3, 4];
	let colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange', 'pink'];
	let selected = colors[0];
	let things = [
		{ id: 1, name: 'apple' },
		{ id: 2, name: 'banana' },
		{ id: 3, name: 'carrot' },
		{ id: 4, name: 'doughnut' },
		{ id: 5, name: 'egg' }
	];
	let promise = getRandomPokemon();
	let pointerMove = { x: 0, y: 0 };
	let a = 1;
	let b = 2;
	let yes = false;
	let questions = [
		{
			id: 1,
			text: `Where did you go to school?`
		},
		{
			id: 2,
			text: `What is your mother's name?`
		},
		{
			id: 3,
			text: `What is another personal fact that an attacker could easily find with Google?`
		}
	];
	/**
	 * @type {{ id: any; text: any; }}
	 */
	let selectedQuestion;
	let answerQuestion = '';
	let scoops = 1;
	/**
	 * @type { any[]}
	 */
	let flavours = [];
	let value = `Some words are *italic*, some are **bold**\n\n- lists\n- are\n- cool`;
	let textToUppercase = `Select some text and hit the tab key to toggle uppercase`;

	const formatter = new Intl.ListFormat('en', { style: 'long', type: 'conjunction' });

	$: doubled = count * 2;
	$: sum = numbers.reduce((total, currentNumber) => total + currentNumber, 0);

	function increment() {
		count += 1;
	}

	function addNumber() {
		numbers = [...numbers, numbers.length + 1];
	}

	function handleClickThings() {
		things = things.slice(1);
	}

	function handleClickRandomPokemon() {
		promise = getRandomPokemon();
	}

	/**
	 * @param {{ detail: { text: any; }; }} event
	 */
	function handleInnerOutterEventsMessage(event) {
		alert(event.detail.text);
	}

	function handleHornClick() {
		if (browser) {
			if (!audio) {
				audio = new Audio('/audio/horn.wav');
			}
			audio.play();
		}
	}

	function handleQuestionSubmit() {
		alert(
			`answered question ${selectedQuestion.id} (${selectedQuestion.text}) with "${answerQuestion}"`
		);
	}

	async function handleUppercaseKeydown(event) {
		if (event.key !== 'Tab') return;

		event.preventDefault();

		const { selectionStart, selectionEnd, value } = this;
		const selection = value.slice(selectionStart, selectionEnd);

		const replacement = /[a-z]/.test(selection) ? selection.toUpperCase() : selection.toLowerCase();

		textToUppercase = value.slice(0, selectionStart) + replacement + value.slice(selectionEnd);

		await tick();
		this.selectionStart = selectionStart;
		this.selectionEnd = selectionEnd;
	}
</script>

<PackageInfo {...pkg} />
<h1>Hello {name.toUpperCase()}!</h1>
<canvas width={16} height={16}></canvas>
<p>This is a paragraph</p>

<Nested answer={'42'} />
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

<div>
	<h1>Fruits</h1>
	{#each things as thing (thing.id)}
		<Thing name={thing.name} />
	{/each}
	<button on:click={handleClickThings}> Remove first thing </button>
</div>

<button on:click={handleClickRandomPokemon}> Get a random pokemon </button>

{#await promise}
	<p>...waiting</p>
{:then pokemon}
	<p>The pokemon name is {pokemon.name}</p>
	<img src={pokemon.sprites.front_default} alt="front pokemon" />
{:catch error}
	<p style="color: red">{error.message}</p>
{/await}

<div
	class="div-pointer-move"
	on:pointermove={(e) => {
		pointerMove = { x: e.clientX, y: e.clientY };
	}}
>
	The pointer is at {pointerMove.x} x {pointerMove.y}
</div>

<button on:click|once={() => alert('clicked')}> Click me Once </button>
<Outter on:message={handleInnerOutterEventsMessage} />

<p>Sound Button</p>
<p />
<BigRedButton on:click={handleHornClick} />

<div>
	<input bind:value={name} />
	<h1>Hello {name}!</h1>
</div>

<div>
	<label>
		<input type="number" bind:value={a} min="0" max="10" />
		<input type="range" bind:value={a} min="0" max="10" />
	</label>

	<label>
		<input type="number" bind:value={b} min="0" max="10" />
		<input type="range" bind:value={b} min="0" max="10" />
	</label>

	<p>{a} + {b} = {a + b}</p>
</div>

<div>
	<label>
		<input type="checkbox" bind:checked={yes} />
		Yes! Send me regular email spam
	</label>

	{#if yes}
		<p>Thank you. We will bombard your inbox and sell your personal details.</p>
	{:else}
		<p>You must opt in to continue. If you're not paying, you're the product.</p>
	{/if}
	<button disabled={!yes}>Subscribe</button>
</div>

<div>
	<h2>Insecurity questions</h2>

	<form on:submit|preventDefault={handleQuestionSubmit}>
		<select bind:value={selectedQuestion} on:change={() => (answerQuestion = '')}>
			{#each questions as question}
				<option value={question}>
					{question.text}
				</option>
			{/each}
		</select>

		<input bind:value={answerQuestion} />

		<button disabled={!answerQuestion} type="submit"> Submit </button>
	</form>

	<p>
		selected question {selectedQuestion ? selectedQuestion.id : '[waiting...]'}
	</p>
</div>

<div>
	<h2>Size</h2>

	{#each [1, 2, 3] as number}
		<label>
			<input type="radio" name="scoops" value={number} bind:group={scoops} />

			{number}
			{number === 1 ? 'scoop' : 'scoops'}
		</label>
	{/each}

	<h2>Flavours</h2>

	<select multiple bind:value={flavours}>
		{#each ['cookies and cream', 'mint choc chip', 'raspberry ripple'] as flavour}
			<option>{flavour}</option>
		{/each}
	</select>

	{#if flavours.length === 0}
		<p>Please select at least one flavour</p>
	{:else if flavours.length > scoops}
		<p>Can't order more flavours than scoops!</p>
	{:else}
		<p>
			You ordered {scoops}
			{scoops === 1 ? 'scoop' : 'scoops'}
			of {formatter.format(flavours)}
		</p>
	{/if}
</div>

<textarea bind:value></textarea>

<textarea value={textToUppercase} on:keydown={handleUppercaseKeydown} class="textareaUppercase"
></textarea>

<style>
	p {
		color: goldenrod;
		font-family: 'Comic Sans MS', cursive;
		font-size: 1.3em;
	}
	h1 {
		transition: color 0.2s;
	}
	div {
		margin-top: 20px;
		margin-bottom: 20px;
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

	.div-pointer-move {
		border: 1px blue solid;
		height: 300px;
		width: 300px;
		padding: 20px;
	}

	textarea {
		height: 200px;
		width: 50%;
	}

	canvas {
		/* position: fixed; */
		left: 0;
		top: 0;
		width: 25%;
		height: 25%;
		background-color: #666;
		mask: url(/images/svelte-logo.svg) 25% 25% no-repeat;
		mask-size: 30vmin;
		-webkit-mask: url(/images/svelte-logo.svg) 25% 25% no-repeat;
		-webkit-mask-size: 30vmin;
	}
	.textareaUppercase {
		width: 50%;
		height: 300px;
		resize: none;
	}
</style>
