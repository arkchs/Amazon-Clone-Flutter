import mongoose from "mongoose";

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,//removes all the leading and trailing commas
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                //regex is a sequence of characters that specifies a search pattern in a text
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        }
    },
    password: {
        required: true,
        type: String,
        validate: (value)=>{
            // const re = /^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{6,20})$/i;
            return value.length>6;
        },
        message: 'Please enter a stronger password or use atleast one special character',
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    //user
},)
export const User = mongoose.model('User', userSchema);