From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Mon, 9 Nov 2015 10:19:51 -0700
Message-ID: <CAANLjFoFT6ajEBJKfhA9rnjyJ+a8gKpFrQz74uyobKjiyZvxeQ@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
	<CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
	<alpine.DEB.2.00.1511060202130.5830@cobra.newdream.net>
	<CAANLjFrka=DHN=1D-=wsY4HgHQ=-tg0+0hfff80kiiaaRK=r0g@mail.gmail.com>
	<CAANLjFqMf9xPMPLx-8BM=P00vJ0OnXNCkC3K3Xe-R27Dt6k4Kw@mail.gmail.com>
	<alpine.DEB.2.00.1511080619140.27153@cobra.newdream.net>
	<CAN=+7FUyzNtzjngg-r=fdRo9uqeZfcMRvqc7eZumn7KaB9KYmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35558 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbKIRTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 12:19:53 -0500
Received: by ykek133 with SMTP id k133so276349031yke.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 09:19:52 -0800 (PST)
In-Reply-To: <CAN=+7FUyzNtzjngg-r=fdRo9uqeZfcMRvqc7eZumn7KaB9KYmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I should probably work against this branch.

I've got some more reading of code to do, but I'm thinking that there
isn't one of these queues for each OSD, it seems like there is one
queue for each thread in the OSD. If this is true, I think it makes
sense to break the queue into it's own thread and have each 'worker'
thread push and pop OPs out of that thread. I have been focused on the
Queue code that I haven't really looked at the OSD/PG code until last
Friday and it is like trying to drink from a fire hose going through
that code, so I may be misunderstanding something.

