From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 00:47:56 -0700
Message-ID: <kprnn8$l72$1@ger.gmane.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org> <kpr0ld$3cr$2@ger.gmane.org> <51C156FA.2000509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46228 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933328Ab3FSHsK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jun 2013 03:48:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UpD7g-0003kB-Qt
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 09:48:08 +0200
Received: from c-50-132-41-203.hsd1.wa.comcast.net ([50.132.41.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 09:48:08 +0200
Received: from eternaleye by c-50-132-41-203.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 09:48:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Loic Dachary wrote:

> 
> 
> On 06/19/2013 03:14 AM, Alex Elsayed wrote:
>> Alex Elsayed wrote:
>> 
>>> Loic Dachary wrote:
>>>
>>>> Hi Ceph,
>>>>
>>> <snip>
>>>> Reed-Solomon coding family is the only one that can keep the chuncks
>>>> unencoded and therefore concatenable.
>>> <snip>
>>>
>>> In my understanding, this is not strictly true - any 'systematic' code
>>> will have the unencoded chunks remain available in this manner, and any
>>> non- systematic linear code can be transformed into a systematic code
>>> with the same minimum distance. Fountain codes are often explicitly
>>> constructed to maintain this property, as in the case of RaptorQ [RFC
>>> 6330].
>>>
>>> https://en.wikipedia.org/wiki/Systematic_code
>> 
>> ...that said, Reed-Solomon is to the best of my knowledge the only space-
>> optimal such code.
> 
> What does "space-optimal" mean ? Does it mean that Reed-Solomon will use
> less disk space than fountain codes to code the same number of parity
> chunks ?

Optimal (for an erasure code) means that if you have K symbols of real data, 
then *any* K symbols of the output of the erasure code will let you recover 
it.

Current fountain codes (RaptorQ is best-of-breed right now as far as I know) 
require K + epsilon, and while epsilon is zero for the vast majority of 
cases, some K-sized subsets of the total list of encoded symbols have a non-
zero epsilon, thus requiring more parity data to get exactly the same level 
of assurance.

Optimal erasure codes are also known as "Maximum Distance Separable" codes.

>> An interesting option, however, might be to use a
>> fountain code over the network when distributing either replicas *or*
>> parity chunks, so that losses can be recovered with <1 full chunk
>> retransmission.
> 
> I would be gratefull if you could expand on this idea. I don't get it :-)

First, a couple caveats - one, doing this over TCP would yield no real 
benefit. In fact, any reliable transport makes this mostly pointless - the 
idea is to avoid retransmitting not only chunks, but packets as well.

Let's assume 4MB chunks. Encode the chunk as a single source block (Raptor 
terminology, see the RFC), with a symbol size chosen to fit 1 (one) symbol 
comfortably into a single packet of whatever unreliable, unordered transport 
you're using. DCCP is basically perfect for this.

Send the symbols taking advantage of RaptorQ being a systematic code, and 
thus sending the unmodified chunk first. If it gets through okay, the 
receiver closes the connection and you're done.

If one or more packets failed to get through, those are erasures - so the 
receiver leaves the connection open. The sender can be really simplistic - 
'keep encoding and sending symbols as long as the connection is open.' Once 
the receiver has enough symbols to recover, it closes the connection.

In cases of no loss, overhead is zero. In cases of some loss, the number of 
additional packets is equal to the number of lost packets plus a (very 
small) potential overhead. The real benefit here is this:

There is no longer any need to wait a syn/ack cycle to realize a packet was 
lost.

This is the use case fountain codes are optimized for - coding for 
transmission. Creating a new symbol is an O(1) operation for RaptorQ, while 
for Reed-Solomon it's O(N) with the size of the source block.

Another neat property with Raptor codes is that you can have multiple, 
unsynchronized senders - so for replicas, once one replica has succeeded it 
could join in to accelerate it *linearly* without needing to track who had 
which symbols in the chunk.

Multicast, too.

> Cheers
> 


