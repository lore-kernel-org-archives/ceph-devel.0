From: Nigel Williams <nigel.d.williams@gmail.com>
Subject: Re: [ceph-users] CephFS test-case
Date: Sat, 7 Sep 2013 10:39:56 +1000
Message-ID: <CACSYr9QJ265pskNzZLhJ-1wYu4iAHueDyu_tQiHeWwm5tb1mqA@mail.gmail.com>
References: <CACSYr9TsjHq9uWx816aPrW0SDYqwhfyfVkfcR0L-jsk-XcH9Ag@mail.gmail.com>
	<alpine.DEB.2.00.1309060825410.2805@cobra.newdream.net>
	<CACSYr9RcSbX8qhTA3QCsFOT0qLi4x5hVqCitwHzdVOASx_UNsA@mail.gmail.com>
	<alpine.DEB.2.00.1309061611580.18150@cobra.newdream.net>
	<522A6566.4020700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:59626 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3IGAj5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 20:39:57 -0400
Received: by mail-wi0-f180.google.com with SMTP id hj3so1552669wib.7
        for <ceph-devel@vger.kernel.org>; Fri, 06 Sep 2013 17:39:56 -0700 (PDT)
In-Reply-To: <522A6566.4020700@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

One way might be to have a nag system, with a global flag that can
turn nags off at the cluster level (for production deployments), but
the nags are added to the cluster-state messages on a regular basis to
remind operators that there is something to investigate.

Having an indexed list of nags would allow them to be turned off indivi=
dually.

ceph --nagoff 1

List of example of nags:

1: There are too few placement groups (PGs) for the number of nodes
and OSDs, adjust with: ceph osd pool set data pg_num XXX and: ceph osd
pool set data pgp_num XXX

2: There are too few MONs deployment for the number of nodes

3: An even number of MONs are configured, consider removing or adding
one for better efficiency

4: Journal size is too small for the write traffic, consider increasing=
 to ...

=2E..
14: /sys/block/.../queue/nr_requests is too low, adjust higher with:
echo 512 > /sys/block/sdb/queue/nr_requests, observe with iostat -x
/dev/sdX

15: Target Transaction size is too small for this CPU, adjust higher
with ceph osd set_target_transaction_size =3D 50

99: I am nagging too much aren't I...

=2E..etc...


ceph -nagon 3

Nag me about #3 as a reminder.


Definition of "nag"
v. nagged, nag=B7ging, nags
v.tr.
1. To annoy by constant scolding, complaining, or urging.
2. To torment persistently, as with anxiety or pain.



This subsystem could be called ceph-wife, but I might get into trouble
for that suggestion.



On Sat, Sep 7, 2013 at 9:29 AM, Mark Nelson <mark.nelson@inktank.com> w=
rote:
> At one point Sam and I were discussing some kind of message that woul=
dn't be
> a health warning, but something kind of similar to what you are discu=
ssing
> here.  The idea is this would be for when Ceph thinks something is
> configured sub-optimally, but the issue doesn't necessarily affect th=
e
> health of the cluster (at least in so much as everything is functioni=
ng as
> defined).  We were concerned that people might not want more things c=
ausing
> health warnings.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
