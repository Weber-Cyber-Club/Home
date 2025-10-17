+++
title = "Profos-Systems Communications Lab Answers"
showFullContent = false
hideComments = true
+++

**Question 1:**

    How many ProfCom Packets were sent in this packet capture? 78

**Question 2:**

    What are the usernames of the users who successfully log in? ProfessorX & AllAmericanGirl

**Question 3:**

    What password is used to successfully authenticate the 2nd user? Vein.fm

**Question 4:**

    What IP address did the 1st user successfully authenticate from? 34.0.0.11

**Question 5:**

    What is the IP address of the server? 10.0.10.2 (Reverse Engineering would give you 65.0.0.2)

**Question 6:**

    How many messages were sent by the 2nd user that successfully authenticated? 2

**Question 7:**

    What is the flag that was transferred by the protocol? WSU-WALL-0808

**Question 8:**

    Where was this capture completed based on the diagram? This packet capture is taken from within the ProfCom
    Hosting Site, specifically on the ProfCom server itself. Although, I am really just looking for the “ProfCom
    Hosting Site.” This can be found by looking at the IP addresses coming from the clients vs the IP address of
    the server. If we look at the TTL of the packets when they are being captured we would also see the clients TTL
    is set to 61, meaning there must have been three layer 3 hops before the packet reached the server. This would
    match the diagram assuming the switch between the host and the router is a multi-layer switch, which in this
    case, it is. In this lab scenario you are also better off capturing on the server side. This is because it is
    the only way to ensure we can capture all of the data from all of our clients.
