function createChart(coins) {
    let x = []
    let y = []
    for (let i = 0; i < coins.length; i++) {
        x.push(new Date(coins[i].time).toLocaleDateString());
        y.push(coins[i].price.toFixed(2));
    }
    var ctx = document.getElementById('coinChart').getContext('2d');
    let cart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: x,
            datasets: [{
                backgroundColor: [
                    'rgba(54, 162, 235, 0)',
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                ],
                borderWidth: 1,
                label: 'price',
                data: y
            }],
        },
        options: {
            responsive: false,
            elements: {
                point: {
                    radius: 0
                }
            },
            legend: {
                display: false
            },
            scales: {
                yAxes: [
                    {
                        scaleLabel: {
                            display: true,
                            labelString: 'Price'
                        }
                    }
                ],
                xAxes: [
                    {
                        scaleLabel: {
                            display: true,
                            labelString: 'Date'
                        }
                    }
                ]
            }
        }
    });
}