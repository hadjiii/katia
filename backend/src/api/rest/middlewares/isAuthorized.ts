import {Request} from 'express';
import jwt from 'express-jwt';
import config from '../../../config';

const getToken = (req: Request) => {
    const authenticationHeader = req.headers['authorization'] as string;
    
    if(authenticationHeader && authenticationHeader.split(' ')[0] === 'Bearer') {
        return authenticationHeader.split(' ')[1];
    }

    return null;
}

export default jwt({
    secret: config.jwtSecret,
    algorithms: ['HS256'],
    userProperty: 'token',
    getToken: getToken
})