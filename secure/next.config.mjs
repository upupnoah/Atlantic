/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    async rewrites() {
        return [
            {
                source: '/api/airports',
                destination: 'https://nft-rent.vercel.app/api/airports',
            },
            {
                source: '/api/flights',
                destination: 'https://nft-rent.vercel.app/api/flights',
            },
        ];
    },
};
export default nextConfig;
