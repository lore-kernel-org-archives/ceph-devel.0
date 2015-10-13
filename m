From: Sage Weil <sage@newdream.net>
Subject: Re: enable rbd on ec pool ?
Date: Tue, 13 Oct 2015 06:20:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130618120.6589@cobra.newdream.net>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com> <561CB009.7090708@dachary.org> <EBFBEFF470372547BAACF06D39FF53A54F5A8823@SACMBXIP02.sdcorp.global.sandisk.com> <561CC274.7070906@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-918285558-1444742436=:6589"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42536 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbbJMNUh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 09:20:37 -0400
In-Reply-To: <561CC274.7070906@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Tomy Cheru <Tomy.Cheru@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-918285558-1444742436=:6589
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2015, Loic Dachary wrote:
>=20
>=20
> On 13/10/2015 09:59, Tomy Cheru wrote:
> > Hi Loic,
> > 		Thanks for your response,=20
> >=20
> > however am specifically looking for a patch to enable rbd on ec pool(=
am aware of cache tier option).
>=20
> Ah :-) I'm not aware of such a patch, even in draft state.

It was a topic of discussion at the last CDS, but it's a big effort to=20
make this work, and I don't think anybody has started yet.

http://tracker.ceph.com/projects/ceph/wiki/Osd_-_erasure_coding_pool_over=
write_support

https://www.youtube.com/watch?v=3DQVWVIBFbTcU&list=3DPLrBUGiINAakNGDE42uL=
yU2S1s_9HVevK-&index=3D12

sage

>=20
> > Thanks,
> > tomy
> >=20
> > -----Original Message-----
> > From: Loic Dachary [mailto:loic@dachary.org]=20
> > Sent: Tuesday, October 13, 2015 12:47 PM
> > To: Tomy Cheru; ceph-devel@vger.kernel.org
> > Subject: Re: enable rbd on ec pool ?
> >=20
> > Hi Tomy,
> >=20
> > On 13/10/2015 06:13, Tomy Cheru wrote:
> >> Is there a patch available to enable rbd over an EC pool ?
> >=20
> > You have to go through a cache tier instead of using it directly. See=
 http://docs.ceph.com/docs/master/rados/operations/cache-tiering/ for mor=
e information.
> >=20
> > Cheers
> >=20
> >>
> >> Currently its restricted,
> >> 2015-10-12 10:52:23.042085 7f4721ca1840 -1 librbd: error adding imag=
e=20
> >> to directory: (95) Operation not supported
> >> rbd: create error: (95) Operation not supported
> >>
> >> Thanks,
> >> tomy
> >>
> >>
> >> ________________________________
> >>
> >> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named abov=
e. If the reader of this message is not the intended recipient, you are h=
ereby notified that you have received this message in error and that any =
review, dissemination, distribution, or copying of this message is strict=
ly prohibited. If you have received this communication in error, please n=
otify the sender by telephone or e-mail (as shown above) immediately and =
destroy any and all copies of this message in your possession (whether ha=
rd copies or electronically stored copies).
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
> >> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >=20
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
> >=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--557981400-918285558-1444742436=:6589--
