# SvelteKit Supabase Starter Template

A modern web application starter template built with SvelteKit and Supabase, featuring authentication, real-time data capabilities, and a clean UI with Tailwind CSS.

## Features

- **Authentication**: Complete user authentication system with login and registration
- **Supabase Integration**: Real-time database, authentication, and storage capabilities
- **Responsive UI**: Modern user interface built with Tailwind CSS
- **TypeScript**: Type-safe development experience
- **Server-Side Rendering**: SSR support for improved SEO and performance
- **Protected Routes**: Automatic redirection for authenticated/unauthenticated users

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (version 18 or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/) or [pnpm](https://pnpm.io/)
- A [Supabase](https://supabase.com/) account

### Installation

1. Clone this repository
```bash
git clone https://github.com/zxdev7/sveltekit-supabase.git
cd sveltekit-supabase
```

2. Install dependencies
```bash
npm install
# or
yarn install
# or
pnpm install
```

3. Set up Supabase
   - Create a new Supabase project
   - Copy your Supabase URL and anon key
   - Create a `.env` file in the root directory based on `.env.example`
   ```
   PUBLIC_SUPABASE_URL=your-supabase-url
   PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
   ```

### Development

Start the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

Open [http://localhost:5173](http://localhost:5173) with your browser to see the result.

## Database Setup

This template assumes you have the following tables in your Supabase database:

### Profiles Table

```sql
create table profiles (
  id uuid references auth.users on delete cascade not null primary key,
  username text unique,
  full_name text,
  avatar_url text,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

-- Enable Row Level Security
alter table profiles enable row level security;

-- Create policies
create policy "Public profiles are viewable by everyone."
  on profiles for select
  using (true);

create policy "Users can insert their own profile."
  on profiles for insert
  with check (auth.uid() = id);

create policy "Users can update their own profile."
  on profiles for update
  using (auth.uid() = id);
```

## Deployment

Build the application for production:

```bash
npm run build
# or
yarn build
# or
pnpm build
```

You can preview the production build with:

```bash
npm run preview
# or
yarn preview
# or
pnpm preview
```

Deploy to platforms like Vercel, Netlify, or your own hosting solution.

## Project Structure

```
├── src/
│   ├── lib/
│   │   ├── components/    # Reusable components
│   │   │   └── auth/      # Authentication components
│   │   └── supabase/      # Supabase client and utilities
│   ├── routes/            # SvelteKit routes
│   │   ├── auth/          # Authentication routes
│   │   ├── dashboard/     # Dashboard page
│   │   └── profile/       # User profile page
│   ├── app.css            # Global styles
│   └── app.html           # HTML template
├── static/                # Static files
├── .env.example           # Environment variables example
└── ...                    # Config files
```

## License

MIT
# sveltekit-supabase
