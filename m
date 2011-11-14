From: Sage Weil <sage@newdream.net>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 11:48:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net>
References: <4EBF98B5.7040706@b1-systems.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-55062374-1321300132=:29742"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54878 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab1KNTsx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 14:48:53 -0500
In-Reply-To: <4EBF98B5.7040706@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mario van der Linde <linde@b1-systems.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-55062374-1321300132=:29742
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 13 Nov 2011, Mario van der Linde wrote:

> Hello,
>=20
> i'm playing around with ceph and set up a cluster with 5 nodes. cephfs
> is working fine, but if i try to use rbd i get the following error:
>=20
> > ceph1:~ # modprobe rbd
> > ceph1:~ # rbd create testimg --size 10240
> > create error: error 5: Input/output error

Can you try with=20

 rbd create testmsg --size 10240 --log-to-stderr --debug-ms 1

so we can see a bit more about what is going on?

Thanks-
sage



> > ceph1:~ # ceph --version
> > ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
>=20
> There are no log messages that give me a hint whats going wrong.
>=20
> Does anybody know what the cause of this error is?
>=20
> Here is the ceph.conf used for this cluster:
> > [global]
> >         log dir =3D /srv/ceph/out
> >         logger dir =3D /srv/ceph/log
> >        ; chdir =3D ""
> >         pid file =3D /srv/ceph/out/$type$id.pid
> > [mds]
> >         pid file =3D /srv/ceph/out/$name.pid
> >        ; lockdep =3D 1
> >        ; debug ms =3D 1
> >        ; debug mds =3D 20
> >        ; mds log max segments =3D 2
> >        max mds =3D 3
> > [osd]
> >        ; lockdep =3D 1
> >        ; debug ms =3D 1
> >        ; debug osd =3D 25
> >        ; debug journal =3D 20
> >        ; debug filestore =3D 10
> >         osd data =3D /srv/ceph/dev/osd$id
> >         osd journal =3D /srv/ceph/dev/osd$id/journal
> >         osd journal size =3D 512
> > [mon]
> >        lockdep =3D 1
> >        debug mon =3D 20
> >        debug paxos =3D 20
> >        debug ms =3D 1
> >        mon data =3D "/srv/ceph/dev/mon$id"
> > [mon.1]
> >        host =3D ceph1
> >        mon addr =3D 192.168.1.221:6789
> > [mon.2]
> >        host =3D ceph2
> >        mon addr =3D 192.168.1.222:6789
> > [mon.3]
> >        host =3D ceph3
> >        mon addr =3D 192.168.1.223:6789
> > ;[mon.4]
> > ;       host =3D ceph4
> > ;       mon addr =3D 192.168.1.224:6789
> > ;[mon.5]
> > ;       host =3D ceph5
> > ;       mon addr =3D 192.168.1.225:6789
> > [osd.1]
> >        host =3D ceph1
> >        btrfs devs =3D /dev/sda6
> > [osd.2]
> >        host =3D ceph2
> >        btrfs devs =3D /dev/sda6
> > [osd.3]
> >        host =3D ceph3
> >        btrfs devs =3D /dev/sda6
> > [osd.4]
> >        host =3D ceph4
> >        btrfs devs =3D /dev/sda6
> > [osd.5]
> >        host =3D ceph5
> >        btrfs devs =3D /dev/sda6
> > [mds.0]
> >        host =3D ceph1
> > [mds.1]
> >        host =3D ceph2
> > [mds.2]
> >        host =3D ceph3
>=20
>=20
> Greetings
> Mario
>=20
> --=20
>=20
> Mario van der Linde                  Geschaeftsfuehrer: Ralph Dehner
> Linux Consultant & Trainer           Unternehmenssitz:  Vohburg
> B1 Systems GmbH                      Amtsgericht:       Ingolstadt
> Osterfeldstra=DFe 7                    Handelsregister:   HRB 3537
> 85088 Vohburg                        http://www.b1-systems.de
> Mobil: +49 151 168 794 85
> EMail: linde@b1-systems.de
>=20
> http://pgpkeys.pca.dfn.de/pks/lookup?op=3Dget&search=3D0xD31B76884480BB04
>=20
>=20
--557981400-55062374-1321300132=:29742--
