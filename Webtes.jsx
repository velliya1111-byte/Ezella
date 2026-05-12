import React from 'react';

export default function BlueStoreWebsite() {
  const products = [
    {
      title: "Sewa Bot",
      category: "BOT WA",
      price: "Rp500",
      image: "https://unsplash.com",
    },
    {
      title: "Panel Pterodactyl",
      category: "PANEL",
      price: "Rp2.000",
      image: "https://unsplash.com",
    },
    {
      title: "SC ITACHI MD",
      category: "SCRIPT",
      price: "Rp80.000",
      image: "https://unsplash.com",
    },
    {
      title: "Music Bot Premium",
      category: "BOT WA",
      price: "Rp1.000",
      image: "https://unsplash.com",
    },
  ];

  return (
    <div className="min-h-screen overflow-hidden bg-[#020817] text-white font-sans">
      {/* Background Glow */}
      <div className="pointer-events-none fixed inset-0 bg-[radial-gradient(circle_at_top,rgba(0,140,255,0.15),transparent_40%)]" />

      {/* Header */}
      <header className="sticky top-0 z-50 border-b border-cyan-500/10 bg-[#020817]/80 backdrop-blur-xl">
        <div className="flex items-center justify-between px-4 py-4">
          <div className="flex items-center gap-3">
            <div className="h-11 w-11 overflow-hidden rounded-2xl border border-cyan-500/30 shadow-lg shadow-cyan-500/20">
  <img 
    src="https://files.catbox.moe/choggx.jpg" 
    alt="Logo" 
    className="h-full w-full object-cover"
  />
</div>

            <div>
              <h1 className="text-lg font-bold">Velliya Louire</h1>
              <p className="text-[10px] text-cyan-400 font-bold tracking-widest uppercase">Digital Marketplace</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <button className="rounded-xl border border-cyan-400/20 bg-cyan-500/10 px-4 py-2 text-xs font-bold text-cyan-300">
              Owner
            </button>
            <button className="flex h-11 w-11 items-center justify-center rounded-xl border border-cyan-400/20 bg-white/5 text-lg">
              ☰
            </button>
          </div>
        </div>
      </header>

      {/* Hero Section - VIDEO TELAH DIPERBAIKI DI SINI */}
      <section className="relative z-10 px-4 pt-4">
        <div className="relative overflow-hidden rounded-[28px] border border-cyan-500/10 shadow-2xl shadow-cyan-500/10">
          <video 
            autoPlay 
            muted 
            loop 
            playsInline 
            className="h-[220px] w-full object-cover brightness-[0.45] contrast-125 saturate-150"
            src="https://files.catbox.moe/me7jcf.mp4"
          />
          <div className="absolute inset-0 bg-gradient-to-r from-[#020817] via-[#020817]/40 to-transparent" />
          <div className="absolute inset-0 flex flex-col justify-center p-6">
            <p className="text-xl font-bold text-cyan-400">Halo,</p>
            <h2 className="mt-1 max-w-[240px] text-3xl font-black leading-tight">
              Selamat Datang di <span className="text-cyan-400">Velliya</span>
            </h2>
            <p className="mt-3 max-w-[250px] text-xs text-zinc-400">
              Tempat terbaik untuk kebutuhan layanan digital.
            </p>
            <button className="mt-5 w-fit rounded-xl bg-gradient-to-r from-cyan-400 to-blue-700 px-6 py-2.5 text-sm font-bold shadow-lg shadow-cyan-500/30">
              Lihat Produk
            </button>
          </div>
        </div>
      </section>

      {/* Status */}
      <section className="mt-5 grid grid-cols-2 gap-3 px-4">
        {["100% Aman", "Rating 4.9", "Proses <30mnt", "Metode Lengkap"].map((item) => (
          <div key={item} className="rounded-2xl border border-cyan-500/10 bg-white/[0.03] py-3 text-center text-[11px] font-bold text-zinc-300">
            {item}
          </div>
        ))}
      </section>

      {/* Categories */}
      <section className="mt-6 flex gap-3 overflow-x-auto px-4 pb-1">
        {["Semua", "Bot WA", "Panel", "Script", "Musik"].map((item, index) => (
          <button 
            key={item} 
            className={`whitespace-nowrap rounded-xl border px-6 py-2.5 text-xs font-bold ${
              index === 0 
                ? "border-transparent bg-gradient-to-r from-cyan-400 to-blue-700 text-white" 
                : "border-cyan-500/10 bg-white/[0.03] text-zinc-400"
            }`}
          >
            {item}
          </button>
        ))}
      </section>

      {/* Products */}
      <section className="mt-6 px-4 pb-32">
        <h2 className="text-lg font-bold mb-5 flex items-center gap-2">
          <span className="h-5 w-1 bg-cyan-500 rounded-full"></span>
          Produk Unggulan
        </h2>
        <div className="grid grid-cols-2 gap-4">
          {products.map((product, index) => (
            <div key={index} className="relative overflow-hidden rounded-[24px] border border-cyan-500/10 bg-white/[0.03] p-3">
              <div className="relative aspect-square overflow-hidden rounded-2xl">
                <img src={product.image} alt={product.title} className="h-full w-full object-cover" />
                <div className="absolute right-2 top-2 rounded-lg bg-black/60 px-2 py-1 text-[9px] font-black text-cyan-400 border border-white/10">
                  {product.category}
                </div>
              </div>
              <div className="mt-3">
                <h3 className="truncate text-sm font-bold">{product.title}</h3>
                <div className="mt-2 flex items-center justify-between">
                  <p className="text-sm font-black text-cyan-400">{product.price}</p>
                  <button className="h-8 w-8 rounded-lg bg-cyan-500/10 text-cyan-400 font-bold">+</button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Bottom Nav */}
      <nav className="fixed bottom-6 left-1/2 -translate-x-1/2 flex items-center gap-10 rounded-[24px] border border-white/10 bg-[#020817]/60 px-10 py-4 backdrop-blur-2xl">
        <button className="text-cyan-400">Home</button>
        <button className="text-zinc-500">Shop</button>
        <button className="text-zinc-500">Cart</button>
        <button className="text-zinc-500">User</button>
      </nav>
    </div>
  );
}
