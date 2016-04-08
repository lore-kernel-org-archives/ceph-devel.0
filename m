From: Wido den Hollander <wido@42on.com>
Subject: Re: releasing hammer v0.94.7 ?
Date: Fri, 8 Apr 2016 08:35:42 +0200 (CEST)
Message-ID: <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <57067073.9040200@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:44487 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbcDHGfy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 02:35:54 -0400
In-Reply-To: <57067073.9040200@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>


> Op 7 april 2016 om 16:36 schreef Loic Dachary <loic@dachary.org>:
>=20
>=20
> Hi Sage,
>=20
> Here are the issues that would be in hammer v0.94.7 if we decided to =
release
> it now: http://tracker.ceph.com/versions/511
> And here is the backport queue :
> http://tracker.ceph.com/projects/ceph/issues?query_id=3D78
>=20
> Do you think it is time to cut the release and ask QE to start testin=
g ?
>=20

As this might be the last Hammer release I wonder if we could fix this =
bug:
http://tracker.ceph.com/issues/15348

I already submitted a PR for it: https://github.com/ceph/ceph/pull/8441

I backported it on a production cluster to Hammer and it works fine. Mi=
ght be
something we can squeeze in?

Wido

> Cheers
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
