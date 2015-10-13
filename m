From: Tomy Cheru <Tomy.Cheru@sandisk.com>
Subject: RE: enable rbd on ec pool ?
Date: Tue, 13 Oct 2015 07:59:21 +0000
Message-ID: <EBFBEFF470372547BAACF06D39FF53A54F5A8823@SACMBXIP02.sdcorp.global.sandisk.com>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com>
 <561CB009.7090708@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0063.outbound.protection.outlook.com ([65.55.169.63]:45952
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752401AbbJMH70 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 03:59:26 -0400
In-Reply-To: <561CB009.7090708@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,
		Thanks for your response,=20

however am specifically looking for a patch to enable rbd on ec pool(am=
 aware of cache tier option).

Thanks,
tomy

-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]=20
Sent: Tuesday, October 13, 2015 12:47 PM
To: Tomy Cheru; ceph-devel@vger.kernel.org
Subject: Re: enable rbd on ec pool ?

Hi Tomy,

On 13/10/2015 06:13, Tomy Cheru wrote:
> Is there a patch available to enable rbd over an EC pool ?

You have to go through a cache tier instead of using it directly. See h=
ttp://docs.ceph.com/docs/master/rados/operations/cache-tiering/ for mor=
e information.

Cheers

>=20
> Currently its restricted,
> 2015-10-12 10:52:23.042085 7f4721ca1840 -1 librbd: error adding image=
=20
> to directory: (95) Operation not supported
> rbd: create error: (95) Operation not supported
>=20
> Thanks,
> tomy
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
