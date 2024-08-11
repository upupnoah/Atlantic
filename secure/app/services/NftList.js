"use client";
// src/components/PolicyList.js
import React, { useEffect, useState } from 'react';

const PolicyList = () => {
    const [data, setData] = useState([]);

    useEffect(() => {
        fetch('/data.json')
            .then((response) => response.json())
            .then((data) => setData(data));
    }, []);

    return (
        <div className="container mx-auto p-4">
            <div className="overflow-x-auto">
                <table className="min-w-full bg-white">
                    <thead>
                        <tr className="w-full bg-gray-200 text-left">
                            <th className="py-2 px-4">Rank</th>
                            <th className="py-2 px-4 text-center">InsurancePolicy</th>
                            <th className="py-2 px-4">Flight Number</th>
                            <th className="py-2 px-4">Date</th>
                            <th className="py-2 px-4">Ticket Number</th>
                            <th className="py-2 px-4">Status</th>
                            <th className="py-2 px-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {data.map((item) => (
                            <tr key={item.rank} className="border-b">
                                <td className="py-2 px-4">{item.rank}</td>
                                <td className="py-2 px-4">
                                    <div className="flex flex-col items-center">
                                        <img src={item.image} alt={`NFT ${item.insurancePolicy}`} className="w-12 h-12 mb-2" />
                                        {item.insurancePolicy}
                                    </div>
                                </td>
                                <td className="py-2 px-4">{item.flightNumber}</td>
                                <td className="py-2 px-4">{item.date}</td>
                                <td className="py-2 px-4">{item.ticketNumber}</td>
                                <td className="py-2 px-4">{item.status}</td>
                                <td className="py-2 px-4">
                                    <button
                                        className={`px-4 py-2 rounded-md text-white ${item.status === 'Unclaimed' ? 'bg-blue-500 hover:bg-blue-700' : 'bg-gray-400 cursor-not-allowed'
                                            }`}
                                        disabled={item.status !== 'Unclaimed'}
                                    >
                                        Claim
                                    </button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default PolicyList;
