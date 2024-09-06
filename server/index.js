import  express from 'express';
import {authRouter} from './routes/auth.js';
import mongoose from 'mongoose'; // Import mongoose module
const app = express();
const PORT = 3000;
const DB = 'mongodb+srv://akshatsharma:akshat123@cluster0.xl4woo8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'
//middleware
app.use(express.json());
app.use(authRouter);


//connections
mongoose.connect(DB).then(()=>{
    console.log('connection successful');
}).catch((e)=>{
    console.log(e)
});
//binds to a certain host and listens for any other hosts
app.listen(
    PORT, () => { console.log(`connected at port  ${PORT}`); }
)

//creating an api has five elements
//get, put, post, delete, update

// app.get('/my-name', (req, res) => {
//     res.json({"name": 'Akshat Sharma'});
// })
