From: Sage Weil <sage@newdream.net>
Subject: RE: loadable objectstore
Date: Mon, 11 May 2015 16:41:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505111641080.28239@cobra.newdream.net>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com> <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net> <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
 <5529387F.2040607@dachary.org> <alpine.DEB.2.00.1504110849020.4469@cobra.newdream.net> <C226B0AB34511445928D9882AA519F601C3E1D41@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-895731319-1431387678=:28239"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58048 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbEKXlT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 19:41:19 -0400
In-Reply-To: <C226B0AB34511445928D9882AA519F601C3E1D41@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: Loic Dachary <loic@dachary.org>, "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-895731319-1431387678=:28239
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Varada,

Any progress on this?

Thanks!
sage

On Sat, 11 Apr 2015, Varada Kari wrote:

> Thanks Sage and Loic. Will add the missing pieces and integrate the obj=
ect factory and plugin changes.=20
>=20
> Varada
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]=20
> Sent: Saturday, April 11, 2015 9:19 PM
> To: Loic Dachary
> Cc: Varada Kari; Matt W. Benjamin; ceph-devel
> Subject: Re: loadable objectstore
>=20
> On Sat, 11 Apr 2015, Loic Dachary wrote:
> > Hi Sage,
> >=20
> > It looks like common/PluginRegistry.{h,cc} are missing from=20
> > 18ad8df1094db52c839dc6b2dc689fc882230acb
>=20
> whoops pushed! :)
>=20
> sage
>=20
> >=20
> > Cheers
> >=20
> > On 11/04/2015 16:51, Sage Weil wrote:
> > > On Sat, 11 Apr 2015, Varada Kari wrote:
> > >> Hi Matt/ Sage,
> > >>
> > >> Thanks for sharing the pull request. Will work on the items what=20
> > >> sage was mentioning in the comments along with the items in the tr=
acker.
> > >=20
> > > I pushed a wip-plugin branch with the pattern I had in mind... does=
=20
> > > this make sense?  It's only compile tested, and still needs=20
> > > preload() methods implemented so that long-running daemons (or=20
> > > perhaps others?) can preload it all at once.
> > >=20
> > > Ideally we would replace ErasurePluginRegistry with this too, which=
=20
> > > means the naming of the .so's needs to be a bit more flexible as th=
e=20
> > > EC plugin scheme is something like=20
> > > /usr/lib/ceph/erasure-code/libec_$name.so (not a strict function of=
=20
> > > type and name).  Or actually, we can just rename the EC .so's when=20
> > > this goes in?  Since they're explicitly incompatible between=20
> > > versions there is no reason the names need to remain consistent...
> > >=20
> > > sage
> > >=20
> > >>
> > >> Varada
> > >>
> > >> -----Original Message-----
> > >> From: Sage Weil [mailto:sage@newdream.net]
> > >> Sent: Saturday, April 11, 2015 4:16 AM
> > >> To: Matt W. Benjamin
> > >> Cc: Varada Kari; ceph-devel
> > >> Subject: Re: loadable objectstore
> > >>
> > >> On Fri, 10 Apr 2015, Matt W. Benjamin wrote:
> > >>> Hi Varada,
> > >>>
> > >>> I pushed branch hammer-osfactory to=20
> > >>> https://github.com/linuxbox2/ceph.git
> > >>>
> > >>> It can at least provide a starting point for discussion, if not a=
=20
> > >>> jumping off point;  I do think it's basically what Sage described=
.
> > >>
> > >> I made a few comments on the pull request.  I think a factory clas=
s is the way to go, but we should be able to make the plugin loading part=
 generic and not interface specific at all...
> > >>
> > >> sage
> > >>
> > >>>
> > >>> I was able to update the CMake build system to build the tree, I=20
> > >>> haven't attempted Autotools. :(
> > >>>
> > >>> Regards,
> > >>>
> > >>> Matt
> > >>>
> > >>> --
> > >>> Matt Benjamin
> > >>> CohortFS, LLC.
> > >>> 315 West Huron Street, Suite 140A
> > >>> Ann Arbor, Michigan 48103
> > >>>
> > >>> http://cohortfs.com
> > >>>
> > >>> tel.  734-761-4689
> > >>> fax.  734-769-8938
> > >>> cel.  734-216-5309
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
> > >>> in the body of a message to majordomo@vger.kernel.org More=20
> > >>> majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>>
> > >>>
> > >>
> > >> ________________________________
> > >>
> > >> PLEASE NOTE: The information contained in this electronic mail mes=
sage is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you are=
 hereby notified that you have received this message in error and that an=
y review, dissemination, distribution, or copying of this message is stri=
ctly prohibited. If you have received this communication in error, please=
 notify the sender by telephone or e-mail (as shown above) immediately an=
d destroy any and all copies of this message in your possession (whether =
hard copies or electronically stored copies).
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe=20
> > >> ceph-devel" in the body of a message to majordomo@vger.kernel.org=20
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>
> > >>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe=20
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org=20
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >=20
> >=20
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-895731319-1431387678=:28239--
