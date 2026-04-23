async function fetchFaturamento(){
    const fetchApi = await fetch('/api/selectData')
    const data = await fetchApi.json()
    document.getElementById("faturamento").innerHTML = data
}
document.addEventListener('DOMContentLoaded',async ()=> await fetchFaturamento())
document.addEventListener('DOMContentLoaded',async ()=> await gerarBarChart())


async function gerarBarChart(){
let chartInstance = null    
const fetchApi = await fetch('/api/selectLabelsData')
const valores = await fetchApi.json()
console.log(valores)
const labels = []
const numeros = []

valores.forEach(v => {
    labels.push(v.labels)
    numeros.push(v.valores) 
});
console.log(labels,numeros)
const idChart = document.getElementById("barChart")

chartInstance = new Chart(idChart, {
  type: "bar", 
  data: {
    labels: labels, 
    datasets: [{
      label: "Qtd Pessoas",
      data: numeros,
      backgroundColor: "red"
    }]
  },
  options: {
    responsive: true
  }
})
}