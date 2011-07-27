From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Two questions
Date: Wed, 27 Jul 2011 09:14:25 +0200
Message-ID: <1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
References: <8685614628192678277@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54226 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1G0HO2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 03:14:28 -0400
In-Reply-To: <8685614628192678277@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir?= Skowron <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Wed, 2011-07-27 at 07:58 +0200, S=C5=82awomir Skowron wrote:
> Hello. I have some questions.
>=20
> 1. Is there any chance to change default 4MB object size to for
> example 1MB or less ??

If you are using the filesystem, you can change the stripe-size per
directory with the "cephfs" tool.

>=20
> 2. I have create cluster of two mons, and 32 osd (1TB each) on two
> machines. At this radosgw with apache2 for test. When i putting data
> from s3 client to rados, everything is ok, but when one of osd is
> going down all s3 clients going to be freeze for some seconds, before
> ceph sign this osd as down, and then everything is starting working
> again wit degraded osd. How can i tune this marking as a down for ms
> or 0 :) and not for seconds freeze ??

Normally a OSD should be down within about 10 seconds and shouldn't
affect all I/O operations.

By default it takes 300 seconds before a OSD gets marked as "out", this
is handled by "mon osd down out interval"

If you want to change the "down" reporting behaviour you could do this
with "osd min down reporters" and "osd min down reports". I'm not sure
you really want to do this, as the default values should be ok.

Wido

>=20
> My setup is debian 6.0, kernel 2.6.37.6  x86_64 and ceph version
> 0.31-10 from stable repo.
>=20
> Best regards
>=20
> Slawomir Skowron
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
