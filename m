From: Varada Kari <Varada.Kari@sandisk.com>
Subject: RE: loadable objectstore
Date: Mon, 22 Jun 2015 11:23:10 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C433EAD@SACMBXIP03.sdcorp.global.sandisk.com>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com>
 <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net>
 <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
 <5529387F.2040607@dachary.org>
 <alpine.DEB.2.00.1504110849020.4469@cobra.newdream.net>
 <C226B0AB34511445928D9882AA519F601C3E1D41@SACMBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1505111641080.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0080.outbound.protection.outlook.com ([207.46.100.80]:1472
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756277AbbFVLiH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 07:38:07 -0400
In-Reply-To: <alpine.DEB.2.00.1505111641080.28239@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Loic Dachary <loic@dachary.org>, "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

Please find the initial implementation of objects store factory (initia=
l cut) at https://github.com/varadakari/ceph/commit/9d5fe2fecf38ba106c7=
c7b7a3ede4f189ec7e1c8 =20
This is still work in progress branch. Right now I am facing Lttng issu=
es,=20
LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate re=
gistration of tracepoint probes having the same name is not allowed.

Might be an issue with libcommon inclusion. Trying resolving the issue =
now. Seems I need to make libcommon also as a shared object to avoid th=
e duplicates, static linking is a problem here.
Any suggestions or comments on this problem?


I have commented out test binary (ceph_test_keyvaluedb_atomicity) compi=
lation, due to unresolved symbols for g_ceph_context and g_conf. Not ab=
le to fix/workaround the problem so far.

Can you please review if this is what in your mind for the factory impl=
ementation?=20

We can extend this implementation to messenger and different backend of=
 the OSD. Will make those incremental once the base framework is approv=
ed.=20

Thanks,
Varada



-----Original Message-----
=46rom: Sage Weil [mailto:sage@newdream.net]=20
Sent: Tuesday, May 12, 2015 5:11 AM
To: Varada Kari
Cc: Loic Dachary; Matt W. Benjamin; ceph-devel
Subject: RE: loadable objectstore

Hi Varada,

Any progress on this?

Thanks!
sage

On Sat, 11 Apr 2015, Varada Kari wrote:

> Thanks Sage and Loic. Will add the missing pieces and integrate the o=
bject factory and plugin changes.=20
>=20
> Varada
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
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
> > >> Thanks for sharing the pull request. Will work on the items what=
=20
> > >> sage was mentioning in the comments along with the items in the =
tracker.
> > >=20
> > > I pushed a wip-plugin branch with the pattern I had in mind...=20
> > > does this make sense?  It's only compile tested, and still needs
> > > preload() methods implemented so that long-running daemons (or=20
> > > perhaps others?) can preload it all at once.
> > >=20
> > > Ideally we would replace ErasurePluginRegistry with this too,=20
> > > which means the naming of the .so's needs to be a bit more=20
> > > flexible as the EC plugin scheme is something like=20
> > > /usr/lib/ceph/erasure-code/libec_$name.so (not a strict function=20
> > > of type and name).  Or actually, we can just rename the EC .so's=20
> > > when this goes in?  Since they're explicitly incompatible between=
=20
> > > versions there is no reason the names need to remain consistent..=
=2E
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
> > >>> It can at least provide a starting point for discussion, if not=
=20
> > >>> a jumping off point;  I do think it's basically what Sage descr=
ibed.
> > >>
> > >> I made a few comments on the pull request.  I think a factory cl=
ass is the way to go, but we should be able to make the plugin loading =
part generic and not interface specific at all...
> > >>
> > >> sage
> > >>
> > >>>
> > >>> I was able to update the CMake build system to build the tree, =
I=20
> > >>> haven't attempted Autotools. :(
> > >>>
> > >>> Regards,
> > >>>
> > >>> Matt
> > >>>
> > >>> --
> > >>> Matt Benjamin
> > >>> CohortFS, LLC.
> > >>> 315 West Huron Street, Suite 140A Ann Arbor, Michigan 48103
> > >>>
> > >>> http://cohortfs.com
> > >>>
> > >>> tel.  734-761-4689
> > >>> fax.  734-769-8938
> > >>> cel.  734-216-5309
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
> > >>> in the body of a message to majordomo@vger.kernel.org More=20
> > >>> majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>>
> > >>>
> > >>
> > >> ________________________________
> > >>
> > >> PLEASE NOTE: The information contained in this electronic mail m=
essage is intended only for the use of the designated recipient(s) name=
d above. If the reader of this message is not the intended recipient, y=
ou are hereby notified that you have received this message in error and=
 that any review, dissemination, distribution, or copying of this messa=
ge is strictly prohibited. If you have received this communication in e=
rror, please notify the sender by telephone or e-mail (as shown above) =
immediately and destroy any and all copies of this message in your poss=
ession (whether hard copies or electronically stored copies).
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe=20
> > >> ceph-devel" in the body of a message to majordomo@vger.kernel.or=
g=20
> > >> More majordomo info at =20
> > >> http://vger.kernel.org/majordomo-info.html
> > >>
> > >>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe=20
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org=
=20
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >=20
> >=20
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
