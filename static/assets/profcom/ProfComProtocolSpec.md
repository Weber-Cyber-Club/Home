# ProfCom Protocol Specification

## Purpose

The purpose of this specification is to assist in the analysis of the Profos-Systems Communication Suite.

## Data Types

* Data will be in Little-Endian
* Integer = 4 bytes
* Boolean = 1 byte
* Strings (Char) Length will be defined by the integer value before the string.

## What is ProfCom?

ProfCom is a communication protocol used to relay important messages back to a central command. According to our intel ProfCom Servers operate over TCP on port 8080 to try and mask the identity of the application. As a method of "security" ProfCom uses an XOR operation to obfuscate the data sent by the application. After some reverse engineering of the ProfCom client application we have found the XOR key is 0x45. The flow of the client server interaction is given below:

### ProfCom Client Server Interaction

**Login Process:**

```

Client -> Server

    Integer Length of Username
    Char Username
    Integer Length of Password
    Char Password

Server -> Client

    Boolean Password Accept/Rejected

```

**If authentication fails, the login process is reinitiated by the client.**

**Data Transfer:**

```

Client -> Server

        Integer Number of Messages to Send

Client -> Server

    Integer Length of Message
    Char Data

```

**After all messages are sent the client and server will disconnect.**


