import { Router } from 'express';
import verifyToken from '../utils/verifyToken.util';
import * as packageController from '../controllers/package.controller';

const router = Router();

router.post('/create', verifyToken, packageController.createPackage);
router.post('/update', verifyToken, packageController.updatePackage);
router.get('/get/:id', packageController.readPackage);
router.post('/delete', verifyToken, packageController.deletePackage);

export default router;
