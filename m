From: Tomy Cheru <Tomy.Cheru@sandisk.com>
Subject: RE: enable rbd on ec pool ?
Date: Tue, 13 Oct 2015 14:33:53 +0000
Message-ID: <EBFBEFF470372547BAACF06D39FF53A54F5A8A29@SACMBXIP02.sdcorp.global.sandisk.com>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com>
 <561CB009.7090708@dachary.org>
 <EBFBEFF470372547BAACF06D39FF53A54F5A8823@SACMBXIP02.sdcorp.global.sandisk.com>
 <561CC274.7070906@dachary.org>
 <alpine.DEB.2.00.1510130618120.6589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0094.outbound.protection.outlook.com ([65.55.169.94]:47411
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932419AbbJMOd7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 10:33:59 -0400
In-Reply-To: <alpine.DEB.2.00.1510130618120.6589@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage, Loic

-----Original Message-----
=46rom: Sage Weil [mailto:sage@newdream.net]=20
Sent: Tuesday, October 13, 2015 6:51 PM
To: Loic Dachary
Cc: Tomy Cheru; ceph-devel@vger.kernel.org
Subject: Re: enable rbd on ec pool ?

On Tue, 13 Oct 2015, Loic Dachary wrote:
>=20
>=20
> On 13/10/2015 09:59, Tomy Cheru wrote:
> > Hi Loic,
> > 		Thanks for your response,
> >=20
> > however am specifically looking for a patch to enable rbd on ec poo=
l(am aware of cache tier option).
>=20
> Ah :-) I'm not aware of such a patch, even in draft state.

It was a topic of discussion at the last CDS, but it's a big effort to =
make this work, and I don't think anybody has started yet.

http://tracker.ceph.com/projects/ceph/wiki/Osd_-_erasure_coding_pool_ov=
erwrite_support

https://www.youtube.com/watch?v=3DQVWVIBFbTcU&list=3DPLrBUGiINAakNGDE42=
uLyU2S1s_9HVevK-&index=3D12

sage

>=20
> > Thanks,
> > tomy
> >=20
> > -----Original Message-----
> > From: Loic Dachary [mailto:loic@dachary.org]
> > Sent: Tuesday, October 13, 2015 12:47 PM
> > To: Tomy Cheru; ceph-devel@vger.kernel.org
> > Subject: Re: enable rbd on ec pool ?
> >=20
> > Hi Tomy,
> >=20
> > On 13/10/2015 06:13, Tomy Cheru wrote:
> >> Is there a patch available to enable rbd over an EC pool ?
> >=20
> > You have to go through a cache tier instead of using it directly. S=
ee http://docs.ceph.com/docs/master/rados/operations/cache-tiering/ for=
 more information.
> >=20
> > Cheers
> >=20
> >>
> >> Currently its restricted,
> >> 2015-10-12 10:52:23.042085 7f4721ca1840 -1 librbd: error adding=20
> >> image to directory: (95) Operation not supported
> >> rbd: create error: (95) Operation not supported
> >>
> >> Thanks,
> >> tomy
> >>
> >>
> >> ________________________________
> >>
> >> PLEASE NOTE: The information contained in this electronic mail mes=
sage is intended only for the use of the designated recipient(s) named =
above. If the reader of this message is not the intended recipient, you=
 are hereby notified that you have received this message in error and t=
hat any review, dissemination, distribution, or copying of this message=
 is strictly prohibited. If you have received this communication in err=
or, please notify the sender by telephone or e-mail (as shown above) im=
mediately and destroy any and all copies of this message in your posses=
sion (whether hard copies or electronically stored copies).
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"=20
> >> in the body of a message to majordomo@vger.kernel.org More=20
> >> majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >=20
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
> >=20
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
