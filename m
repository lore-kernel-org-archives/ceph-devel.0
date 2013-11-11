From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: messenger refactor notes
Date: Mon, 11 Nov 2013 10:00:48 -0500
Message-ID: <36481080-EADC-45FD-A952-FA0C3F735AF3@ornl.gov>
References: <alpine.DEB.2.00.1311090052130.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:51731 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab3KKPKg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 10:10:36 -0500
In-Reply-To: <alpine.DEB.2.00.1311090052130.8192@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Nov 9, 2013, at 4:18 AM, Sage Weil <sage@inktank.com> wrote:

> The SimpleMessenger implementation of the Messenger interface has grown 
> organically over many years and is one of the cruftier bits of code in 
> Ceph.  The idea of building a fresh implementation has come up several 
> times in the past, but is now attracting new interest due to a desire to 
> support alternative transports to TCP (infiniband!) and a desire to 
> improve performance for high-end ceph backends (flash).
> 
> Here is a braindump that should hopefully help kickstart the process.
> 
> See msg/Messenger.h for the abstract interface.
> 
> Note that several bits of this are 'legacy': the send_message, mark_down, 
> and other entity_addr_t-based calls are more or less deprecated (although 
> a few callers remain).  New code uses get_connection() and the 
> Connection*-based calls.  Any effort should focus on these exclusively 
> (and on converting old code to use these as needed).
> 
> The OSD client-side already uses the new Connection* interface.  The OSD 
> <-> OSD communication uses the old calls, but is already wrapped by 
> methods in OSDService and can be easily converted by adding a 
> hash_map<int,ConnectionRef> to that class.  There are some mark_down() 
> calls in OSD that probably need to be wrapped/moved along with that 
> change.
> 
> As for how the implementation should probably be structured:
> 
> The SimpleMessenger code uses 2 (!) threads per conection, which 
> is clearly not ideal.  The new approach should probably have a clearly 
> defined state model for each connection and be event driven.
> 
> Connections can follow a few different modes:
> 
>   - client/server lossy:  client always connects to server.  on 
>     transport error, we queue a notification on both ends and discard the
>     connection state, close the socket, etc.
>   - client/server lossless: client will transparently reconnect on
>     failure.  flow and ordering of messages is preserved.  server will 
>     not initiate reconnect, but will preserve connection state (message 
>     sequence numbers) with the expectation that the client will 
>     reconnect and continue the bidirectional stream of messages.
>   - lossless peer: nodes can connect to each other.  ordered flow of 
>     messages is preserved.

Is the first just a subset of the second in which it does not try to reconnect?

The key item that I see above is the requirement to preserve order and retry on failure. Regardless of the underlying interface, you may want app-level acks. If so, you will need to hang on to the buffers until the ack is received in case you need to retry and/or reconnect.

> For RADOS, client/server lossy is used between librados clients and OSDs.  
> This half of the data path and also the simplest to reason about; I 
> suggest starting here.
> 
> The OSD to OSD communication is lossless peer.  This is more complicated 
> because the connection can be initiated from either end but the stream of 
> messages needs to unified into a single stream.  This is the root of all 
> of the weird connect_seq logic in SimpleMessenger (that is possibly best 
> ignored in favor of an alternative approach).  The OSDs will get unique 
> addresses when they start, but peers may discover a new map and open 
> connections to each other at slightly different times.. which means 
> accepting connections and potentially processing some messages before we 
> know whether the connection is valid or old.

You will also need to handle the case where two peers connect to each (A->B and A<-B) concurrently. You will need a tie-breaker to choose which connection "wins" and close the loser. Lustre and Open-MPI simply select the connection from the host with the lowest IP address. If two hosts can exist on the same IP address, you will need the full endpoint tuple (IP and port). Or you can use your unique address which allows you to move the server to another IP/port.

> Again, because there is some nastiness there, I would probably ignore it 
> for now and focus on the client/server lossy mode as a first step.  Once 
> we have a nice model for modeling connection state and efficiently 
> servicing the network io, we can extend it to the other modes.  FWIW it is 
> easy to swap in a new Messenger implementation for just the client-facing 
> side of the OSD (for example); see ceph_osd.cc.  Same goes for the client 
> code (grep for SimpleMessenger in librados/*).
> 
> The last bit is that we should make sure the transport component of this 
> is well abstracted.  For simplicity of development, I would suggest making 
> the very first prototype simply use TCP, but make sure the interface maps 
> well onto the capabilities of the high-performance transports that are 
> coming soon (whether its Accelio or verbs or rsockets or whatever seems 
> likely to come down the pike anytime soon).  Obviously this is up to 
> whoever is doing the work, though!  As long as it is possible to slot in 
> other transports without reimplementing this whole module again the next 
> time around, I will be happy.

I would suggest non-blocking Sockets.

High-performance transports use Verbs. Under Verbs, you can have an InfiniBand (IB) or Ethernet fabric. Verbs is the native interface for IB. There are two options for running Verbs over Ethernet, RoCE and iWarp. RoCE (RDMA over Converged Ethernet) encapsulates IB frames in Ethernet without TCP/IP. It behaves like IB and requires special NICs and switches that provide lossless service, traffic classes, etc. iWarp is verbs over TCP/IP where the TCP stack is offloaded to the NIC. It does not require special switches.

What is accelio? My google foo fails me.

Rsockets are for traditional Sockets-based apps that do not want to port to Verbs.

For existing and future HPC interconnects, there is Intel's PSM, Cray's uGNI which is verbs-like and Portals 4, the swiss army knife of interfaces.

PSM is geared towards MPI with a tag-matching interface. Intel is aggressively pushing it, however. PSM hardware can emulate Verbs, but not nearly as well as using its native interface.

uGNI is a strict subset of Verbs. Its send-recv interface is like Verbs' RC queue-pair (QP) and it provides a RDMA interface for bulk data movement.

Portals provides everything to implement anything (e.g. two-sided tag-matching interfaces, one-sided put/get, etc.).


> One other note: Sam and others have been doing some performance profiling 
> recently that points toward bottlenecks in the message delivery threads.  
> I'm not sure what the implications of those findings are (if any) for the 
> design of this new code.  Can someone who knows more than I do chime in?
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

