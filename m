From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Wed, 2 Mar 2016 18:32:18 +0700
Message-ID: <56D6CF42.7080909@dachary.org>
References: <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
 <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
 <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
 <1456745435596.21796@croc.ru>
 <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
 <56D45CCC.8010608@dachary.org>
 <alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>
 <20160302010625.GA10914@onthe.net.au> <1456913706999.87255@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53530 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbcCBLcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 06:32:39 -0500
In-Reply-To: <1456913706999.87255@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, Chris Dunlop <chris@onthe.net.au>



On 02/03/2016 17:15, Odintsov Vladislav wrote:
> Hi,
>=20
> it looks very strange, that LTS release suddenly stopped support of o=
ne of OS'es in the middle of lifecycle. Especially when there are no te=
chnical problems.
> How can we help community with building hammer branch officially?
>=20

Hi,

I think you misread what Sage wrote : "The intention was to continue bu=
ilding stable releases (0.94.x) on the old list of supported platforms =
(which inclues 12.04 and el6)". In other words, the old OS'es are still=
 supported. Their absence is a glitch in the release process that will =
be fixed.

Cheers

> ________________________________
> Regards,
>=20
> Vladislav Odintsov
>=20
> ________________________________________
> From: ceph-users <ceph-users-bounces@lists.ceph.com> on behalf of Chr=
is Dunlop <chris@onthe.net.au>
> Sent: Wednesday, March 2, 2016 04:06
> To: Sage Weil
> Cc: Loic Dachary; ceph-devel@vger.kernel.org; ceph-users@ceph.com
> Subject: Re: [ceph-users] v0.94.6 Hammer released
>=20
> Hi,
>=20
> The "old list of supported platforms" includes debian wheezy.
> Will v0.94.6 be built for this?
>=20
> Chris
>=20
> On Mon, Feb 29, 2016 at 10:57:53AM -0500, Sage Weil wrote:
>> The intention was to continue building stable releases (0.94.x) on t=
he old
>> list of supported platforms (which inclues 12.04 and el6).  I think =
it was
>> just an oversight that they weren't built this time around.  I the
>> overhead to doing so is just keeping a 12.04 and el6 jenkins build s=
lave
>> around.
>>
>> Doing this builds in the existing environment sounds much better tha=
n
>> trying to pull in externally built binaries...
>>
>> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
