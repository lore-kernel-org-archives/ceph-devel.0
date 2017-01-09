From: Samuel Just <sjust@redhat.com>
Subject: Re: PG stuck unclean after rebalance-by-weight
Date: Mon, 9 Jan 2017 07:59:16 -0800
Message-ID: <CAN=+7FUfLXG2Q-9UySzRn3i+iVeBsG7Vjn6-K-VbM5tF-HPaWA@mail.gmail.com>
References: <F6CE90086791D84F8329539EF4C81484E0241E59@GRPCPHMBX11.ramboll-group.global.network>
 <CAN=+7FX2c=SGkX2dyD78BLWYsezCTdfLX_mwiSCUtqKjtVpZdw@mail.gmail.com> <F6CE90086791D84F8329539EF4C81484E0248705@GRPCPHMBX11.ramboll-group.global.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36482 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935145AbdAIP7S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 10:59:18 -0500
Received: by mail-qk0-f170.google.com with SMTP id 11so46308107qkl.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 07:59:18 -0800 (PST)
In-Reply-To: <F6CE90086791D84F8329539EF4C81484E0248705@GRPCPHMBX11.ramboll-group.global.network>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Dueholm Christensen <JEDC@ramboll.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yep, we'd love a PR with some updates to the docs about how to avoid
this scenario.  You are correct about why crush needs a lot of retries
with that crushmap to output 3 replicas for all pgs.  You need
min_size to avoid a case where you accepted a write on 1 osd, but then
lost that 1 osd.
-Sam

On Mon, Jan 9, 2017 at 5:09 AM, Jens Dueholm Christensen
<JEDC@ramboll.com> wrote:
> Hi Samuel
>
> The lack of reply and some off-list conversations had me test a few things over the weekend:
>
> 1) Playing around with different crushmap settings with no success - every test didn't produce any bad mappings or had to retry a placement more than 50 times (I remember I saw up to 23-25 attempts)
> 2) Lowering the OSD weight further made more PGs become stuck unclean
> 3) Lowering the weight to 0 and/or out'ing osd.1 moved the acting OSD id to another OSD, but the PG was still stuck unclean
> 4) Raising the OSD weight up in small increments (0.05) eventually made the PG clean+active
> 5) Lowering another OSD's OSD weight made other PGs become stuck unclean, while raising the weight again made the PGs recover.
>
> .. and then it dawned (and I hope I'm right..):
>
> Since the CRUSH weight of nodes ceph4 and ceph5 is relative high compared to nodes ceph1-3, a lower OSD weight for OSDs on nodes ceph1-3 will eventually cause problems for CRUSH since I have "type host" and not "type osd" in my ruleset chooseleaf - my cluster is simply not evenly dimensioned for a "proper" reweight to be successful.
>
> This unbalance and a lower and lower OSD weight makes it harder and harder for CRUSH to place a PG onto the 6 OSDs (osd.0-5 on nodes ceph1-3) up to a point where CRUSH had tried "choose_total_tries" times and then gives up.
>
> This made me raise the OSD weight to 0.7 for the 6 OSDs, which in turn left 1 PG stuck unclean.
> Then by raising choose_total_tries to 100 (I did not test 75) the PG became active+clean.
>
> .. and that's where I am now.
>
> I assume that I really ought to correct the imbalance in the hardware before changing the weight of any OSD again, and I take this experience as a leasson learned.
>
> Perhaps a small writeup in the docs about not trying to correct an imbalanced cluster by reweighing is in order and as something to be avoided?
>
>
> BTW, why should I change min_size to 2?
> I know that default copies should never be lower than 3 to avoid some possible nasty errors, but as I understand the documentation (It's even written in the first box in the top of http://docs.ceph.com/docs/master/rados/configuration/pool-pg-config-ref/), setting it to 1 only allow writes in a severly degraded state to be accepted - ie. if only 1 node is available.
>
> Regards,
> Jens Dueholm Christensen
> Rambøll Survey IT
>
> On Friday, January 06, 2017 4:54 PM, Samuel Just <sjust@redhat.com> wrote:
>
>> You should not have min_size set to 1, set it to 2 (not related to
>> your problem, but important).
>
>> http://docs.ceph.com/docs/master/rados/operations/crush-map/ has a
>> summary of the crush map tunables.
>
>> You might try kicking tunable choose_total_tries 50 to 75.  You should
>> use osdmaptool on an osdmap grabbed from your cluster to experiment
>> with new crushmap settings without actually injecting the new
>> crushmap.
>
