function node=runDPonTree_rec(node,params)

if node.isLeaf

else
    runDPonTree(node.Left,params);
    runDPonTree(node.Right,params);
    node=DP_FFT(node,params);
end