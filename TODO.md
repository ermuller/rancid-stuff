# Issues
## MRV

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
