const express = require('express');
const multer = require('multer');
const fs = require('fs');
const app = express();

app.use(express.json({limit: '50mb'}));

// Configura o multer para armazenar os arquivos na memória como Buffer
const upload = multer({ storage: multer.memoryStorage() });

// Configura o multer para armazenar os arquivos na pasta 'uploads'
//const upload = multer({ dest: 'uploads/' });

// Rota POST para receber o upload dos arquivos
app.post('/upload', upload.array('file'), (req, res) => {

    try {
    req.files.forEach(file => {
        // O multer armazena os arquivos como Buffer. Você pode escrever este Buffer diretamente em um arquivo.
        console.log(file.originalname);
        console.log(file);
        console.log(file.buffer);
        file.originalname
        fs.writeFileSync('uploads/'+file.originalname, file.buffer);        
    });

    res.status(200).send('Upload realizado com sucesso!');        
    } catch (error) {
        console.log(error); 
       res.send('Erro ao receber arquivo!');        
    }

});


// Inicia o servidor na porta 3000
app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});

