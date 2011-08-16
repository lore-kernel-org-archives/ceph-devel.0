From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Re: Logging to syslog from clients
Date: Tue, 16 Aug 2011 13:58:00 +0200
Message-ID: <201108161358.00552.szekelyi@niif.hu>
References: <201108160231.53287.szekelyi@niif.hu> <CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com> <CA+qbEUPB_XQ352aL1FaH=LkacJzqa9iHJuFc1ppFyDofRYFNpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:59842 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab1HPL6G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2011 07:58:06 -0400
In-Reply-To: <CA+qbEUPB_XQ352aL1FaH=LkacJzqa9iHJuFc1ppFyDofRYFNpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>

Hi Colin,

On 2011. August 16. 06:10:32 Colin McCabe wrote:
> 2011/8/15 Colin McCabe <cmccabe@alumni.cmu.edu>:
> > 2011/8/15 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> >> Hi all,
> >>=20
> >> I'm running a Ceph cluster with a number of read-only ramdisk base=
d
> >> clients mounting the filesystem. I'd like to get the logs of the c=
lient
> >> out via syslog. I've seen some posts dealing with logging to syslo=
g,
> >> namely the thread starting at
> >> http://www.spinics.net/lists/ceph-devel/msg02876.html . I see opti=
ons
> >> like "log to syslog" and "clog to syslog". It's not clear what the=
y
> >> mean, could someone tell me the difference?
> >=20
> > "clog" is the center logger, which is a separate subsystem from the
> > regular logger. The central log is maintained by the monitors rathe=
r
> > than being a per-daemon thing like the regular log.

My would have gone to clog =3D client log. Thanks for the clarification=
=2E

> >> Anyway, currently my logging settings on the client are
> >>=20
> >> [global]
> >> log file =3D
> >> log dir =3D
> >> log to syslog =3D true
> >> clog to syslog =3D true
> >>=20
> >> But when the filesystem is mounted with the FUSE client, I still g=
et
> >>=20
> >> failed to open log file '/var/log/ceph/client.admin.log': error 2:=
 No
> >> such file or directory
> >>=20
> >> which is surprising. I thought that the above options should have
> >> disabled logging to file, but it looks like it still tries to open=
 it.
> >> Is this a bug, or me doing something wrong?
> >=20
> > This looks like an actual bug :(
> > I'm testing out a fix that will allow users to turn off log files f=
or
> > daemons again.
>=20
> This should be fixed in master by
> 8072bdcaa4445359051fed443be3d702f20807e0
>=20
> This should fix it for you.

Thanks, Colin. Since I don't compile sources myself, I'll wait for the =
next=20
release to roll this out.

--=20
cc

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
