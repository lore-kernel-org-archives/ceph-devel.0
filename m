From: Sage Weil <sage@inktank.com>
Subject: Re: Keys & caps
Date: Mon, 9 Jul 2012 09:33:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207090925370.20547@cobra.newdream.net>
References: <4183318.yLl07ggMzS@mranderson>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1341915692-1341851602=:20547"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42352 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2GIQd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:33:28 -0400
In-Reply-To: <4183318.yLl07ggMzS@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1341915692-1341851602=:20547
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 9 Jul 2012, Sz=E9kelyi Szabolcs wrote:
> Hello,
>=20
> this far I accessed my Ceph (0.48) FS with the client.admin key, but I'd =
like=20
> to change that since I don't want to allow clients to control the cluster=
=2E
>=20
> I thought I should create a new key, give it some caps (don't exactly kno=
w=20
> which ones), and distribute it to clients. Here are some things I don't=
=20
> know/understand:
>=20
> * What do the r, w, x, and * caps ("permissions"?) mean on a mon, mds, or=
 osd?

They roughly correspond to read, write, execute.  The distinction is=20
subtle and poorly specfied for mon caps; just use the documented values=20
for now.  For the mds, it's just 'allow', as we haven't properly defined=20
those yet either.  The osd ones are the most useful and well defined. =20
There is a grammar in osd/OSDCap.h if you can grok the boost::spirit=20
syntax.  In addition to rwx, you can grant by pool or object prefix. =20
There is some preliminary/incomplete support for fine-grained control over=
=20
the use of rados classes.

> * What's the difference between (for example) 'allow rw' and 'rw' caps? `=
ceph=20
> auth` seems to understand (and display as specified) both forms.

'rw' is nonsense... it needs to be (a list of) 'allow <something>'=20
phrase(s).  From the monitor's perspective, the osd and mds caps are=20
opaque, so it won't enforce a particular syntax.  At some point we can=20
make it verify they parse properly, but that hasn't happened yet.

> Not to run into issues with caps, I've created a key with the same caps a=
s the=20
> current client.admin, but with a different key, called client.access_fs. =
I=20
> planned to narrow down the caps after I made the mount work with the new =
key.
>=20
> $ sudo ceph auth list
> installed auth entries:=20
> [...]
> client.access_fs
>         key: AQ...=3D=3D
>         caps: [mds] allow
>         caps: [mon] allow *
>         caps: [osd] allow *
> [...]
>=20
> I've copied the key to the client as /etc/ceph/keyring:
>=20
> [client.access_fs]
>         key =3D AQ...=3D=3D
>=20
> I have 'keyring =3D /etc/ceph/keyring' in my ceph.conf [global] section o=
n the=20
> client. Now trying to mount the filesystem fails with
>=20
> $ sudo mount /mnt/ceph
> ceph-fuse[1784]: starting ceph client
> ceph-fuse[1784]: ceph mount failed with (1) Operation not permitted
> ceph-fuse[1782]: mount failed: (1) Operation not permitted
>=20
> Adding '-o name=3Dclient.access_fs' to the command line yields the same r=
esult.=20
> If I copy the client.admin key into the keyring file, it works. (However,=
=20
> adding the same mount option again (so the name=3D parameter and the key =
name in=20
> the file do not match), I get an error (which seems okay to me, not sure =
about=20
> the correctness):
>=20
> $ sudo mount /cloud/ -o name=3Dclient.access_fs
> ceph-fuse[1835]: starting ceph client
> ceph-fuse[1835]: starting fuse
> fuse: unknown option `name=3Dclient.access_fs'
> 2012-07-09 16:03:18.343793 7fb0e7b8b780 -1 fuse_lowlevel_new failed
> ceph-fuse[1835]: fuse finished with error 33
> ceph-fuse[1833]: mount failed: (33) Numerical argument out of domain
>=20
> Could you clear up the confusion in my head? :)

The problem is that the mount.ceph command doesn't understand keyrings; it=
=20
only understands secret=3D and secretfile=3D.  There is a longstanding feat=
ure=20
bug open for this

=09http://tracker.newdream.net/issues/266

but it hasn't been prioritized.  Sorry for the confusion!  It will happen=
=20
soon. =20

In the meantime, you need

=09 -o secretfile=3D/path/to/secretfile,name=3Daccess_fs

sage
--557981400-1341915692-1341851602=:20547--
