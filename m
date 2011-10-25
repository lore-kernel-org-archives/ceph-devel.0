From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: BUG at fs/inode.c
Date: Tue, 25 Oct 2011 10:38:06 +0200
Message-ID: <201110251038.06482.a.ott@m-privacy.de>
References: <201110241239.13157.a.ott@m-privacy.de> <CAC-hyiEcNcJGsMLWa6WVhM6gABYKgeKo2aFMvOEtuu7kQqN9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:47913 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab1JYIiQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2011 04:38:16 -0400
In-Reply-To: <CAC-hyiEcNcJGsMLWa6WVhM6gABYKgeKo2aFMvOEtuu7kQqN9ow@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Monday 24 October 2011 wrote Yehuda Sadeh Weinraub:
> On Mon, Oct 24, 2011 at 3:39 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > we have hit a kernel bug with current ceph-client master (commit
> > a2742a09568f81315e0f30021f29f14e7cd3924b), which I assume to be a C=
eph
> > bug.
>
> Is it easily reproducible? What's the scenario?

It is quite easy to reproduce. We run a virtual test cluster with two n=
odes,=20
each running OSD, MDS and MON, but using "max mon =3D 1".

Cephfs is mounted on both nodes so that they share the same data. Kerne=
l is=20
3.0.7 with PaX, RSBAC and ceph-client master. The intention is to have =
a=20
scalable cluster of servers where any number of nodes may fail at any t=
ime,=20
as long as there are always enough left to keep at least one copy of th=
e data=20
and restore redundancy. If it works out as expected, we want to scale t=
o 20=20
or even more nodes, depending on the needs of our customers.

> > Kernel is x86-32, Ceph is running on a two node cluster over ext4. =
The
> > kernel traces are attached, the system dies shortly after these mes=
sages.
> > The bug is reproducable. I have not found anything useful in ceph b=
ug
> > tracker when searching for "fs/inode.c".
>
> How many mds servers?

We run a test cluster with two nodes, each running OSD, MDS and MON, bu=
t=20
using "max mon =3D 1".

> > Around fs/inode.c line 1375 mentioned in the trace is the iput()
> > function: void iput(struct inode *inode)
> > {
> > =A0 =A0 =A0 =A0if (inode) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(inode->i_state & I_CLEAR);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atomic_dec_and_lock(&inode->i_co=
unt, &inode->i_lock))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iput_final(inode);
> > =A0 =A0 =A0 =A0}
> > }
> >
> > So inode->i_state seems to be incorrect when iput() is called, mayb=
e a
> > double call to iput() or a missing iget() somewhere. Is this really=
 a
> > Ceph bug or have I messed up our kernel code when merging patches?
>
> What patches?

See above. PaX, RSBAC and Ceph master. I have been merging the first tw=
o in=20
for years now, being the RSBAC main author myself.

> Also, the client logs could help shedding a light on the issue. You
> should have dynamic debugging turned on (CONFIG_DYNAMIC_DEBUG), and
> something along the lines of:
>
> # mount -t debugfs none /sys/kernel/debug
> # echo 'module ceph +p' > /sys/kernel/debug/dynamic_debug/control
> # echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control

New kernels are building right now. Upgraded to 3.0.8, put in new ceph-=
client=20
master fix 8ba1683acc83aee4bcab304844f8e60330e5ef1f and added=20
CONFIG_DYNAMIC_DEBUG. This kernel will go into two big servers this tim=
e to=20
give it some real load. Let's see whether I can reproduce there, too. I=
f so,=20
I will provide debug output as requested.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
