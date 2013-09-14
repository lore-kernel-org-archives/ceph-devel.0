From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Paxos vs Raft
Date: Sat, 14 Sep 2013 08:16:46 -0700
Message-ID: <CA+Hcz5-i0pUoZZ8t4kK-chc-y7gAp8Y87NL15BHv81=-58UkyA@mail.gmail.com>
References: <5234049D.1080800@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:49839 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab3INPQr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Sep 2013 11:16:47 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so1747123vcb.25
        for <ceph-devel@vger.kernel.org>; Sat, 14 Sep 2013 08:16:46 -0700 (PDT)
In-Reply-To: <5234049D.1080800@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: lamport@microsoft.com, Ceph Development <ceph-devel@vger.kernel.org>

I'm curious about what exactly the consensus requirement and
assumptions are for the monitors. For instance, in the discussion
between Loic and Joao, this statement:

  Joao: : the recovery logic in our implementation tries to aleviate
the burden of recovering multiple versions at the same time. We
propose a version, let the peons accept it, then move on to the next
version. On ceph, we only provide one value at a time.

seems to indicate that the leader is proposing changes sequentially.
However, that makes Ceph's use of paxos sound a lot like the reason
for the development of the Zab protocol used in Zookeeper:

  https://cwiki.apache.org/confluence/display/ZOOKEEPER/Zab+vs.+Paxos

Either way, as a testament to its understandability, or maybe just its
cool factor, there are a lot of Raft reference implementations listed
on this page:

  https://ramcloud.stanford.edu/wiki/display/logcabin/LogCabin

On Fri, Sep 13, 2013 at 11:39 PM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi,
>
> Ceph ( http://ceph.com/ ) relies on a custom implementation of Paxos =
to provide exabyte scale distributed storage. Like most people recently=
 exposed to Paxos, I struggle to understand it ... but will keep studyi=
ng until I get it :-) When a friend mentionned Raft (  http://en.wikipe=
dia.org/wiki/Raft_%28computer_science%29 ), it looked like an easy way =
out. But it's very recent and I would very much appreciate your opinion=
=2E Do you think it is a viable alternative to Paxos ?
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
