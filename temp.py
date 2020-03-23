# -*- coding: utf-8 -*-
"""
Hendrik Hoch

22.03.2020
"""



import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import r2_score

########## Get the dataset
from sklearn.datasets import load_boston
X, y = load_boston(return_X_y=True)

### Split into training and eval sets

n_samples = X.shape[0]
n_tests=5

X_train, y_train = X[:n_samples-n_tests], y[:n_samples-n_tests]
X_test, y_test = X[n_samples-n_tests:], y[n_samples-n_tests:]


########## Learning and predicting

from sklearn.linear_model import Lasso

alpha = 0.1
lasso = Lasso(alpha=alpha)
lasso.fit(X_train, y_train)

y_pred_lasso = lasso.predict(X_test)

r2_score_lasso = r2_score(y_test, y_pred_lasso)

############# Plotting

t=np.linspace(0,n_tests-1,num=n_tests)

data=y_pred_lasso


plt.plot(t, data, 'r^', t, y_test, 'bs')
plt.show()