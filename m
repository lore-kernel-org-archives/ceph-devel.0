From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Fri, 6 Nov 2015 12:16:50 -0500
Message-ID: <CANP1eJFoP-yFL8j9fKfhFc9ieH+UPjLnCy85ouoc35KaNMOunw@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
	<CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
	<alpine.DEB.2.00.1511060202130.5830@cobra.newdream.net>
	<CAANLjFrka=DHN=1D-=wsY4HgHQ=-tg0+0hfff80kiiaaRK=r0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34597 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbbKFRQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 12:16:52 -0500
Received: by lfgh9 with SMTP id h9so74929894lfg.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 09:16:50 -0800 (PST)
In-Reply-To: <CAANLjFrka=DHN=1D-=wsY4HgHQ=-tg0+0hfff80kiiaaRK=r0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 6, 2015 at 12:03 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> On Fri, Nov 6, 2015 at 3:12 AM, Sage Weil  wrote:
> > On Thu, 5 Nov 2015, Robert LeBlanc wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA256
> >>
> >> Thanks Gregory,
> >>
> >> People are most likely busy and haven't had time to digest this and I
> >> may be expecting more excitement from it (I'm excited due to the
> >> results and probably also that such a large change still works). I'll
> >> keep working towards a PR, this was mostly proof of concept, now that
> >> there is some data I'll clean up the code.
> >
> > I'm *very* excited about this.  This is something that almost every
> > operator has problems with so it's very encouraging to see that switching
> > up the queue has a big impact in your environment.
> >
> > I'm just following up on this after a week of travel, so apologies if this
> > is covered already, but did you compare this implementation to the
> > original one with the same tunables?  I see somewhere that you had
> > max_backfills=20 at some point, which is going to be bad regardless of the
> > queue.
> >
> > I also see that you chnaged the strict priority threshold from LOW to HIGH
> > in OSD.cc; I'm curious how much of an impact was from this vs the queue
> > implementation.
>
> Yes max_backfills=20 is problematic for both queues and from what I
> can tell is because the OPs are waiting for PGs to get healthy. In a
> busy cluster it can take a while due to the recovery ops having low
> priority. In the current queue, it is possible to be blocked for a
> long time. The new queue seems to prevent that, but they do still back
> up. After this, I think I'd like to look into promoting recovery OPs
> that are blocking client OPs to higher priorities so that client I/O
> doesn't suffer as much during recovery. I think that will be a very
> different problem to tackle because I don't think I can do the proper
> introspection at the queue level. I'll have to do that logic in OSD.cc
> or PG.cc.
>
> The strict priority threshold didn't make much of a difference with
> the original queue. I initially eliminated it all together in the WRR,
> but there were times that peering would never complete. I want to get
> as many OPs in the WRR queue to provide fairness as much as possible.
> I haven't tweaked the setting much in the WRR queue yet.
>
> >
> >> I was thinking that a config option to choose the scheduler would be a
> >> good idea. In terms of the project what is the better approach: create
> >> a new template and each place the template class is instantiated
> >> select the queue, or perform the queue selection in the same template
> >> class, or something else I haven't thought of.
> >
> > A config option would be nice, but I'd start by just cleaning up the code
> > and putting it in a new class (WeightedRoundRobinPriorityQueue or
> > whatever).  If we find that it's behaving better I'm not sure how much
> > value we get from a tunable.  Note that there is one other user
> > (msgr/simple/DispatchQueue) that we might also was to switch over at some
> > point.. especially if this implementation is faster.
> >
> > Once it's cleaned up (remove commented out code, new class) put it up as a
> > PR and we can review and get it through testing.
>
> In talking with Samuel in IRC, we think creating an abstract class for
> the queue is the best option. C++11 allows you to still optimize
> abstract template classes if you use final in the derived class (I
> verified the assembly). I'm planning to refactor the code so that
> similar code can be reused between queues and allows more flexibility
> in the future (components can chose the queue that works the best for
> them, etc). The test for which queue to use should be a very simple
> comparison and it would allow us to let it bake much longer. I hope to
> have a PR mid next week.
>

If you build with LTO the compiler/link will preform de-virtualization
in many cases even when you forget to include the final class modifier
keyword.

>
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWPN1xCRDmVDuy+mK58QAA2XwP/1bv4DUVTfoAGU8q6RDK
> xXCcqNoy2rFcG/D4wipnnGrjMYnVlH33l73hyaZiSQzMwvfzBAl5igQbIlAh
> 41yqXOaGxk+BYRXRNHL5KCP0p0esjV8Wv1z9X2yfKdWeHbwueOKju5ljDQ6X
> AaVXefw1fdag8JEvSjh0dsjgh8wf3G+lAcC9GHB/PFNHXYsl1BVOUz1REnno
> v5vIAZz+iySb8vVrWXJUBaPdW9aao/sqJFU2ZHBziWgeIZ9OlrTlhr9znsxy
> aDa18suMC8vhcrZjyAgKlSbxhgynWh7R2RjxFA5ZObBEsdbztJfg9ibyDzKG
> Ngpe+jVXGTM03z4ohajzPPJ0tzj03XpGc45yXzj6Q4NHOlp5CPdzAPgmxQkz
> ot5cAIR83z67PBIkemeiBQvbC4/ToVCXIBCfEPVW5Yu6grnTd4+AAKxTakip
> +tXSai03MNMlNBeaBnooZ/li7s9VMSluXheZ2JNs9ssRTZkGQH3Pof3p3Y5t
> pAb7qeRlxm+t+i1rZ1tn1FtF/YAx4DKGvyFz4Pzk8pe77jZ+nQLMtoOJJgGJ
> w/+TGiegnUPt6pqWf/Z5o6+GB8SiM/5zKr+Xkm8aIcju/Fq0qy3fx96z81Cv
> QC25ZklTblVt1ImSG30qoVcZdqWKTMwnJhpFNj8GVbzyV5EoFh4T0YBmu3fm
> FKe/
> =yodk
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
