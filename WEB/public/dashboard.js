document.addEventListener('DOMContentLoaded',async ()=> await fetch7days())
document.addEventListener('DOMContentLoaded',async ()=> await fetchMonth())
document.addEventListener('DOMContentLoaded',async ()=> await fetchHistorico())
document.addEventListener('DOMContentLoaded',async ()=> await gerarBarChart())

async function fetchHistorico(){
  const fetchApi = await fetch('/api/selectHistorico') 
  const data= await fetchApi.json()
  document.getElementById("historyList").innerHTML = data.total_dia
}
async function fetch7days(){
    const fetchApi = await fetch('/api/select7days')
    const data = await fetchApi.json()
    document.getElementById("lastweek").innerHTML = data
}
async function fetchMonth(){
    const fetchApi = await fetch('/api/selectMonth')
    const data = await fetchApi.json()
    document.getElementById("lastmonth").innerHTML = data
}

async function gerarBarChart(){
let chartInstance = null    
const fetchApi = await fetch('/api/selectLabelsData')
const valores = await fetchApi.json()
const valorGroupBy = []
const nomeDiasSemana = []

valores.forEach(v => {
    valorGroupBy.push(v.total)
    nomeDiasSemana.push(v.dia_semana)
});
const idChart = document.getElementById("barChart")

chartInstance = new Chart(idChart, {
  type: "bar", 
  data: {
    labels: nomeDiasSemana ,
    datasets: [{
      label: "Quantidade Pessoas",
      data: valorGroupBy,
      backgroundColor: 'rgb(100, 0, 0)'
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false
  }
})
}

