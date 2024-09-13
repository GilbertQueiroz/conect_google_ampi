// getDistance.js  

const axios = require('axios');  

const API_KEY = process.env.GOOGLE_MAPS_API_KEY;  
const origin = process.argv[2]; // Coordenadas de origem  
const destination = process.argv[3]; // Coordenadas de destino  

if (!origin || !destination) {  
    console.error("Por favor, forneça as coordenadas de origem e destino.");  
    process.exit(1);  
}  

const getDistance = async (origin, destination) => {  
    const url = `https://maps.googleapis.com/maps/api/distancematrix/json?origins=${origin}&destinations=${destination}&key=${API_KEY}`;  

    try {  
        const response = await axios.get(url);  
        const distance = response.data.rows[0].elements[0].distance.text;  
        console.log(`A distância entre ${origin} e ${destination} é ${distance}.`);  
    } catch (error) {  
        console.error("Erro ao obter a distância:", error.message);  
    }  
};  

getDistance(origin, destination);
