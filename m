From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Keys & caps
Date: Wed, 11 Jul 2012 01:11:30 +0200
Message-ID: <1619446.aT01BgUE1G@mranderson>
References: <4183318.yLl07ggMzS@mranderson> <1968682.cis2SWxC6X@mranderson> <CAPYLRzgn6NC9193y4HsH7ASevtX-QWq9P=RrYJpmD3uvyoi8LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.ki.iif.hu ([193.6.222.244]:58743 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764Ab2GJXLj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 19:11:39 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 395F83ED
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 01:11:37 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id trD9ahfBlP3n for <ceph-devel@vger.kernel.org>;
	Wed, 11 Jul 2012 01:11:33 +0200 (CEST)
Received: from mranderson.localnet (catv-89-132-116-194.catv.broadband.hu [89.132.116.194])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 010AD3BE
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 01:11:31 +0200 (CEST)
In-Reply-To: <CAPYLRzgn6NC9193y4HsH7ASevtX-QWq9P=RrYJpmD3uvyoi8LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 10. 13:09:10 Gregory Farnum wrote:
> On Mon, Jul 9, 2012 at 10:27 AM, Sz=C3=A9kelyi Szabolcs <szekelyi@nii=
f.hu> wrote:
> > On 2012. July 9. 09:33:22 Sage Weil wrote:
> >> On Mon, 9 Jul 2012, Sz=C3=A9kelyi Szabolcs wrote:
> >> > this far I accessed my Ceph (0.48) FS with the client.admin key,=
 but
> >> > I'd
> >> > like to change that since I don't want to allow clients to contr=
ol the
> >> > cluster.
> >> >=20
> >> > I thought I should create a new key, give it some caps (don't ex=
actly
> >> > know
> >> > which ones), and distribute it to clients. Here are some things =
I don't
> >> > know/understand:
> >> >=20
> >> > * What do the r, w, x, and * caps ("permissions"?) mean on a mon=
, mds,
> >> > or
> >> > osd?
> >>=20
> >> They roughly correspond to read, write, execute.  The distinction =
is
> >> subtle and poorly specfied for mon caps; just use the documented v=
alues
> >> for now.
> >=20
> > Does this mean that what I'm trying to achieve is not possible at t=
he
> > moment? I'd like to give access to my clients to the data in the
> > filesystem, but not control over the cluster. My thought was that
> > removing some mon caps from the clients' keys will get me there. Bu=
t from
> > what you write, it looks to me like if a client can access the data=
 in
> > the filesystem, it can also (for example) bring the cluster down...
>=20
> I believe your filesystem clients only need  'allow r' on the
> monitors, and they should be good with 'allow rw' on the OSDs (though
> still "allow" on the MDS). This is distinct from the "allow *" cap an=
d
> does minimize some ability to cause damage. :)

Great, thanks!

> >> The problem is that the mount.ceph command doesn't understand keyr=
ings;
> >> it
> >> only understands secret=3D and secretfile=3D.  There is a longstan=
ding
> >> feature
> >> bug open for this
> >>=20
> >>       http://tracker.newdream.net/issues/266
> >>=20
> >> but it hasn't been prioritized.  Sorry for the confusion!  It will=
 happen
> >> soon.
> >>=20
> >> In the meantime, you need
> >>=20
> >>        -o secretfile=3D/path/to/secretfile,name=3Daccess_fs
> >=20
> > Is this also true for the FUSE client? I have obscure memories abou=
t big
> > differences between the kernel and the FUSE client, for example the=
 latter
> > being able to read ceph.conf, and get the necessary info, including=
 the
> > keyring file, from there. Maybe I didn't emphasize it, but that's w=
hat I'm
> > using.
>=20
> When using ceph-fuse, you want to specify the name with
> --name=3Daccess_fs =E2=80=94 no -o required.

Okay, so I don't need the "client." prefix for the key name, but how ca=
n I=20
specify the --name=3D option in fstab? Or is it possible to specify it =
in=20
ceph.conf, so it can be read by ceph-fuse when called by mount?

Thanks,
--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
