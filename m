From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Keys & caps
Date: Mon, 09 Jul 2012 19:27:42 +0200
Message-ID: <1968682.cis2SWxC6X@mranderson>
References: <4183318.yLl07ggMzS@mranderson> <Pine.LNX.4.64.1207090925370.20547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from strudel.ki.iif.hu ([193.6.222.244]:53050 "EHLO
	strudel.ki.iif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2GIR1v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 13:27:51 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by strudel.ki.iif.hu (Postfix) with ESMTP id B2ED73F1
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jul 2012 19:27:50 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id 2Ow1hxZ+GNft for <ceph-devel@vger.kernel.org>;
	Mon,  9 Jul 2012 19:27:46 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:410:7506:f08e:836e:869b])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 88E6C3F2
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jul 2012 19:27:43 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.1207090925370.20547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 9. 09:33:22 Sage Weil wrote:
> On Mon, 9 Jul 2012, Sz=E9kelyi Szabolcs wrote:
> > this far I accessed my Ceph (0.48) FS with the client.admin key, bu=
t I'd
> > like to change that since I don't want to allow clients to control =
the
> > cluster.
> >=20
> > I thought I should create a new key, give it some caps (don't exact=
ly know
> > which ones), and distribute it to clients. Here are some things I d=
on't
> > know/understand:
> >=20
> > * What do the r, w, x, and * caps ("permissions"?) mean on a mon, m=
ds, or
> > osd?
>=20
> They roughly correspond to read, write, execute.  The distinction is
> subtle and poorly specfied for mon caps; just use the documented valu=
es
> for now.

Does this mean that what I'm trying to achieve is not possible at the m=
oment?=20
I'd like to give access to my clients to the data in the filesystem, bu=
t not=20
control over the cluster. My thought was that removing some mon caps fr=
om the=20
clients' keys will get me there. But from what you write, it looks to m=
e like=20
if a client can access the data in the filesystem, it can also (for exa=
mple)=20
bring the cluster down...

> The problem is that the mount.ceph command doesn't understand keyring=
s; it
> only understands secret=3D and secretfile=3D.  There is a longstandin=
g feature
> bug open for this
>=20
> 	http://tracker.newdream.net/issues/266
>=20
> but it hasn't been prioritized.  Sorry for the confusion!  It will ha=
ppen
> soon.
>=20
> In the meantime, you need
>=20
> 	 -o secretfile=3D/path/to/secretfile,name=3Daccess_fs

Is this also true for the FUSE client? I have obscure memories about bi=
g=20
differences between the kernel and the FUSE client, for example the lat=
ter=20
being able to read ceph.conf, and get the necessary info, including the=
=20
keyring file, from there. Maybe I didn't emphasize it, but that's what =
I'm=20
using.

Thanks,
--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