I'd appreciate any pointers to quickly understanding the OSD/PG code
specifically around the OPs and the queue.

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWQNWzCRDmVDuy+mK58QAAAGAQAJ44uFZNl84eGrHIMzDc
EyMBCE/STAOtZINV0DRmnKqrKLeWZ2ajHhr7gYdXByMdCi9QTnz/pYH8fP4m
sTtf8MnaEdDuFYpc+kVP4sOZx+efF64s4isN8lDpoa6noqDR68W3xJ7MV9/l
WJizoD9LWOvPVdPlO6M1jw3waL1eZMrxzPGpz2Xws4XnyGjIWeoUWl0kZYyT
EwGNGaQXBsioowd2PySc3axAY/zaeaJFPp4trw2k2sE9Yi4NT39R3tWgljkC
Ras8TjfHml1+xPeVadB4fdbYl2TaR8xYsVWCp+k1IuiEk/CAeljMjfST/Dqf
TBMhhw8h24AP1GLPwiOFdGIh6h6gj0UoXeXsfHKhSuW6M8Ur+9fuynyuhBUV
V0707nVmu9eiBwkgDHBcIRlnMQ0dDH60Uubf6ShagwjQSg6yfh6MNHVt6FFv
PJCcGDfEqzCjbcGhRyG0bE4aAXXAlHnUy4y2VRGIodmTHqUcZAfXoQd3dklC
KdSNyY+z/inOZip1Pbal4jNv3jAJBABn6Y1nNuB3W+33s/Jvt/aQbJpwYlkQ
iivTMkoMsimVNKAhoTybZpVwJ2Hy5TL/tWqDNwg3TBXtWSFU5S1XgJzoAQm5
yE7dbMwhAObw3XQ/eGMTmyICs1vwD0+mxaNHHWzSubtFKcdblUDW6BUxc+lj
ztfA
=GSDL
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Nov 9, 2015 at 9:49 AM, Samuel Just <sjust@redhat.com> wrote:
> It's partially in the unified queue.  The primary's background work
> for kicking off a recovery operation is not in the unified queue, but
> the messages to the replicas (pushes, pull, backfill scans) as well as
> their replies are in the unified queue as normal messages.  I've got a
> branch moving the primary's work to the queue as well (didn't quite
> make infernalis) --
> https://github.com/athanatos/ceph/tree/wip-recovery-wq.  I'm trying to
> stabilize it now for merge that infernalis is out.
> -Sam
>
> On Sun, Nov 8, 2015 at 6:20 AM, Sage Weil <sage@newdream.net> wrote:
>> On Fri, 6 Nov 2015, Robert LeBlanc wrote:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> After trying to look through the recovery code, I'm getting the
>>> feeling that recovery OPs are not scheduled in the OP queue that I've
>>> been working on. Does that sound right? In the OSD logs I'm only
>>> seeing priority 63, 127 and 192 (osd_op, osd_repop, osd_repop_reply).
>>> If the recovery is in another separate queue, then there is no
>>> reliable way to prioritize OPs between them.
>>>
>>> If I'm going off in to the weeds, please help me get back on the trail.
>>
>> Yeah, the recovery work isn't in the unified queue yet.
>>
>> sage
>>
>>
>>
>>>
>>> Thanks,
>>> - ----------------
>>> Robert LeBlanc
>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>>
>>>
>>> On Fri, Nov 6, 2015 at 10:03 AM, Robert LeBlanc  wrote:
>>> > -----BEGIN PGP SIGNED MESSAGE-----
>>> > Hash: SHA256
>>> >
>>> > On Fri, Nov 6, 2015 at 3:12 AM, Sage Weil  wrote:
>>> >> On Thu, 5 Nov 2015, Robert LeBlanc wrote:
>>> >>> -----BEGIN PGP SIGNED MESSAGE-----
>>> >>> Hash: SHA256
>>> >>>
>>> >>> Thanks Gregory,
>>> >>>
>>> >>> People are most likely busy and haven't had time to digest this and I
>>> >>> may be expecting more excitement from it (I'm excited due to the
>>> >>> results and probably also that such a large change still works). I'll
>>> >>> keep working towards a PR, this was mostly proof of concept, now that
>>> >>> there is some data I'll clean up the code.
>>> >>
>>> >> I'm *very* excited about this.  This is something that almost every
>>> >> operator has problems with so it's very encouraging to see that switching
>>> >> up the queue has a big impact in your environment.
>>> >>
>>> >> I'm just following up on this after a week of travel, so apologies if this
>>> >> is covered already, but did you compare this implementation to the
>>> >> original one with the same tunables?  I see somewhere that you had
>>> >> max_backfills=20 at some point, which is going to be bad regardless of the
>>> >> queue.
>>> >>
>>> >> I also see that you chnaged the strict priority threshold from LOW to HIGH
>>> >> in OSD.cc; I'm curious how much of an impact was from this vs the queue
>>> >> implementation.
>>> >
>>> > Yes max_backfills=20 is problematic for both queues and from what I
>>> > can tell is because the OPs are waiting for PGs to get healthy. In a
>>> > busy cluster it can take a while due to the recovery ops having low
>>> > priority. In the current queue, it is possible to be blocked for a
>>> > long time. The new queue seems to prevent that, but they do still back
>>> > up. After this, I think I'd like to look into promoting recovery OPs
>>> > that are blocking client OPs to higher priorities so that client I/O
>>> > doesn't suffer as much during recovery. I think that will be a very
>>> > different problem to tackle because I don't think I can do the proper
>>> > introspection at the queue level. I'll have to do that logic in OSD.cc
>>> > or PG.cc.
>>> >
>>> > The strict priority threshold didn't make much of a difference with
>>> > the original queue. I initially eliminated it all together in the WRR,
>>> > but there were times that peering would never complete. I want to get
>>> > as many OPs in the WRR queue to provide fairness as much as possible.
>>> > I haven't tweaked the setting much in the WRR queue yet.
>>> >
>>> >>
>>> >>> I was thinking that a config option to choose the scheduler would be a
>>> >>> good idea. In terms of the project what is the better approach: create
>>> >>> a new template and each place the template class is instantiated
>>> >>> select the queue, or perform the queue selection in the same template
>>> >>> class, or something else I haven't thought of.
>>> >>
>>> >> A config option would be nice, but I'd start by just cleaning up the code
>>> >> and putting it in a new class (WeightedRoundRobinPriorityQueue or
>>> >> whatever).  If we find that it's behaving better I'm not sure how much
>>> >> value we get from a tunable.  Note that there is one other user
>>> >> (msgr/simple/DispatchQueue) that we might also was to switch over at some
>>> >> point.. especially if this implementation is faster.
>>> >>
>>> >> Once it's cleaned up (remove commented out code, new class) put it up as a
>>> >> PR and we can review and get it through testing.
>>> >
>>> > In talking with Samuel in IRC, we think creating an abstract class for
>>> > the queue is the best option. C++11 allows you to still optimize
>>> > abstract template classes if you use final in the derived class (I
>>> > verified the assembly). I'm planning to refactor the code so that
>>> > similar code can be reused between queues and allows more flexibility
>>> > in the future (components can chose the queue that works the best for
>>> > them, etc). The test for which queue to use should be a very simple
>>> > comparison and it would allow us to let it bake much longer. I hope to
>>> > have a PR mid next week.
>>> >
>>> > - ----------------
>>> > Robert LeBlanc
>>> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>> >
>>> > -----BEGIN PGP SIGNATURE-----
>>> > Version: Mailvelope v1.2.3
>>> > Comment: https://www.mailvelope.com
>>> >
>>> > wsFcBAEBCAAQBQJWPN1xCRDmVDuy+mK58QAA2XwP/1bv4DUVTfoAGU8q6RDK
>>> > xXCcqNoy2rFcG/D4wipnnGrjMYnVlH33l73hyaZiSQzMwvfzBAl5igQbIlAh
>>> > 41yqXOaGxk+BYRXRNHL5KCP0p0esjV8Wv1z9X2yfKdWeHbwueOKju5ljDQ6X
>>> > AaVXefw1fdag8JEvSjh0dsjgh8wf3G+lAcC9GHB/PFNHXYsl1BVOUz1REnno
>>> > v5vIAZz+iySb8vVrWXJUBaPdW9aao/sqJFU2ZHBziWgeIZ9OlrTlhr9znsxy
>>> > aDa18suMC8vhcrZjyAgKlSbxhgynWh7R2RjxFA5ZObBEsdbztJfg9ibyDzKG
>>> > Ngpe+jVXGTM03z4ohajzPPJ0tzj03XpGc45yXzj6Q4NHOlp5CPdzAPgmxQkz
>>> > ot5cAIR83z67PBIkemeiBQvbC4/ToVCXIBCfEPVW5Yu6grnTd4+AAKxTakip
>>> > +tXSai03MNMlNBeaBnooZ/li7s9VMSluXheZ2JNs9ssRTZkGQH3Pof3p3Y5t
>>> > pAb7qeRlxm+t+i1rZ1tn1FtF/YAx4DKGvyFz4Pzk8pe77jZ+nQLMtoOJJgGJ
>>> > w/+TGiegnUPt6pqWf/Z5o6+GB8SiM/5zKr+Xkm8aIcju/Fq0qy3fx96z81Cv
>>> > QC25ZklTblVt1ImSG30qoVcZdqWKTMwnJhpFNj8GVbzyV5EoFh4T0YBmu3fm
>>> > FKe/
>>> > =yodk
>>> > -----END PGP SIGNATURE-----
>>>
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: Mailvelope v1.2.3
>>> Comment: https://www.mailvelope.com
>>>
>>> wsFcBAEBCAAQBQJWPVZPCRDmVDuy+mK58QAAyK4QAL4ZdF0bRxSVSQAZGgDN
>>> pEfGEO1+heaj5Uj1sUitoXct5f//TbXcnuJDStlMe0rbplZDPUU0ZsXs8hNE
>>> sro6GiFuSP6ZQgHshW50d8iCGjmF/DKhYPs6jWJUIwCMelY45YLfpadAmkZT
>>> GePGEu5UzhYhlfQeiaQOFd7jWH2uVOnPLASK6f68cNRUv8rywJ8q5/6h0p8I
>>> TPg277NglGP1VntZ0z4/9CsSl49YOowVQooRZ9JQr3BpFYsbSEBBY5vLak8q
>>> X9Rb0rngG52vKT5VE58wUY/Pfbdwn7nbnV/BOUBnhBr+f14QKhNsWKpVM9EV
>>> R/cjlqJV3vesrwrXWay+4AaVoOn1TPMgBc/YV9LOlSdectNC0Ig7iBqC0Mjo
>>> kgeSQ0NJZSN99o4GKUnfwnd/fjDLzyi03XX5JkUMmEDLKPjT0LTmcnVSP5gu
>>> GGdEDNNEfIyt8PZalB4HN1Ik0c4/YdQKpb6XjbejoN37NvYom+dwZsKk2g/J
>>> Qa1bFDzvUZoTfax1yyMh2xu4b0rI6+a3bBhVBbY6Wz417aPRAhz09DecJoxt
>>> 28jqn3Aj7ARETg5BTCn1gGjEWP4IytLKOvctukCFSnxJWKPumTMRqfTUnsKu
>>> FxNjhSk5Kc+kVV7wQ7cU6NzxoBYHXMoEeamFXBmLooUG4lDKEeg0t+R9hPbT
>>> ABCA
>>> =yXJO
>>> -----END PGP SIGNATURE-----
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
