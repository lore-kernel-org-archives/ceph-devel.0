From: lianghaoshen <lianghaoshen@ubuntukylin.com>
Subject: Re: contraining crush placement possibilities
Date: Fri, 07 Mar 2014 16:37:05 +0800
Message-ID: <53198531.1030106@ubuntukylin.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net> <5319423B.7030402@ubuntukylin.com> <531942CF.2010202@ubuntukylin.com> <53194C79.20304@ubuntukylin.com> <alpine.DEB.2.00.1403062055200.24219@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:36356 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbaCGIod (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 03:44:33 -0500
In-Reply-To: <alpine.DEB.2.00.1403062055200.24219@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Li Wang <liwang@ubuntukylin.com>, ceph-devel@vger.kernel.org

=E4=BA=8E 2014=E5=B9=B403=E6=9C=8807=E6=97=A5 13:03, Sage Weil =E5=86=99=
=E9=81=93:
> On Fri, 7 Mar 2014, Li Wang wrote:
>> Sorry, it is (n/3)*(n/3)*(n/3)/Cn3 =3D n^3/(27*Cn3)
> Cn3 is "n choose 3"?
>
>>>>> Last night it occurred to me that this is almost just having=20
>>>>> pgp_num < pg_num, but I think that's not quite right either.
> Actually, maybe it is.  Basically, say there are X combinations of 3 =
disks=20
> =3D n choose 3.  Some fraction of these, say Y, are actually used by =
CRUSH. =20
> If we are to reduce that number, that implies that there are some PGs=
 that=20
> are overlapping on the same set of disks.  Which more or less reduces=
 to=20
> the case where pgp_num < pg_num, or the hashpspool flag isn't set, or=
 any=20
> other behavior that makes more than one PG line up on the same disk. =
=20
> Just using fewer PGs in the system, in fact, would help here.  The ma=
in=20
Dose it mean that we can calculate the pgp_num according to the
reliability request, osd_num and replica_num, instead of using a given
fixed one, namely, 100 pgs/osd ? In fact , when the osd_num of a failur=
e
domain is small , 100pgs can easily cover all of the osds, which means
data lost will occur, when the down osds are in different failure domai=
ns.
> problem is that doing this tends to make the distribution less unifor=
m, so=20
> there is a tradeoff.
>
> There is a reliability model in ceph-tools.git at
>
> 	https://github.com/ceph/ceph-tools/tree/master/models/reliability
>
> that Mark Kampe built last year.  Sadly I haven't looked at it closel=
y so=20
> I'm not sure if it captures this.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Best regards,
slhhust


--=20
Best regards,
Lianghao Shen

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
