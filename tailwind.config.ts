import type { Config } from "tailwindcss";
import defaultTheme from "tailwindcss/defaultTheme";
import plugin from "tailwindcss/plugin";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        color: {
          1: "#E0E1E6", // Neo-Steel
          2: "#00F0FF", // Neon Cyan
          3: "#FF4D00", // Safety Orange
          4: "#7ADB78", // Keep green for success states if needed, or mute it: #5C7060
          5: "#858DFF", // Keep or shift to cool blue: #4D5E80
          6: "#FF98E2", // Maybe shift to a warning yellow or keep as accent
        },
        stroke: {
          1: "#1A1A20", // Darker industrial stroke
        },
        n: {
          1: "#FFFFFF",
          2: "#E5E7EB", // Slater greys
          3: "#D1D5DB",
          4: "#9CA3AF",
          5: "#6B7280",
          6: "#4B5563",
          7: "#374151",
          8: "#1F2937", // Dark industrial backgrounds
          9: "#111827",
          10: "#0F1115", // Very dark machinery
          11: "#0B0D10",
          12: "#18181B",
          13: "#71717A",
        },
      },
      fontFamily: {
        sans: ["var(--font-sora)", ...defaultTheme.fontFamily.sans],
        code: "var(--font-code)",
        grotesk: "var(--font-grotesk)",
      },
      letterSpacing: {
        tagline: ".15em",
      },
      spacing: {
        0.25: "0.0625rem",
        7.5: "1.875rem",
        15: "3.75rem",
      },
      opacity: {
        15: ".15",
      },
      transitionDuration: {
        DEFAULT: "200ms",
      },
      transitionTimingFunction: {
        DEFAULT: "linear",
      },
      zIndex: {
        1: "1",
        2: "2",
        3: "3",
        4: "4",
        5: "5",
      },
      borderWidth: {
        DEFAULT: "0.0625rem",
      },
      backgroundImage: {
        "radial-gradient": "radial-gradient(var(--tw-gradient-stops))",
        "conic-gradient":
          "conic-gradient(from 225deg, #00F0FF, #E0E1E6, #FF4D00, #4B5563, #00F0FF)", // Updated conic for industrial feel
        "benefit-card-1": "url(assets/benefits/card-1.png)",
        "benefit-card-2": "url(assets/benefits/card-2.png)",
        "benefit-card-3": "url(assets/benefits/card-3.png)",
        "benefit-card-4": "url(assets/benefits/card-4.png)",
        "benefit-card-5": "url(assets/benefits/card-5.png)",
        "benefit-card-6": "url(assets/benefits/card-6.png)",
      },
      animation: {
        orbit: "orbit calc(var(--duration)*1s) linear infinite",
        marquee: "marquee calc(var(--duration)) linear infinite",
        "marquee-vertical":
          "marquee-vertical calc(var(--duration)) linear infinite",
      },
      keyframes: {
        orbit: {
          "0%": {
            transform:
              "rotate(calc(var(--angle) * 1deg)) translateY(calc(var(--radius) * 1px)) rotate(calc(var(--angle) * -1deg))",
          },
          "100%": {
            transform:
              "rotate(calc(var(--angle) * 1deg + 360deg)) translateY(calc(var(--radius) * 1px)) rotate(calc((var(--angle) * -1deg) - 360deg))",
          },
        },
        marquee: {
          "0%": {
            transform: "translateX(0)",
          },
          "100%": {
            transform: "translateX(calc(-100% - var(--gap)))",
          },
        },
        "marquee-vertical": {
          "0%": {
            transform: "translateY(0)",
          },
          "100%": {
            transform: "translateY(calc(-100% - var(--gap)))",
          },
        },
      },
    },
  },
  plugins: [
    plugin(({ addBase, addComponents, addUtilities }) => {
      addBase({});
      addComponents({
        ".container": {
          "@apply max-w-[77.5rem] mx-auto px-5 md:px-10 lg:px-15 xl:max-w-[87.5rem]":
            {},
        },
        ".h1": {
          "@apply font-semibold text-[2.5rem] leading-[3.25rem] md:text-[2.75rem] md:leading-[3.75rem] lg:text-[3.25rem] lg:leading-[4.0625rem] xl:text-[3.75rem] xl:leading-[4.5rem]":
            {},
        },
        ".h2": {
          "@apply text-[1.75rem] leading-[2.5rem] md:text-[2rem] md:leading-[2.5rem] lg:text-[2.5rem] lg:leading-[3.5rem] xl:text-[3rem] xl:leading-tight":
            {},
        },
        ".h3": {
          "@apply text-[2rem] leading-normal md:text-[2.5rem]": {},
        },
        ".h4": {
          "@apply text-[2rem] leading-normal": {},
        },
        ".h5": {
          "@apply text-2xl leading-normal": {},
        },
        ".h6": {
          "@apply font-semibold text-lg leading-8": {},
        },
        ".body-1": {
          "@apply text-[0.875rem] leading-[1.5rem] md:text-[1rem] md:leading-[1.75rem] lg:text-[1.25rem] lg:leading-8":
            {},
        },
        ".body-2": {
          "@apply font-light text-[0.875rem] leading-6 md:text-base": {},
        },
        ".caption": {
          "@apply text-sm": {},
        },
        ".tagline": {
          "@apply font-grotesk font-light text-xs tracking-tagline uppercase":
            {},
        },
        ".quote": {
          "@apply font-code text-lg leading-normal": {},
        },
        ".button": {
          "@apply font-code text-xs font-bold uppercase tracking-wider": {},
        },
      });
      addUtilities({
        ".tap-highlight-color": {
          "-webkit-tap-highlight-color": "rgba(0, 0, 0, 0)",
        },
      });
    }),
  ],
};

export default config;
