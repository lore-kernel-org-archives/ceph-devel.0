From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Re: Reliability model for RADOS - effects during second failures
Date: Fri, 4 Jul 2014 02:58:22 +0200
Message-ID: <CACUN8h0Rm-ZpwK4okPnSfPr0GRHWFgULT6WwfdMmzCTGigHzjA@mail.gmail.com>
References: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
	<CAHxYaFPU-EJb65wjRKS9_67qVqgeq-eveB1y2QD4Jz-f28uBvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48017 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaGDA6X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 20:58:23 -0400
Received: by mail-ie0-f172.google.com with SMTP id rd18so1044255iec.31
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jul 2014 17:58:22 -0700 (PDT)
In-Reply-To: <CAHxYaFPU-EJb65wjRKS9_67qVqgeq-eveB1y2QD4Jz-f28uBvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Kyle,

Thanks for your e-mail.

> 1. RADOS object (stripe count=1)

If I understand correctly, a RADOS object can be store in a stripe
with count=n, maybe 1 is the default.

> My interpretation of the models progression is:
> 1. Global population of placement groups, perhaps because we need the
> entire pool intact, eg. RGW metadata pools (upper bound for stripe
> count).
> 2. Subsection of placement groups with which we will place portions of
> our artifact eg. based on size of RBD/RGW artifacts striped across
> RADOS objects.
> 3. Multiplier, to account for the fact that the placement group will
> become degraded if any of it's members are marked out due to failure.

I cannot understand what you said above. The current tool refers to a
RADOS object. Do we need to differentiate things in fine-grain (RBD,
RGW)? Not sure if it is relevant.

I will transcript some of the things from
https://github.com/ceph/ceph-tools/blob/master/models/reliability/README.html

"This is a model of the durability of a single, arbitrary
object....That object lives in a PG."

I think it is more correct to said that the object doesn't live in a
PG but in a pool. If the pool is replicated, the number of PGs inside
a pool is (OSDx#PG_per_OSD)/#replicas (rounded to the nearest power of
two).

Now, we can list what are the components that can fail in our model. A
OSD node can fail. A OSD node can contain many disk and each disk can
fail.

What means a PG failure? Does it have sense to have many PG(from the
same pool) in the same disk? If multiple PG reside in the same disk, a
failure of a PG can refer to a failure of a disk sector?

First failure:
At this time, we need to introduce stripes into the equation. Since
the original object gets stripped and stripes go to a different OSD
the stripe count is important. Therefore, the fit rate multiplier
includes "replicas*stripes" to calculate Pfail. That makes sense to
me.

>
> Stripes are not taken into account because at this point in the model
> we are calculating the chances of the degraded placement group
> becoming further degraded by suffering the loss of another member.
> Failures of other placement groups in the same stripe, during the
> recovery of our placement group should be calculated as an independent
> event.
>

I think I follow. But the concept of pg/declustering is still giving
me some concerns.

To illustrate, I will use a toy example:
1. Object (example object: block of 100KB)
2. Object is stripped in a 4 unit stripe: obj1 obj2 obj3 obj4 (each of 25KB)
3. Object is replicated 3-way: obj1_rep1, obj1_rep2, obj1_rep3, obj2_rep1, ....
4. Object is placed in different OSDs, and maybe in different PGs
inside the same OSDs
Imagine this situation for 4 OSD and 100 PGs per each OSD:
OSD1: obj1_rep1,obj2_rep2...
OSD2: obj2_rep1, obj3_rep2, obj1_rep3...
OSD3: obj3_rep1, obj4_rep2...
OSD4: obj4_rep1, obj1_rep2...

Now, imagine that OSD1 fails. Let's say OSD1 has only one PG, so all
the chunks inside OSD1 are missing. We focus our study on the
durability of obj1. With the first failure, obj1_rep is loss. In
addition, obj2_rep2 is also missing but we ignore other elements of
the same stripe. As you said, we are not interested in independent
elements on degraded stripes...(some doubts remain regarding whether
or not this obj2_rep2 should be consider in the repairing process)

The repairing process is launched after the first failure. It needs to
copy all replicas to a spare OSD. I understand that declustering is
necessary for perfomance, but...why it is used here in the model?

A second failure occurs. The FIT rate multiplier considers '#copies-1'
and the 'declustering factor/PGs'.
The period to calculate Pfail is not the life time of the object but
the repairing time. Repair time is the bytes to be recovered divided
by repair speed and decluster factor. Adding the declustering factor
to the FIT multiplier actually cancels the decluster factor of the
repair time. I wonder why it is consider in the repair the first time?
Is it equivalent to stripe (pg=4 instead of default value=100)?

Best,
koleosfuscus
