document.addEventListener("DOMContentLoaded", () => {
  const flash = document.querySelector(".flash-message");
  if (flash) {
    setTimeout(() => {
      flash.style.transition = "opacity 0.5s ease-out";
      flash.style.opacity = "0";
      setTimeout(() => flash.remove(), 500);
    }, 3000); // 3 segundos
  }
});
