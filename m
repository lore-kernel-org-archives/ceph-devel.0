From: Gregory Farnum <greg@inktank.com>
Subject: Re: Paxos vs Raft
Date: Sat, 14 Sep 2013 09:48:38 -0700
Message-ID: <CAPYLRzjWaXoQb_2F2xS042vUn76guR=_i+yEfC9Kk2P18R3D3A@mail.gmail.com>
References: <5234049D.1080800@dachary.org>
	<CA+Hcz5-i0pUoZZ8t4kK-chc-y7gAp8Y87NL15BHv81=-58UkyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43649 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab3INQsj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Sep 2013 12:48:39 -0400
Received: by mail-wg0-f54.google.com with SMTP id m15so2181381wgh.21
        for <ceph-devel@vger.kernel.org>; Sat, 14 Sep 2013 09:48:38 -0700 (PDT)
In-Reply-To: <CA+Hcz5-i0pUoZZ8t4kK-chc-y7gAp8Y87NL15BHv81=-58UkyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: lamport@microsoft.com, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Sep 13, 2013 at 11:39 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Ceph ( http://ceph.com/ ) relies on a custom implementation of Paxos to provide exabyte scale distributed storage. Like most people recently exposed to Paxos, I struggle to understand it ... but will keep studying until I get it :-) When a friend mentionned Raft (  http://en.wikipedia.org/wiki/Raft_%28computer_science%29 ), it looked like an easy way out. But it's very recent and I would very much appreciate your opinion. Do you think it is a viable alternative to Paxos ?

Raft *is* the Paxos people use for all intents and purposes. The
original Paxos paper and the follow-on "Paxos Made Simple" are very
much mathematical algorithm papers which describe the necessary
constraints on a system with Paxos' properties, then define a very
general system which solves them, then describe a somewhat more
practical leader-based system. Every implementation I've seen in the
wild takes that leader system and then applies some of the
simplifications/enhancements which Lamport suggests in the end of his
original paper and that Raft has more precisely specified: you elect a
single leader (using what you might consider to be the full paxos
system, with very low commit rates!) who is the only one able to
propose values, then that leader proposes a stream of values which are
accepted by followers and applied to a shared state (eg, our leveldb
instance), and recovery happens by electing a new leader who gathers
the log off of all the other nodes in order to learn what's been
committed and what can be committed.
The reason people are enjoying Raft is that it's targeted at system
implementors instead of theoreticians, so the logical components are
called out a little more clearly and the phases are separated the way
you would split them when implementing the algorithms. That said, I'm
not sure it's *actually* more understandable (even their own test
results don't really support that assertion); I think you should just
read both papers and then use whichever one is more understandable as
the basis for further discussion until you really grok these
consistency algorithms.

On Sat, Sep 14, 2013 at 8:16 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> I'm curious about what exactly the consensus requirement and
> assumptions are for the monitors. For instance, in the discussion
> between Loic and Joao, this statement:
>
>   Joao: : the recovery logic in our implementation tries to aleviate
> the burden of recovering multiple versions at the same time. We
> propose a version, let the peons accept it, then move on to the next
> version. On ceph, we only provide one value at a time.
>
> seems to indicate that the leader is proposing changes sequentially.
> However, that makes Ceph's use of paxos sound a lot like the reason
> for the development of the Zab protocol used in Zookeeper:
>
>   https://cwiki.apache.org/confluence/display/ZOOKEEPER/Zab+vs.+Paxos

Yes. Our throughput expectations/requirements are significantly lower
than Zookeeper's. We could extend them to create a pipeline if we
really wanted to; the one-at-a-time isn't fundamental to the
algorithms we're using that I can recall. (I am somewhat irked by the
claim that Zab is a significantly different algorithm from Paxos. It
certainly fits into the Paxos family of algorithms, although it might
not be explicitly called out as a variation implementers could use in
the original paper like most others are.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
