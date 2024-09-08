<slot />

<style>
	:global(*) {
		--background-color: #202020; /* Fondo oscuro para contraste */
		--foreground: #2a2a2a; /* Fondo intermedio */
		--background: #121212; /* Fondo base */
		--primary: #ff3e00; /* Naranja del logo de Svelte */
		--secondary: #ff6b4c; /* Un tono más claro de naranja */
		--tertiary: #ffb599; /* Tono aún más claro para acentos */
		--quaternary: #f0f0f0; /* Blanco suave para textos */
		--border: #404040; /* Borde gris oscuro */
		--shadow: rgba(0, 0, 0, 0.5); /* Sombra definida */
		--color: #ffffff; /* Texto principal */
	}

	:global(body) {
		background-color: var(--background-color);
		color: var(--color);
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
	}
	:global(select) {
		background-color: var(--background-color);
		color: var(--color);
	}

	:global(button) {
		background: var(--primary);
		color: var(--color);
		border: 1px solid var(--border);
		border-radius: 4px;
		padding: 10px 15px;
		cursor: pointer;
		transition:
			background 0.3s,
			transform 0.2s;
		min-width: 60px;
		font-size: 1.05em;
	}

	:global(button:hover) {
		background: var(--secondary);
		transform: scale(1.05);
	}

	:global(button:disabled) {
		background: var(--border);
		color: #6c757d;
		border: 1px solid var(--border);
		opacity: 0.6;
		cursor: not-allowed;
	}

	:global(input, textarea) {
		background: var(--foreground);
		color: var(--color);
		border: 1px solid var(--border);
		padding: 8px;
		border-radius: 4px;
	}

	:global(a) {
		color: var(--primary);
		text-decoration: none;
	}

	:global(a:hover) {
		text-decoration: underline;
	}

	:global(.card) {
		background: var(--foreground);
		border: 1px solid var(--border);
		border-radius: 8px;
		box-shadow: 0 4px 8px var(--shadow);
		padding: 16px;
		margin: 16px 0;
	}
</style>
