From: Gregory Farnum <greg@inktank.com>
Subject: Re: messenger refactor notes
Date: Mon, 11 Nov 2013 16:22:28 -0800
Message-ID: <CAPYLRzgyuFkcCDikxeQVu27gOfa4UAtLMCB5F5g9gxb0qU9nfQ@mail.gmail.com>
References: <alpine.DEB.2.00.1311090052130.8192@cobra.newdream.net>
	<36481080-EADC-45FD-A952-FA0C3F735AF3@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:56460 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3KLAWa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 19:22:30 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so2728436wes.34
        for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 16:22:29 -0800 (PST)
In-Reply-To: <36481080-EADC-45FD-A952-FA0C3F735AF3@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 11, 2013 at 7:00 AM, Atchley, Scott <atchleyes@ornl.gov> wrote:
> On Nov 9, 2013, at 4:18 AM, Sage Weil <sage@inktank.com> wrote:
>
>> The SimpleMessenger implementation of the Messenger interface has grown
>> organically over many years and is one of the cruftier bits of code in
>> Ceph.  The idea of building a fresh implementation has come up several
>> times in the past, but is now attracting new interest due to a desire to
>> support alternative transports to TCP (infiniband!) and a desire to
>> improve performance for high-end ceph backends (flash).
>>
>> Here is a braindump that should hopefully help kickstart the process.
>>
>> See msg/Messenger.h for the abstract interface.
>>
>> Note that several bits of this are 'legacy': the send_message, mark_down,
>> and other entity_addr_t-based calls are more or less deprecated (although
>> a few callers remain).  New code uses get_connection() and the
>> Connection*-based calls.  Any effort should focus on these exclusively
>> (and on converting old code to use these as needed).
>>
>> The OSD client-side already uses the new Connection* interface.  The OSD
>> <-> OSD communication uses the old calls, but is already wrapped by
>> methods in OSDService and can be easily converted by adding a
>> hash_map<int,ConnectionRef> to that class.  There are some mark_down()
>> calls in OSD that probably need to be wrapped/moved along with that
>> change.
>>
>> As for how the implementation should probably be structured:
>>
>> The SimpleMessenger code uses 2 (!) threads per conection, which
>> is clearly not ideal.  The new approach should probably have a clearly
>> defined state model for each connection and be event driven.
>>
>> Connections can follow a few different modes:
>>
>>   - client/server lossy:  client always connects to server.  on
>>     transport error, we queue a notification on both ends and discard the
>>     connection state, close the socket, etc.
>>   - client/server lossless: client will transparently reconnect on
>>     failure.  flow and ordering of messages is preserved.  server will
>>     not initiate reconnect, but will preserve connection state (message
>>     sequence numbers) with the expectation that the client will
>>     reconnect and continue the bidirectional stream of messages.
>>   - lossless peer: nodes can connect to each other.  ordered flow of
>>     messages is preserved.
>
> Is the first just a subset of the second in which it does not try to reconnect?

Yes.

> The key item that I see above is the requirement to preserve order and retry on failure. Regardless of the underlying interface, you may want app-level acks. If so, you will need to hang on to the buffers until the ack is received in case you need to retry and/or reconnect.

That's the distinction between lossy and lossless clients. Lossy
clients need to handle it themselves, and indeed the RADOS protocol
does so. (Lossy interfaces generate a notification to the application
when the messenger decides the connection has died.)

>> For RADOS, client/server lossy is used between librados clients and OSDs.
>> This half of the data path and also the simplest to reason about; I
>> suggest starting here.
>>
>> The OSD to OSD communication is lossless peer.  This is more complicated
>> because the connection can be initiated from either end but the stream of
>> messages needs to unified into a single stream.  This is the root of all
>> of the weird connect_seq logic in SimpleMessenger (that is possibly best
>> ignored in favor of an alternative approach).  The OSDs will get unique
>> addresses when they start, but peers may discover a new map and open
>> connections to each other at slightly different times.. which means
>> accepting connections and potentially processing some messages before we
>> know whether the connection is valid or old.
>
> You will also need to handle the case where two peers connect to each (A->B and A<-B) concurrently. You will need a tie-breaker to choose which connection "wins" and close the loser. Lustre and Open-MPI simply select the connection from the host with the lowest IP address. If two hosts can exist on the same IP address, you will need the full endpoint tuple (IP and port). Or you can use your unique address which allows you to move the server to another IP/port.

Yep, the connect_seq stuff wraps up all this logic.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
