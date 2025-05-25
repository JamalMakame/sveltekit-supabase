<!--
  Registration form component for new user signup
-->
<script lang="ts">
  import { signUp } from '$lib/supabase';
  import { goto } from '$app/navigation';
  
  let email = '';
  let password = '';
  let confirmPassword = '';
  let loading = false;
  let error = '';
  let success = '';
  
  async function handleSubmit() {
    if (!email || !password) {
      error = 'Please enter both email and password';
      return;
    }
    
    if (password !== confirmPassword) {
      error = 'Passwords do not match';
      return;
    }
    
    loading = true;
    error = '';
    success = '';
    
    try {
      const { data, error: authError } = await signUp(email, password);
      
      if (authError) {
        error = authError.message;
        return;
      }
      
      if (data) {
        success = 'Registration successful! Please check your email for verification.';
        // Alternatively, you can redirect the user
        // goto('/auth/login');
      }
    } catch (e: any) {
      error = e.message || 'An error occurred during registration';
    } finally {
      loading = false;
    }
  }
</script>

<div class="w-full max-w-md mx-auto">
  <form on:submit|preventDefault={handleSubmit} class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
    <h2 class="text-2xl font-bold mb-6 text-center text-primary-700">Register</h2>
    
    {#if error}
      <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4" role="alert">
        <span class="block sm:inline">{error}</span>
      </div>
    {/if}
    
    {#if success}
      <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4" role="alert">
        <span class="block sm:inline">{success}</span>
      </div>
    {/if}
    
    <div class="mb-4">
      <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
        Email
      </label>
      <input
        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        id="email"
        type="email"
        placeholder="Email"
        bind:value={email}
        required
      />
    </div>
    
    <div class="mb-4">
      <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
        Password
      </label>
      <input
        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        id="password"
        type="password"
        placeholder="******************"
        bind:value={password}
        required
      />
    </div>
    
    <div class="mb-6">
      <label class="block text-gray-700 text-sm font-bold mb-2" for="confirm-password">
        Confirm Password
      </label>
      <input
        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        id="confirm-password"
        type="password"
        placeholder="******************"
        bind:value={confirmPassword}
        required
      />
    </div>
    
    <div class="flex items-center justify-between">
      <button
        class="bg-primary-600 hover:bg-primary-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full"
        type="submit"
        disabled={loading}
      >
        {loading ? 'Loading...' : 'Sign Up'}
      </button>
    </div>
    
    <div class="text-center mt-4">
      <a href="/auth/login" class="text-primary-600 hover:underline">Already have an account? Login</a>
    </div>
  </form>
</div>
