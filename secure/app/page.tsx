'use client';
import Image from "next/image";

import Navbar from "./components/Navbar";
import Background from './components/Background';

import '@rainbow-me/rainbowkit/styles.css';
import {
  getDefaultConfig,
  RainbowKitProvider,
} from '@rainbow-me/rainbowkit';
import { WagmiProvider } from 'wagmi';
import {
  mainnet,
  polygon,
  optimism,
  arbitrum,
  base,
  zora,
  bsc,
} from 'wagmi/chains';
import {
  QueryClientProvider,
  QueryClient,
} from "@tanstack/react-query";

const config = getDefaultConfig({
  appName: 'walletconnect',
  projectId: 'c67092cf9cbee29c05c312d387a67aeb',
  chains: [mainnet, polygon, optimism, arbitrum, base, zora, bsc],
  ssr: false, // If your dApp uses server side rendering (SSR)
});

const queryClient = new QueryClient();

export default function Home() {
  return (

    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>
          <Navbar />
          <Background />
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>


    //   <WagmiProvider config={config}>
    //   <QueryClientProvider client={queryClient}>
    //     <RainbowKitProvider>
    //     <div>
    //     </YourApp>

    //   </div>
    //     </RainbowKitProvider>
    //   </QueryClientProvider>
    // </WagmiProvider>


  );
}
