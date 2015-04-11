From: Sage Weil <sage@newdream.net>
Subject: Re: loadable objectstore
Date: Sat, 11 Apr 2015 08:49:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504110849020.4469@cobra.newdream.net>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com> <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net> <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
 <5529387F.2040607@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-874740292-1428767355=:4469"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57134 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbDKPtP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Apr 2015 11:49:15 -0400
In-Reply-To: <5529387F.2040607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-874740292-1428767355=:4469
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2015, Loic Dachary wrote:
> Hi Sage,
>=20
> It looks like common/PluginRegistry.{h,cc} are missing from 18ad8df1094=
db52c839dc6b2dc689fc882230acb

whoops pushed! :)

sage

>=20
> Cheers
>=20
> On 11/04/2015 16:51, Sage Weil wrote:
> > On Sat, 11 Apr 2015, Varada Kari wrote:
> >> Hi Matt/ Sage,
> >>
> >> Thanks for sharing the pull request. Will work on the items what sag=
e=20
> >> was mentioning in the comments along with the items in the tracker.
> >=20
> > I pushed a wip-plugin branch with the pattern I had in mind... does t=
his=20
> > make sense?  It's only compile tested, and still needs preload() meth=
ods=20
> > implemented so that long-running daemons (or perhaps others?) can pre=
load=20
> > it all at once.
> >=20
> > Ideally we would replace ErasurePluginRegistry with this too, which m=
eans=20
> > the naming of the .so's needs to be a bit more flexible as the EC plu=
gin=20
> > scheme is something like /usr/lib/ceph/erasure-code/libec_$name.so (n=
ot a=20
> > strict function of type and name).  Or actually, we can just rename t=
he=20
> > EC .so's when this goes in?  Since they're explicitly incompatible=20
> > between versions there is no reason the names need to remain=20
> > consistent...
> >=20
> > sage
> >=20
> >>
> >> Varada
> >>
> >> -----Original Message-----
> >> From: Sage Weil [mailto:sage@newdream.net]
> >> Sent: Saturday, April 11, 2015 4:16 AM
> >> To: Matt W. Benjamin
> >> Cc: Varada Kari; ceph-devel
> >> Subject: Re: loadable objectstore
> >>
> >> On Fri, 10 Apr 2015, Matt W. Benjamin wrote:
> >>> Hi Varada,
> >>>
> >>> I pushed branch hammer-osfactory to
> >>> https://github.com/linuxbox2/ceph.git
> >>>
> >>> It can at least provide a starting point for discussion, if not a
> >>> jumping off point;  I do think it's basically what Sage described.
> >>
> >> I made a few comments on the pull request.  I think a factory class =
is the way to go, but we should be able to make the plugin loading part g=
eneric and not interface specific at all...
> >>
> >> sage
> >>
> >>>
> >>> I was able to update the CMake build system to build the tree, I
> >>> haven't attempted Autotools. :(
> >>>
> >>> Regards,
> >>>
> >>> Matt
> >>>
> >>> --
> >>> Matt Benjamin
> >>> CohortFS, LLC.
> >>> 315 West Huron Street, Suite 140A
> >>> Ann Arbor, Michigan 48103
> >>>
> >>> http://cohortfs.com
> >>>
> >>> tel.  734-761-4689
> >>> fax.  734-769-8938
> >>> cel.  734-216-5309
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> >>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
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
" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--557981400-874740292-1428767355=:4469--
