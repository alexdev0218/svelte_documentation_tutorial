<h1>Basic Svelte</h1>

<ul>
	<li><a href="/basic">Basic</a></li>
	<li><a href="/chatbot">Chatbot</a></li>
	<li><a href="/stores">Stores</a></li>
</ul>


<style>

	h1 {
		color: #ff3e00;
		text-align: center;
		margin-bottom: 20px;
		
	}

	ul {
		list-style-type: none;
		padding: 0;
		display: flex;
		justify-content: space-around;
		max-width: 600px;
		margin: 0 auto;
	}

	li {
		background-color: #f4f4f4;
		padding: 10px 20px;
		border-radius: 5px;
		transition: background-color 0.3s ease;
	}

	li:hover {
		background-color: #ff3e00;
	}

	a {
		text-decoration: none;
		color: #333;
		font-weight: bold;
	}

	li:hover a {
		color: white;
	}
</style>
