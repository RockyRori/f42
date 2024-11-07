# DENIAL-OF-SERVICE-ATTACK
How did the attack happened?
     - Victoria sends 1 Ether and becomes king.
     -  Kemi sends 3 Ether to claim the throne and takes over the role of king, Victoria is refunded back.
     - Ndiana sends 5 Ether and therefore becomes the new king, Kemu is refunded back the 3 Ether she sent.
     - The attacker claims the throne by calling the attack function and sends 6 Ether. 
The attacker is the new king and Ndiana receives her 5 Ether refund.
From now on, if Mercia or any other person wants to be king and call claimThrone() function,
the refund to the attacker will revert because the attacker contract has not added the receive() or fallback() function to 
receive Ether, so that no other person will be able to send Ether after him, 
the attacker becomes and stays king no matter what. 

