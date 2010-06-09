From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Wed, 09 Jun 2010 17:11:55 +0200
Message-ID: <1276096315.2284.12.camel@wido-laptop.pcextreme.nl>
References: <Pine.LNX.4.64.1006081047120.15202@cobra.newdream.net>
	 <4C0FAB66.6030003@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:51215 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab0FIPL6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jun 2010 11:11:58 -0400
In-Reply-To: <4C0FAB66.6030003@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

=46or every backend (like NFS, Ceph, CIFS, etc, etc) FS-Cache needs a
custom module. So in theory it should work with Ceph, but someone would
have to write a backend for it.

I don't really know what the benefit would be for Ceph, sometimes
caching can slow things down rather then speeding up.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Wed, 2010-06-09 at 14:55 +0000, Tomasz Chmielewski wrote:
> Am 08.06.2010 19:51, Sage Weil wrote:
> > On Tue, 8 Jun 2010, Tomasz Chmielewski wrote:
> >> I'd like to build a cluster for storing large amounts of data.
> >>
> >> The cluster would consist of slow (cheap) storage and fast (expens=
ive)
> >> storage.
> >>
> >> I would like to migrate data from fast (expensive) storage to slow=
 (cheap)
> >> storage if it wasn't accessed for, say, 6 months.
> >>
> >> Would ceph somehow help me achieve that?
> >
> > We don't currently have that functionality.  In principle it's cert=
ainly
> > something the system could do, and the underlying storage architect=
ure
> > lends itself to that:
>=20
> Hmm, since quite recently, Linux kernel has FS-Cache, which:
>=20
> 	This facility is a general purpose cache for network
> 	filesystems, though it could be used for caching other things
> 	such as ISO9660 filesystems too.
>=20
>=20
> I wonder if it could work with ceph and/or traditional filesystems, t=
oo?
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
