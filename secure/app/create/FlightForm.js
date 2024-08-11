"use client";
import { useRouter } from 'next/router';
import Link from 'next/link';
import React, { useState, useEffect } from 'react';
// import { ethers } from 'ethers';

const FlightForm = () => {
    const [form, setForm] = useState({
        airport: '',
        date: '',
        flightNumber: '',
        ticketNumber: '',
        amount: '1' // 设为 1 Share
    });

    const [airports, setAirports] = useState([]);
    const [flights, setFlights] = useState([]);

    useEffect(() => {
        const fetchAirports = async () => {
            try {
                const response = await fetch('/api/airports');
                const data = await response.json();
                setAirports(data);
            } catch (error) {
                console.error('Error fetching airports:', error);
            }
        };

        fetchAirports();
        fetchFlights();  // 在组件加载时调用 fetchFlights 生成航班数据
    }, []);

    const fetchFlights = async () => {
        const selectedAirport = form.airport ? airports.find(airport => airport.name === form.airport) : airports[0];
        const selectedDate = form.date || new Date().toISOString().split('T')[0];

        if (selectedAirport) {
            const generatedFlights = Array.from({ length: 8 }, (_, index) => ({
                id: index + 1,
                flightNumber: `AZ5552 ${index + 1}`,
                airportId: selectedAirport.id,
                date: selectedDate
            }));
            setFlights(generatedFlights);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        let formattedValue = value;

        if (name === 'amount' && isNaN(value)) {
            return; // Only allow numbers in amount
        }

        if (name === 'date') {
            const date = new Date(value);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            formattedValue = `${year}-${month}-${day}`;
        }

        setForm((prevForm) => ({
            ...prevForm,
            [name]: formattedValue
        }));

        // 在选择日期或机场后立即调用 fetchFlights
        if ((name === 'date' && form.airport) || (name === 'airport' && form.date)) {
            fetchFlights();
        }
    };

    const handleSubmit = async (e) => {

        // e.preventDefault();
        // // 调用智能合约进行授权和购买保险
        // try {
        //     const provider = new ethers.providers.Web3Provider(window.ethereum);
        //     await provider.send("eth_requestAccounts", []);
        //     const signer = provider.getSigner();

        //     // 合约地址和ABI
        //     const tokenAddress = "0x3f0834c7C2AD202B50861376E108f59534D7a79c";
        //     const insuranceAddress = "0xd7e8F6FD9B50B7174a5bBF4649E55e3f5954BC1c";
        //     const tokenAbi = ["function approve(address spender, uint256 amount) public returns (bool)"];
        //     const insuranceAbi = [
        //         "function buyInsurance(address referrer, string memory flightNo, uint256 date, uint256 policyAmount) public"
        //     ];

        //     // 创建合约实例
        //     const tokenContract = new ethers.Contract(tokenAddress, tokenAbi, signer);
        //     const insuranceContract = new ethers.Contract(insuranceAddress, insuranceAbi, signer);

        //     // 授权
        //     const approveTx = await tokenContract.approve(insuranceAddress, ethers.utils.parseUnits(form.amount, 18));
        //     await approveTx.wait();

        //     // 购买保险
        //     const referrer = "0x0000000000000000000000000000000000000000"; // 无推荐人
        //     const flightNo = form.flightNumber;
        //     const date = Math.floor(new Date(form.date).getTime() / 1000); // 转换为 UNIX 时间戳
        //     const policyAmount = ethers.utils.parseUnits(form.amount, 18);

        //     const buyTx = await insuranceContract.buyInsurance(referrer, flightNo, date, policyAmount);
        //     await buyTx.wait();

        //     console.log("Insurance purchased successfully");
        // } catch (error) {
        //     console.error("Error purchasing insurance:", error);
        // }
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-gray-100">
            <div className="flex bg-white rounded-lg shadow-lg overflow-hidden w-full max-w-4xl mt-[-100px]">
                <div className="w-1/2 bg-cover" style={{ backgroundImage: "url('/plane.jpg')" }}></div>
                <div className="w-1/2 p-8">
                    <h1 className="text-2xl font-bold mb-6 text-center">Flight Assure</h1>
                    <form onSubmit={handleSubmit} className="space-y-6">
                        <div>
                            <label htmlFor="airport" className="block text-sm font-medium text-gray-700">Airport</label>
                            <select
                                id="airport"
                                name="airport"
                                value={form.airport}
                                onChange={handleChange}

                                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                            >
                                <option value="">Select an airport</option>
                                {airports.map((airport) => (
                                    <option key={airport.id} value={airport.name}>{airport.name}</option>
                                ))}
                            </select>
                        </div>
                        <div>
                            <label htmlFor="date" className="block text-sm font-medium text-gray-700">Date</label>
                            <input
                                type="date"
                                id="date"
                                name="date"
                                value={form.date}
                                onChange={handleChange}

                                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                            />
                        </div>
                        <div>
                            <label htmlFor="flightNumber" className="block text-sm font-medium text-gray-700">Flight Number</label>
                            <select
                                id="flightNumber"
                                name="flightNumber"
                                value={form.flightNumber}
                                onFocus={fetchFlights}
                                onChange={handleChange}

                                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                            >
                                <option value="">Select a flight number</option>
                                {flights.map((flight) => (
                                    <option key={flight.id} value={flight.flightNumber}>{flight.flightNumber}</option>
                                ))}
                            </select>
                        </div>
                        <div>
                            <label htmlFor="ticketNumber" className="block text-sm font-medium text-gray-700">Ticket Number</label>
                            <input
                                type="text"
                                id="ticketNumber"
                                name="ticketNumber"
                                value={form.ticketNumber}
                                onChange={handleChange}

                                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                            />
                        </div>
                        <div>
                            <label htmlFor="amount" className="block text-sm font-medium text-gray-700">Amount (USDT)</label>
                            <input
                                type="text"
                                id="amount"
                                name="amount"
                                value={form.amount}
                                onChange={handleChange}

                                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                            />
                        </div>
                        <Link href="/services" passHref>

                            <button
                                type="submit"
                                className="w-full bg-blue-500 text-white px-4 py-2 rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >

                                Submit
                            </button>

                        </Link>

                    </form>
                </div>
            </div>
        </div >
    );
};

export default FlightForm;
