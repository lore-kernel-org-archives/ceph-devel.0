From: Kyle Bader <kyle@inktank.com>
Subject: Re: Reliability model for RADOS - effects during second failures
Date: Wed, 2 Jul 2014 22:09:04 -0700
Message-ID: <CAHxYaFPU-EJb65wjRKS9_67qVqgeq-eveB1y2QD4Jz-f28uBvA@mail.gmail.com>
References: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:55178 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaGCFJG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 01:09:06 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so8731732lbv.14
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jul 2014 22:09:04 -0700 (PDT)
In-Reply-To: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> The current code uses a =E2=80=9CFIT rate multiplier=E2=80=9D to incl=
ude for instance
> the effect of operations done in parallel. That multiplier (n) has an
> effect on Pfail. In the initial failure, it is calculated using the
> number of replicas and the stripe count as seen in
> https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rad=
osRely.py#L86.

So I'm not sure what term we want to use for what we are calculating
the durability of but for the sake of this explanation I'll use
"artifact", which will refer to a collection of objects that compose
a:

1. RADOS object (stripe count=3D1)
2. RBD volume
3. RGW S3 or Swift object
4. RGW metadata pools
5. I'm probably forgetting something

My interpretation of the models progression is:

1. Global population of placement groups, perhaps because we need the
entire pool intact, eg. RGW metadata pools (upper bound for stripe
count).
2. Subsection of placement groups with which we will place portions of
our artifact eg. based on size of RBD/RGW artifacts striped across
RADOS objects.
3. Multiplier, to account for the fact that the placement group will
become degraded if any of it's members are marked out due to failure.

> The thing that doesn=E2=80=99t have sense to me is the way the multip=
lier is
> calculated for the failure of the remaining copies in
> https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rad=
osRely.py#L92
> Why the stripes are not taking into account?

Stripes are not taken into account because at this point in the model
we are calculating the chances of the degraded placement group
becoming further degraded by suffering the loss of another member.
=46ailures of other placement groups in the same stripe, during the
recovery of our placement group should be calculated as an independent
event.

> What is the purpose of
> using the =E2=80=9Cdeclustering factor=E2=80=9D on that equation?

My understanding is the declustering factor is synonymous with
placement groups (pg)

> Is that equation
> correct? I read this note by sage
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
> trying to clarify the role of PGs but didn=E2=80=99t help me to under=
stand it.

To distribute objects across the cluster we need to divvy up objects
into groupings, in the context of Ceph those groupings are PGs
(placement groups). There is a cost associated with maintaining each
placement group, and the benefit is finer distribution granularity can
improve utilization at the high end. This should be reflected in the
full/nearfull tunables we set for our cluster:

http://ceph.com/docs/master/rados/configuration/mon-config-ref/#storage=
-capacity

> Besides, I have a simple question related with the equation on L86 fo=
r
> the initial failure. The stripping process splits user content in
> #number of objects, which equivalent to the stripe count. That group
> of objects constitutes an object set. Each object is composed by one
> or more stripes units. All stripes units (stripe count) are written i=
n
> parallel. Typically each object is mapped to a different disk.  What
> happen when the object set is full and a new object is started?

It places a second (or more) object in one of the placement groups
that already has another object belonging to the same artifact. In
this way you can have arbitrarily sized artifacts and still limit the
number of placement groups in order to reduce the probability of
failure.

--=20
Kyle Bader - Inktank
Senior Solution Architect
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
