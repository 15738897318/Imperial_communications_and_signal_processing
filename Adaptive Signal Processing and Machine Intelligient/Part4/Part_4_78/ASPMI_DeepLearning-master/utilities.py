import pandas as pd
import torch
import torch.nn as nn
import torch.nn.functional as F
import matplotlib.pyplot as plt
from matplotlib import gridspec
import numpy as np
import random

random.seed(1)
np.random.seed(1)
torch.manual_seed(1)

class LMS(torch.nn.Module):
    def __init__(self):
        super(LMS, self).__init__()
        self.neuron = torch.nn.Linear(10, 1)

    def forward(self, x):
        return self.neuron(x)


class nonlinear_LMS(torch.nn.Module):
    def __init__(self):
        super(nonlinear_LMS, self).__init__()
        self.neuron = torch.nn.Linear(10, 1)

    def forward(self, x):
        return 2 * torch.tanh(self.neuron(x))


class deep_network(torch.nn.Module):
    def __init__(self, layers):
        super(deep_network, self).__init__()
        self.layers = []
        for i in range(len(layers)):
            if i == 0:
                self.layers.append(torch.nn.Linear(10, layers[i]))
            else:
                self.layers.append(torch.nn.Linear(layers[i-1], layers[i]))

        self.layers = nn.ModuleList(self.layers)
    def forward(self, x):
        for i in range(len(self.layers)-1):
            x = F.relu(self.layers[i](x))
        return self.layers[-1](x)

def train_network(net, X, y, N, epochs, learning_rate):
    loss_fn = nn.MSELoss()
    optimizer = torch.optim.SGD(net.parameters(), lr=learning_rate)

    train_loss = [0 for i in range(epochs)]
    test_loss = [0 for i in range(epochs)]

    for t in range(epochs):
        # Forward pass
        y_pred = net(X[:N, :])

        # Compute loss
        train_loss[t] = loss_fn(y_pred, y[:N, :])

        optimizer.zero_grad()

        # Backward pass.
        train_loss[t].backward()

        # Update
        optimizer.step()

        test_loss[t] = loss_fn(net(X[N:, :]), y[N:, :])

    return train_loss, test_loss

def plot_data(X, y):
    # fig = plt.figure(figsize=(12, 8))
    # gs = gridspec.GridSpec(2, 1)
    # ax = plt.subplot(gs[0])

    # for i in range(10):
    #     plt.plot(X[:, i], label='$x_{' + str(i + 1) + '}[n]$')
    # plt.grid()
    # plt.axvline(x=50, color='k')
    # plt.text(0.25, 0.9, 'Train', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    # plt.text(0.75, 0.9, 'Test', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    # leg = plt.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3,
    #                  ncol=10, mode="expand", borderaxespad=0., fontsize=11)
    # leg.get_frame().set_alpha(1)

    # x_vect = ''.join(['x_{' + str(i + 1) + '}[n], ' for i in range(9)])

    # plt.title('$\mathbf{x}[n] = [$ $' + x_vect + 'x_{10}[n]$ $]^T$', y=1.15, fontsize=14)

    # ax = plt.subplot(gs[1])
    # plt.plot(y)
    # plt.grid()
    # plt.axvline(x=50, color='k')
    # plt.text(0.25, 0.9, 'Train', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    # plt.text(0.75, 0.9, 'Test', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    # leg = plt.legend(['$y[n]$'], fontsize=11)
    # leg.get_frame().set_alpha(1)
    # plt.title('$y[n] = \phi( \mathbf{x}[n] )$ where $\phi$ is highly non-linear', y=1.02, fontsize=14)

    # plt.tight_layout()
    # plt.show()
    # fig.savefig('Data.eps',dpi=600,format='eps')

    # gs = gridspec.GridSpec(1, 1)
    # ax = plt.subplot(gs[0])
    fig = plt.figure(figsize=(12, 4))
    plt.plot(y)
    plt.grid()
    plt.axvline(x=50, color='k')
    # plt.text(0.25, 0.9, 'Train', horizontalalignment='center', fontsize=14)
    # plt.text(5, 0.9, 'Test', horizontalalignment='center', fontsize=14)
    leg = plt.legend(['$y[n]$'], fontsize=11)
    leg.get_frame().set_alpha(1)
    plt.title('$y[n] = \phi( \mathbf{x}[n] )$ where $\phi$ is highly non-linear', y=1.02, fontsize=14)

    plt.tight_layout()
    plt.show()
    fig.savefig('Data.eps',dpi=600,format='eps')

def plot_output(X, y, models, deep_network_layers):
    fig = plt.figure(figsize=(12,4))
    ax = plt.subplot(1,1,1)
    plt.plot(y)
    plt.grid()
    [plt.plot(model(torch.Tensor(X)).detach().numpy()) for model in models]
    plt.axvline(x=50,color='k')
    plt.text(0.25, 0.9, 'Train', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    plt.text(0.75, 0.9, 'Test', horizontalalignment='center', fontsize=14, transform = ax.transAxes)
    leg = plt.legend(['$y[n]$','Single Neuron (linear)','Single Neuron (tanh)','Deep Network ('+str(deep_network_layers)+', relu)'],
               bbox_to_anchor=(0., 1.02, 1., .102), loc=3,
               ncol=10, mode="expand", borderaxespad=0., fontsize=11)
    leg.get_frame().set_alpha(1)
    plt.tight_layout()
    plt.show()
    fig.savefig('Outputs.eps',dpi=600,format='eps')
    
def train_models(X, y, models, epochs=100, learning_rate=1e-2):
    loss = []
    
    for i, model in enumerate(models):
        (train_loss, test_loss) = train_network(model, 
                                        X=torch.Tensor(X), 
                                        y=torch.Tensor(y).reshape(-1,1),
                                        N=50, 
                                        epochs=epochs,
                                        learning_rate=learning_rate)
        loss.append((train_loss, test_loss))
        
    return loss

def plot_learning_curves(loss):
    fig = plt.figure(figsize=(12,4))
    gs = gridspec.GridSpec(1, 3) 
    t = ['Single Neuron (linear)', 'Single Neuron (tanh)','Deep Network ([10, 5, 5, 5, 1], relu)']
    for i, l in enumerate(loss):
        plt.subplot(gs[i])
        plt.plot(l[0])
        plt.plot(l[1])
        plt.legend(['Train Loss', 'Test Loss'])
        plt.ylim(0,2)        
        plt.grid()
        plt.title(t[i])

    plt.tight_layout()
    plt.show()
    fig.savefig('Loss.eps',dpi=600,format='eps')