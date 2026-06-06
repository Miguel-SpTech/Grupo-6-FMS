
 function gerarBarChart(labels, valores){
let chartInstance = null
const ctx = document.getElementById('barChart');
            if (chartInstance) {
                chartInstance.destroy();
            }
            Chart.defaults.backgroundColor = '#8b1a1a';
            Chart.defaults.borderColor = '#8b1a1a';
            Chart.defaults.color = '#000';
            chartInstance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Quantidade de clientes',
                        data: valores,
                        backgroundColor: ['rgba(139, 26, 26, 0.85)', 'rgba(139, 26, 26, 0.55)', 'rgba(139, 26, 26, 0.35)'],
                        borderColor: ['#5f1212', '#8b1a1a', '#8b1a1a'],
                        borderWidth: 1,
                        borderRadius: 8,
                        maxBarThickness: 56,
                    }]
                },
                options: {
                    animation: {
                        y: {
                            duration: 1000,
                            from: 1000,
                            easing: 'easeOutQuart'
                        }
                    },
                    plugins: {
                        legend: {
                            display: true
                        },
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            border:{
                                color: 'rgba(139, 26, 26, 0.08)'
                            },
                            ticks: {
                                color: '#5c4a4a',
                            },
                            grid: {
                                color: 'rgba(139, 26, 26, 0.08)'
                            }
                        },
                        x: {
                            border:{
                                color: 'rgba(139, 26, 26, 0.08)'
                            },
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#5c4a4a',
                                maxRotation: 42,
                                minRotation: 0,
                                font: { size: 11 }
                            }
                        }
                    }
                }
            });
          }
