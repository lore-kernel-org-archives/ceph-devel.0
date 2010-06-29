From: Sage Weil <sage@newdream.net>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Tue, 29 Jun 2010 08:58:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-921146439-1277827126=:12768"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53804 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab0F2P50 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jun 2010 11:57:26 -0400
In-Reply-To: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-921146439-1277827126=:12768
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Sebastien,

On Tue, 29 Jun 2010, S=E9bastien Paolacci wrote:
> First of all, many thanks for this wonderful piece of software that
> actually looks very promising. It's a segment that imho definitely
> lack of credible open source alternatives to the (sometimes infamous
> and inefficient) proprietary systems.

Thanks!

> So I've just pulled the unstable branch from last Sunday and are few
> outcomes (local vm, sorry for that, but as for a first try...):
>=20
> - Build: transparent, which is actually not so common for an unstable
> branch of a said to not be mature project ;). Thanks.
>=20
> - Config: it's a bit difficult to understand the real meaning of all
> the available options (debian and suse dedicated pages are however
> very helpful), so documentation is sparse, as expected, and I should
> have start by reading the code anyway (so my bad at the end).
>=20
> - First setup attempt left me with a "mon fs missing 'whoami'.. did
> you run mkcephfs?" (see end of mail) I just echoed a "0" in
> "/data/mom0/whoami" and it did startup.

It looks like when you ran /etc/init.d/ceph is tried to start=20
/usr/bin/cmon, although I notice lots of /usr/local in your mkcephfs=20
output.  Do you by chance build from source and then 'make install', and=20
then also install a .deb or .rpm?  The "mon fs missing 'whoami'" is an old=
=20
error message that no longer appears in the 'unstable' branch, so there is=
=20
an old binary or old source involved somewhere.

> - cfuse -m 127.0.01:5678/ /mnt/ceph is eating all my memory and
> crashes with a bad_alloc

Fixed this.. there was an ip address parsing error.  The trailing '/'=20
shouldn't be there, and wasn't getting ignored.

> - cfuse /mnt/ceph is however working as expected. Creating files and
> browsing /mnt/ceph content provide with the desired result, dbench -D
> /mnt/ceph/ -t 10 2 however seems to endless wait for completion. On
> the cfuse side, I'm getting (what seems to be) an endless serie of "pg
> 0.xxx on [] is laggy"

That means the OSD isn't responding for some request(s).  Did cosd start? =
=20
Does a 'ceph -s' show some osds are 'up'?  If cosd crashed, the output log=
=20
or gdb backtrack would be helpful.

> root@debian-vm1:/home/seb# cat /etc/ceph/ceph.conf | grep -v '^;'
> [global]
>        pid file =3D /var/run/ceph/$name.pid
>        debug ms =3D 10
I wouldn't put this in [global] or you will clutter up output from things=
=20
like 'ceph -s'.
> [mon]
=09debug ms =3D 1    ; is usually enough msgr output
>        mon data =3D /data/mon$id
> [mon0]
>        host =3D debian-vm1
>        mon addr =3D 127.0.0.1:6789
> [mds]
=09debug ms =3D 1    ; is usually enough msgr output
> [mds0]
>        host =3D debian-vm1
> [osd]
=09debug ms =3D 1    ; is usually enough msgr output
>        sudo =3D true
>        osd data =3D /data/osd$id
>        osd journal =3D /data/osd$id/journal
>        osd journal size =3D 128
>        filestore journal writeahead =3D true
> [osd0]
>        host =3D debian-vm1

sage

--557981400-921146439-1277827126=:12768--
