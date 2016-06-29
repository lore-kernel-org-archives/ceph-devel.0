From: Sage Weil <sage@newdream.net>
Subject: Re: msgr2 protocol comments
Date: Wed, 29 Jun 2016 15:53:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606291546030.18172@piezo.us.to>
References: <DB5PR05MB1607AFD265F02526A1A46A94A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40890 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcF2PyA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 11:54:00 -0400
In-Reply-To: <DB5PR05MB1607AFD265F02526A1A46A94A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 29 Jun 2016, Avner Ben Hanoch wrote:
> Hi,
> 
> Reading documents and discussions about msgr2 I found it very exciting.
> 
> Few comments that I have at this phase:
> 
> 1 - We might want to sharply clarify the terms client and server.  With 
> msgr2 protocol, several streams can be multiplexed into one TCP 
> connection.  If I understand correctly, these streams are not forced to 
> be in the direction of the TCP connection - means the TCP client 
> (initiator) can be either the stream client (initiator) or the stream 
> server (acceptor). Hence, it might worth to have more subtle definitions 
> and to use each one were appropriate

This is a good point.  We could do something simple like reserve one bit 
of the stream ID to indicate which side is the initiator, and have the 
"client" vs "server" distinction a tranport-defined thing.  For TCP it is 
quite explicit, and for something connectionless or datagram-based it 
might be the one with the lower address/port/whatever tuple.  Then any 
"new" stream id is allocated by setting the bit appropriately and 
incrementing a counter.

> 2 - it is not clear to me which step is at connection level and which 
> step is at stream level.  For example, I would expect that 
> Authentication will be at connection level - once for all its streams.  
> However, it is defined with the frames after the banner phase where it 
> is considered the stream level

The idea is that multiple principles/entities might coexist within the 
same process (many OSDs in one process), so the authentication needs to be 
per stream.

> 3 - Since msgr2 is based on frames, and since it "knows" to continue a 
> session even after a TCP disconnect - all these and more make msgr2 very 
> appropriate for connectionless and/or datagram based transports (like 
> UDP / RDS / and even XIO).
> 
> Hence, I suggest to be more general in the definitions... to define a 
> connection based on its tuple (source ip, source port, destination ip, 
> destination port) and not necessarily based on TCP connection. This way 
> we can make the implementation of msgr2 with maximum flexibly and 
> maximum shared code between all future messengers.

I suspect/hope we can make the "connection" something that the transport 
layer defines (TCP in our initial implementation) and focus on the 
semantics of the streams. Then any new transport is free to do (or not do) 
connections however it likes.  The only real restrictions right now, I 
beleive, is that the stream ids are local to a connection.  However, if a 
connectionless transport is being used, they could be globally unique (for 
the given pair of peer addresses), or whatever.

Is that sufficient?

sage
