<script lang="ts">
	import { user, supabase } from '$lib/supabase';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	
	// Redirect to login if not authenticated
	onMount(() => {
		if (!$user) {
			goto('/auth/login');
		}
	});
	
	let loading = false;
	let profileData = {
		username: '',
		fullName: '',
		avatarUrl: ''
	};
	
	// Load profile data from Supabase if needed
	// This is a placeholder for actual profile data loading
	// You would typically create a 'profiles' table in Supabase
	onMount(async () => {
		if ($user) {
			// Example: This is a placeholder for how you would fetch profile data
			// const { data, error } = await supabase
			//   .from('profiles')
			//   .select('username, full_name, avatar_url')
			//   .eq('id', $user.id)
			//   .single();
			
			// if (data) {
			//   profileData = {
			//     username: data.username || '',
			//     fullName: data.full_name || '',
			//     avatarUrl: data.avatar_url || ''
			//   };
			// }
			
			// For demo purposes, just use the email
			profileData.username = $user.email?.split('@')[0] || 'user';
		}
	});
	
	async function updateProfile() {
		if (!$user) return;
		
		loading = true;
		
		try {
			// Example of how you would update a profile
			// const { error } = await supabase
			//   .from('profiles')
			//   .upsert({
			//     id: $user.id,
			//     username: profileData.username,
			//     full_name: profileData.fullName,
			//     avatar_url: profileData.avatarUrl,
			//     updated_at: new Date()
			//   });
			
			// if (error) throw error;
			
			// For demo purposes, just show success
			alert('Profile updated successfully!');
		} catch (error: any) {
			alert(error.message);
		} finally {
			loading = false;
		}
	}
</script>

<div class="py-6">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
		<h1 class="text-2xl font-semibold text-gray-900">Your Profile</h1>
		
		{#if $user}
			<div class="mt-4 md:grid md:grid-cols-3 md:gap-6">
				<div class="md:col-span-1">
					<div class="px-4 sm:px-0">
						<h3 class="text-lg font-medium leading-6 text-gray-900">Personal Information</h3>
						<p class="mt-1 text-sm text-gray-600">
							Update your account profile information and settings.
						</p>
					</div>
				</div>
				
				<div class="mt-5 md:mt-0 md:col-span-2">
					<form onsubmit={(e) => { e.preventDefault(); updateProfile(); }}>
						<div class="shadow overflow-hidden sm:rounded-md">
							<div class="px-4 py-5 bg-white sm:p-6">
								<div class="grid grid-cols-6 gap-6">
									<div class="col-span-6 sm:col-span-4">
										<label for="email" class="block text-sm font-medium text-gray-700">Email address</label>
										<input
											type="text"
											name="email"
											id="email"
											value={$user.email || ''}
											disabled
											class="mt-1 focus:ring-primary-500 focus:border-primary-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md bg-gray-100"
										/>
										<p class="mt-1 text-xs text-gray-500">Email cannot be changed</p>
									</div>
									
									<div class="col-span-6 sm:col-span-4">
										<label for="username" class="block text-sm font-medium text-gray-700">Username</label>
										<input
											type="text"
											name="username"
											id="username"
											bind:value={profileData.username}
											class="mt-1 focus:ring-primary-500 focus:border-primary-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
										/>
									</div>
									
									<div class="col-span-6 sm:col-span-4">
										<label for="fullName" class="block text-sm font-medium text-gray-700">Full name</label>
										<input
											type="text"
											name="fullName"
											id="fullName"
											bind:value={profileData.fullName}
											class="mt-1 focus:ring-primary-500 focus:border-primary-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
										/>
									</div>
									
									<div class="col-span-6 sm:col-span-4">
										<label for="avatarUrl" class="block text-sm font-medium text-gray-700">
											Avatar URL
										</label>
										<input
											type="text"
											name="avatarUrl"
											id="avatarUrl"
											bind:value={profileData.avatarUrl}
											class="mt-1 focus:ring-primary-500 focus:border-primary-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
										/>
									</div>
								</div>
							</div>
							
							<div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
								<button
									type="submit"
									disabled={loading}
									class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
								>
									{loading ? 'Saving...' : 'Save'}
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			
			<div class="hidden sm:block" aria-hidden="true">
				<div class="py-5">
					<div class="border-t border-gray-200"></div>
				</div>
			</div>
			
			<div class="mt-10 sm:mt-0 md:grid md:grid-cols-3 md:gap-6">
				<div class="md:col-span-1">
					<div class="px-4 sm:px-0">
						<h3 class="text-lg font-medium leading-6 text-gray-900">Account Security</h3>
						<p class="mt-1 text-sm text-gray-600">
							Update your password and account security settings.
						</p>
					</div>
				</div>
				
				<div class="mt-5 md:mt-0 md:col-span-2">
					<div class="shadow overflow-hidden sm:rounded-md">
						<div class="px-4 py-5 bg-white sm:p-6">
							<div class="grid grid-cols-6 gap-6">
								<div class="col-span-6 sm:col-span-4">
									<button 
										type="button"
										class="text-primary-600 hover:text-primary-700 underline text-left"
										onclick={() => {
											// This would typically open a modal or navigate to a password reset page
											// For demo purposes, just show an alert
											alert('Password reset functionality would be implemented here');
										}}
									>
										Change password
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		{:else}
			<div class="mt-4 bg-white shadow overflow-hidden rounded-lg p-6">
				<p class="text-gray-500">Loading profile...</p>
			</div>
		{/if}
	</div>
</div>
