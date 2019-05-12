# Issues
## MRV

# disabled ports
Need to handle 'Enable' column resizing when a port is disabled
```
- !Port    Enable   Protocol  Rate                  WL(nm)     Channel  Gain desired(dB)  Name                            
- !======  =======  ========  ====================  =========  =======  ================  ================================
- !1.1.12  enable   Ethernet  40G-LAN 41.25 Gbps    1310.00    N/A      N/A               QSFP at 1.1.12                  
- !1.1.13  disable  OTN       OTU4 111.81 Gbps      1560.606   C21      N/A               CFP at 1.1.13                   
- !1.3.1   N/A      N/A       N/A                   1563.8626  C17      N/A               LC at 1.3.1                     
+ !Port    Enable  Protocol  Rate                  WL(nm)     Channel  Gain desired(dB)  Name                            
+ !======  ======  ========  ====================  =========  =======  ================  ================================
+ !1.1.12  enable  Ethernet  40G-LAN 41.25 Gbps    1310.00    N/A      N/A               QSFP at 1.1.12                  
+ !1.1.13  enable  OTN       OTU4 111.81 Gbps      1560.606   C21      N/A               CFP at 1.1.13                   
+ !1.3.1   N/A     N/A       N/A                   1563.8626  C17      N/A               LC at 1.3.1                     
```

# 100G LAN vs OTU4
Yet more dynamic column widths
```
- !Port    Enable  Protocol  Rate                  WL(nm)     Channel  Gain desired(dB)  Name                            
- !======  ======  ========  ====================  =========  =======  ================  ================================
- !1.3.46  N/A     N/A       N/A                   N/A        N/A      N/A               LC at 1.3.46                    
- !1.5.1   enable  OTN       OTU4 111.81 Gbps      1559.7943  C22      N/A               CFP at 1.5.1                    
- !1.5.2   enable  OTN       OTU4 111.81 Gbps      1310       N/A      N/A               Wasabi_A_100G                   
- !1.6.1   enable  OTN       OTU4 111.81 Gbps      1558.9832  C23      N/A               CFP at 1.6.1                    
- !1.6.2   enable  OTN       OTU4 111.81 Gbps      1310       N/A      N/A               Wasabi_B_100G                   
+ !Port    Enable  Protocol  Rate                   WL(nm)     Channel  Gain desired(dB)  Name                            
+ !======  ======  ========  =====================  =========  =======  ================  ================================
+ !1.3.46  N/A     N/A       N/A                    N/A        N/A      N/A               LC at 1.3.46                    
+ !1.5.1   enable  Ethernet  100G-LAN 103.125 Gbps  1559.7943  C22      N/A               CFP at 1.5.1                    
+ !1.5.2   enable  Ethernet  100G-LAN 103.125 Gbps  1310       N/A      N/A               Wasabi_A_100G                   
+ !1.6.1   enable  Ethernet  100G-LAN 103.125 Gbps  1558.9832  C23      N/A               CFP at 1.6.1                    
+ !1.6.2   enable  Ethernet  100G-LAN 103.125 Gbps  1310       N/A      N/A               Wasabi_B_100G                   
```

