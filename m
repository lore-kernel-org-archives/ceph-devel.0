From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Kernel rbd & cephx signatures
Date: Mon, 10 Feb 2014 06:32:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402100628000.32473@cobra.newdream.net>
References: <52F3A32E.1080507@univie.ac.at> <52F887FA.7000901@univie.ac.at>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-530177067-1392042749=:32473"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48391 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaBJOc3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Feb 2014 09:32:29 -0500
In-Reply-To: <52F887FA.7000901@univie.ac.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kurt Bauer <kurt.bauer@univie.ac.at>
Cc: ceph-users <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-530177067-1392042749=:32473
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Kurt,

Your original analysis is correct: cephx signatures aren't yet implemente=
d=20
in the kernel client.  I don't have a good indication of when this will b=
e=20
prioritized, unfortunately.

I'm not aware of anybody who has targetted this or has even made note of=20
the potential vulnerability.  It requires someone to hijack the TCP=20
session in order to take advantage of it (e.g., MITM), though, so there=20
are many environments where it is not a big concern.

sage


On Mon, 10 Feb 2014, Kurt Bauer wrote:

> Hi,
>=20
> I found two maybe related bugs in the tracker (#4287, #3657) but both a=
re
> resolved, so I'm wondering if there's spmething I'm doing wrong.
> Has anybody sucessfully mapped rbd images with kernel rbd, when cephx
> require signatures is set to true in the cluster?
>=20
> Thanks for your help,
> best regards,
> Kurt
>=20
> Kurt Bauer schrieb:
>       Hi,
>=20
>       I have to "open" our CEPH cluster for some clients, that only
>       support kernel rbd. In general that's no problem and works just
>       fine (verified in our test-cluster ;-) ). I then tried to map
>       images from our production cluster and failed: rbd: add failed:
>       (95) Operation not supported
>       After some testing and comparing test and production cluster, it
>       turned out that the config option, that hinders the kernel to
>       map the image is cephx require signatures =3D true
>       If I read the documentation(http://ceph.com/docs/master/rados/ope=
rations/authentication/#backward-comp
>       atibility) correctly that flag is recommended, which leads to
>       two questions:
>       1. When will cephx signatures make it to kernel rbd (it's not
>       there till at least 3.12.0 and I've found no reference in the
>       changelogs of subsequent versions) ?
>       2. As I have to assess the risk when disabling cephx signatures,
>       do you have some estimations how probable a "real life" attack
>       is, ie. are there real threats for the whole infrastructure or
>       is it "just" possible to disturb the communication of exactly
>       that client in whose communication malicious messages are forced
>       ?
>=20
>       Thanks a lot for your help,
>       best regards,
>       Kurt
>=20
>       PS.: If my conclusion is correct, maybe that should be mentioned
>       somewhere at http://ceph.com/docs/master/rbd/rbd-ko/
>=20
>       --
>       Kurt Bauer <kurt.bauer@univie.ac.at>
>       Vienna University Computer Center - ACOnet - VIX
>       Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe
>       Tel: ++43 1 4277 - 14070 (Fax: - 814070)=A0 KB1970-RIPE
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
> --
> Kurt Bauer <kurt.bauer@univie.ac.at>
> Vienna University Computer Center - ACOnet - VIX
> Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe
> Tel: ++43 1 4277 - 14070 (Fax: - 9140)=A0 KB1970-RIPE
>=20
>=20
--557981400-530177067-1392042749=:32473--
