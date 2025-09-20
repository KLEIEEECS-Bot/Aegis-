# Database Setup Guide for Insightify Actionable AI

This guide will help you set up the database integration for the Insightify Actionable AI application.

## Prerequisites

1. **Supabase Account**: You need a Supabase account and project
2. **Supabase CLI** (optional): For local development

## Database Setup

### Step 1: Create Database Tables

1. Go to your Supabase project dashboard
2. Navigate to the **SQL Editor**
3. Copy and paste the contents of `database-setup.sql` into the SQL editor
4. Click **Run** to execute the script

This will create:
- `reviews` table - Stores individual customer reviews with sentiment analysis
- `analysis_sessions` table - Stores analysis session metadata
- Proper indexes for performance
- Row Level Security (RLS) policies for data protection

### Step 2: Update Supabase Configuration

The application is already configured to use Supabase. The configuration is in:
```
src/integrations/supabase/client.ts
```

### Step 3: Update TypeScript Types

Replace the existing types file with the updated one:
```bash
# Copy the updated types file
cp src/integrations/supabase/types-updated.ts src/integrations/supabase/types.ts
```

### Step 4: Update Components

Replace the existing components with the database-integrated versions:
```bash
# Update Dashboard component
cp src/pages/Dashboard-updated.tsx src/pages/Dashboard.tsx

# Update UploadSection component
cp src/components/dashboard/UploadSection-updated.tsx src/components/dashboard/UploadSection.tsx
```

## Features Implemented

### Database Tables
- **reviews**: Stores individual reviews with sentiment analysis
- **analysis_sessions**: Stores analysis session metadata and statistics

### Database Service Layer
- Review storage and retrieval
- Sentiment analysis (simplified version)
- Analytics calculations
- Session management
- Error handling

### Updated Components
- **Dashboard**: Now uses real database data instead of mock data
- **UploadSection**: Added loading states and database integration
- **StatsOverview**: Displays real analytics from database

## Usage

1. **Upload Reviews**: Use either file upload or manual text input
2. **View Analytics**: Real-time analytics calculated from stored reviews
3. **Analysis History**: View and manage previous analysis sessions
4. **Delete Sessions**: Remove unwanted analysis sessions

## API Endpoints

The application uses the following database operations:
- `saveReviews()` - Save reviews with sentiment analysis
- `getAnalytics()` - Calculate real-time analytics
- `createAnalysisSession()` - Create analysis session records
- `getAnalysisHistory()` - Retrieve user's analysis history
- `deleteSession()` - Remove analysis sessions and associated reviews

## Security

- Row Level Security (RLS) ensures users can only access their own data
- All database operations are authenticated
- Input validation and error handling implemented

## Testing

To test the database integration:

1. Start the development server:
   ```bash
   npm run dev
   ```

2. Upload some reviews using either method (file or text)

3. Check the analytics tab to see real-time calculations

4. View the history tab to see previous analysis sessions

5. Try deleting a session to test data management

## Troubleshooting

### Common Issues:

1. **Database Connection Errors**:
   - Verify Supabase URL and API key in `client.ts`
   - Check if tables were created successfully in Supabase dashboard

2. **TypeScript Errors**:
   - Ensure types file is updated correctly
   - Check for any missing imports

3. **Permission Errors**:
   - Verify RLS policies are set up correctly
   - Check user authentication status

### Debug Mode:

Enable debug logging by checking the browser console for database operation logs.

## Next Steps

After successful setup, you can enhance the application by:
- Adding real AI sentiment analysis service
- Implementing data visualization charts
- Adding export functionality for reports
- Creating user management features
