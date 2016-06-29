From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: msgr2 protocol comments
Date: Wed, 29 Jun 2016 16:22:48 +0000
Message-ID: <DB5PR05MB1607978C2EC42E11A87B23A0A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607AFD265F02526A1A46A94A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1606291546030.18172@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0093.outbound.protection.outlook.com ([157.56.112.93]:47780
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751480AbcF2QXF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 12:23:05 -0400
In-Reply-To: <alpine.DEB.2.11.1606291546030.18172@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> -----Original Message-----
> From: Sage Weil 
> Sent: Wednesday, June 29, 2016 18:54
> To: Avner Ben Hanoch 
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: msgr2 protocol comments
> 
> On Wed, 29 Jun 2016, Avner Ben Hanoch wrote:
> 
> > 3 - Since msgr2 is based on frames, and since it "knows" to continue a
> > session even after a TCP disconnect - all these and more make msgr2
> > very appropriate for connectionless and/or datagram based transports
> > (like UDP / RDS / and even XIO).
> >
> > Hence, I suggest to be more general in the definitions... to define a
> > connection based on its tuple (source ip, source port, destination ip,
> > destination port) and not necessarily based on TCP connection. This
> > way we can make the implementation of msgr2 with maximum flexibly and
> > maximum shared code between all future messengers.
> 
> I suspect/hope we can make the "connection" something that the transport
> layer defines (TCP in our initial implementation) and focus on the semantics
> of the streams. Then any new transport is free to do (or not do) connections
> however it likes.  The only real restrictions right now, I beleive, is that the
> stream ids are local to a connection.  However, if a connectionless transport is
> being used, they could be globally unique (for the given pair of peer
> addresses), or whatever.
> 
> Is that sufficient?
> 
> sage

I mean that architecturally it can be a great idea and opportunity to distinguish between Connection abstraction (or even AsyncConnection abstraction) and the transport that is being used.  
Of course the initial implementation will be TCP. Still, separating code that is TCP specific (like we did net_handler.cc) from protocol state machine and other things that are not specific to TCP will make AsyncConnection cleaner and and useful for other transports

With connectionless transport, stream-id must be unique for a "connection abstraction" (pair of peer addresses and ports) - this is exactly as you have with TCP connection.  
The only difference is technical - with TCP, a connection abstraction is equivalent to a connected socket; while with connectionless protocols, a connection abstraction can share the socket with additional connection abstractions.  Still, for ALL transports, a connection abstractions is a pair of peer addresses and ports.

Avner
