<script>
	import Eliza from 'elizabot'; // Importa la librería Eliza
	import { beforeUpdate, afterUpdate } from 'svelte';

	let div;
	let autoscroll = false;

	beforeUpdate(() => {
		if (div) {
			const scrollableDistance = div.scrollHeight - div.offsetHeight;
			autoscroll = div.scrollTop > scrollableDistance - 20;
		}
	});

	afterUpdate(() => {
		if (autoscroll) {
			div.scrollTo(0, div.scrollHeight);
		}
	});

	// Inicializa Eliza
	const eliza = new Eliza();
	const pause = (ms) => new Promise((fulfil) => setTimeout(fulfil, ms));

	const typing = { author: 'eliza', text: '...' };

	// Array para los comentarios del chat
	let comments = [];

	// Manejo de la entrada del usuario
	async function handleKeydown(event) {
		if (event.key === 'Enter' && event.target.value) {
			const comment = {
				author: 'user',
				text: event.target.value
			};

			// Genera la respuesta de Eliza
			const reply = {
				author: 'eliza',
				text: eliza.transform(comment.text)
			};

			event.target.value = '';
			comments = [...comments, comment];

			// Añade un pequeño retraso para simular la escritura de Eliza
			await pause(200 * (1 + Math.random()));
			comments = [...comments, typing];

			await pause(500 * (1 + Math.random()));
			comments = [...comments, reply].filter((comment) => comment !== typing);
		}
	}
</script>

<div class="container">
	<div class="phone">
		<div class="chat" bind:this={div}>
			<header>
				<h1>Eliza</h1>
				<article class="eliza">
					<span>{eliza.getInitial()}</span>
					<!-- Mensaje de bienvenida de Eliza -->
				</article>
			</header>

			{#each comments as comment}
				<article class={comment.author}>
					<span>{comment.text}</span>
					<!-- Muestra los comentarios en el chat -->
				</article>
			{/each}
		</div>

		<input on:keydown={handleKeydown} placeholder="Type your message..." />
		<!-- Entrada para los mensajes -->
	</div>
</div>

<style>
	.container {
		display: grid;
		place-items: center;
		height: 100vh;
	}

	.phone {
		display: flex;
		flex-direction: column;
		width: 100%;
		max-width: 400px;
		height: 600px;
		background: var(--bg-2);
		border: 2px solid #222;
		border-radius: 16px;
		overflow: hidden;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}

	header {
		display: flex;
		flex-direction: column;
		padding: 1em;
		background-color: #333;
		color: white;
		box-sizing: border-box;
	}

	h1 {
		margin: 0;
		font-size: 1.2em;
		text-align: center;
	}

	.chat {
		flex: 1;
		padding: 1em;
		overflow-y: auto;
		scroll-behavior: smooth;
	}

	article {
		margin-bottom: 0.5em;
	}

	.eliza span,
	.user span {
		display: inline-block;
		padding: 0.5em 1em;
		border-radius: 12px;
		word-break: break-word;
	}

	.eliza span {
		background-color: var(--bg-1, #f4f4f4);
		color: var(--fg-1, #000);
		border-radius: 12px 12px 12px 0;
	}

	.user span {
		background-color: #0074d9;
		color: white;
		border-radius: 12px 12px 0 12px;
		text-align: right;
	}

	input {
		padding: 1em;
		border: none;
		border-top: 1px solid #ccc;
		font-size: 1em;
		box-sizing: border-box;
	}
</style>
