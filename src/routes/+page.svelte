<script lang="ts">
	import { user } from '$lib/supabase';
</script>

<div class="py-12">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
		<div class="text-center">
			<h1 class="text-4xl font-extrabold text-gray-900 sm:text-5xl sm:tracking-tight lg:text-6xl">
				SvelteKit + Supabase Starter
			</h1>
			<p class="mt-5 max-w-xl mx-auto text-xl text-gray-500">
				A modern web application starter template with authentication, real-time data, and more.
			</p>
			<div class="mt-8 flex justify-center">
				{#if $user}
					<a
						href="/dashboard"
						class="px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700"
					>
						Go to Dashboard
					</a>
				{:else}
					<a
						href="/auth/login"
						class="px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 mr-4"
					>
						Log In
					</a>
					<a
						href="/auth/register"
						class="px-5 py-3 border border-transparent text-base font-medium rounded-md text-primary-600 bg-white hover:bg-gray-50 border-primary-600"
					>
						Register
					</a>
				{/if}
			</div>
		</div>
	</div>

	<div class="py-12 bg-white">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<div class="lg:text-center">
				<h2 class="text-base text-primary-600 font-semibold tracking-wide uppercase">Features</h2>
				<p class="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-gray-900 sm:text-4xl">
					Everything you need to build modern web apps
				</p>
			</div>

			<div class="mt-10">
				<div class="grid grid-cols-1 gap-10 sm:grid-cols-2 lg:grid-cols-3">
					<div class="p-6 bg-gray-50 rounded-lg">
						<h3 class="text-lg font-medium text-gray-900">Authentication</h3>
						<p class="mt-2 text-base text-gray-500">
							Secure user authentication with email/password, social providers, and more via Supabase Auth.
						</p>
					</div>

					<div class="p-6 bg-gray-50 rounded-lg">
						<h3 class="text-lg font-medium text-gray-900">Database</h3>
						<p class="mt-2 text-base text-gray-500">
							PostgreSQL database with real-time capabilities, powered by Supabase's battle-tested infrastructure.
						</p>
					</div>

					<div class="p-6 bg-gray-50 rounded-lg">
						<h3 class="text-lg font-medium text-gray-900">Modern Stack</h3>
						<p class="mt-2 text-base text-gray-500">
							Built with SvelteKit, TypeScript, and Tailwind CSS for a modern developer experience.
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
