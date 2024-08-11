// components/Navbar.js
import Link from 'next/link';
import { ConnectButton } from '@rainbow-me/rainbowkit';
export const YourApp = () => <ConnectButton />


export default function Navbar() {
    return (
        // fixed z-20 w-full
        <nav className="bg-blue-500 p-4" style={{ backgroundColor: '#1E3A8A' }}>
            <div className="container mx-auto flex justify-between items-center">
                <div className="flex items-center text-white text-lg font-bold">

                    {/* <Image className="dark:invert" width={100}
                        height={24} src="/istockphoto.svg" alt="iStock Photo" /> */}

                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="32" height="32" fill="currentColor">
                        <path d="M32 2C15.432 2 2 15.432 2 32s13.432 30 30 30 30-13.432 30-30S48.568 2 32 2zm0 56C17.664 58 6 46.336 6 32S17.664 6 32 6s26 11.664 26 26-11.664 26-26 26zm12-30c0-2.218-1.106-4.208-2.828-5.516A10.99 10.99 0 0036 20.504a11.019 11.019 0 00-8 3.516 11.014 11.014 0 00-2.172 7.472c0 .844.058 1.672.172 2.484-.262-.016-.52-.036-.784-.036-4.412 0-8 3.588-8 8 0 4.412 3.588 8 8 8 3.578 0 6.584-2.36 7.664-5.636.394.022.792.036 1.192.036 4.054 0 7.4-2.35 9.032-5.728C42.176 34.58 44 31.55 44 28z" />
                    </svg>

                    {/* <Image
                        src="/istockphoto.svg"
                        alt="Vercel Logo"
                        className="dark:invert"
                        width={100}
                        height={24}
                        priority
                    /> */}
                    <Link href="/">
                        Atlantic Insurance
                    </Link>
                </div>
                <div className="text-white text-lg font-bold">

                </div>
                <div className="space-x-4 flex">
                    {/* <Link className="text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700" href="/">

                    </Link> */}
                    <Link className="text-white px-4 py-3 rounded-md text-sm font-bold bg-custom-blue hover:bg-blue-700 border border-blue-700 shadow-custom-lg transform transition-transform duration-200 ease-in-out hover:scale-105" href="/create">
                        Create
                    </Link>
                    <Link className="text-white px-4 py-3 rounded-md text-sm font-bold bg-custom-blue hover:bg-blue-700 border border-blue-700 shadow-custom-lg transform transition-transform duration-200 ease-in-out hover:scale-105" href="/services">
                        Services
                    </Link>
                    {/* <Link className="text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700" href="/contactTs2">
                        Contact
                    </Link>
                    <Link className="text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700" href="/contactTs">
                        Contact
                    </Link> */}
                    <YourApp />
                </div>
            </div>
        </nav>
    );
}
