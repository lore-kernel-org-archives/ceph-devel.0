From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: FW: msgr2 protocol comments
Date: Wed, 29 Jun 2016 14:01:28 +0000
Message-ID: <DB5PR05MB1607FCD5682DE2B31AF86B93A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db3on0067.outbound.protection.outlook.com ([157.55.234.67]:46020
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752523AbcF2OR0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 10:17:26 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

See my 3rd point below :-)

-----Original Message-----
From: Avner Ben Hanoch 
Sent: Wednesday, June 29, 2016 16:59
To: Ceph Development <ceph-devel@vger.kernel.org>
Subject: msgr2 protocol comments

Hi,

Reading documents and discussions about msgr2 I found it very exciting.

Few comments that I have at this phase:

1 - We might want to sharply clarify the terms client and server.  
With msgr2 protocol, several streams can be multiplexed into one TCP connection.  If I understand correctly, these streams are not forced to be in the direction of the TCP connection - means the TCP client (initiator) can be either the stream client (initiator) or the stream server (acceptor).
Hence, it might worth to have more subtle definitions and to use each one were appropriate 

2 - it is not clear to me which step is at connection level and which step is at stream level.  
For example, I would expect that Authentication will be at connection level - once for all its streams.  However, it is defined with the frames after the banner phase where it is considered the stream level

3 - Since msgr2 is based on frames, and since it "knows" to continue a session even after a TCP disconnect - all these and more make msgr2 very appropriate for connectionless and/or datagram based transports (like UDP / RDS / and even XIO).

Hence, I suggest to be more general in the definitions... to define a connection based on its tuple (source ip, source port, destination ip, destination port) and not necessarily based on TCP connection.
This way we can make the implementation of msgr2 with maximum flexibly and maximum shared code between all future messengers.

Regards,
  Avner

