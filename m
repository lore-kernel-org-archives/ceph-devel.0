From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Logging to syslog from clients
Date: Tue, 16 Aug 2011 19:46:26 +0200
Message-ID: <1313516786.3059.1.camel@wido-laptop>
References: <201108160231.53287.szekelyi@niif.hu>
	 <CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60126 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab1HPRqa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2011 13:46:30 -0400
In-Reply-To: <CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>, ceph-devel@vger.kernel.org

Hi,

On Mon, 2011-08-15 at 21:00 -0700, Colin McCabe wrote:
> 2011/8/15 Sz=C3=A9kelyi Szabolcs <szekelyi@niif.hu>:
> > Hi all,
> >
> > I'm running a Ceph cluster with a number of read-only ramdisk based=
 clients
> > mounting the filesystem. I'd like to get the logs of the client out=
 via syslog.
> > I've seen some posts dealing with logging to syslog, namely the thr=
ead
> > starting at http://www.spinics.net/lists/ceph-devel/msg02876.html .=
 I see
> > options like "log to syslog" and "clog to syslog". It's not clear w=
hat they
> > mean, could someone tell me the difference?
>=20
> "clog" is the center logger, which is a separate subsystem from the
> regular logger. The central log is maintained by the monitors rather
> than being a per-daemon thing like the regular log.
>=20
> >
> > Anyway, currently my logging settings on the client are
> >
> > [global]
> > log file =3D
> > log dir =3D
> > log to syslog =3D true
> > clog to syslog =3D true
> >
> > But when the filesystem is mounted with the FUSE client, I still ge=
t
> >
> > failed to open log file '/var/log/ceph/client.admin.log': error 2: =
No such file
> > or directory
> >
> > which is surprising. I thought that the above options should have d=
isabled
> > logging to file, but it looks like it still tries to open it. Is th=
is a bug, or
> > me doing something wrong?
>=20
> This looks like an actual bug :(
> I'm testing out a fix that will allow users to turn off log files for
> daemons again.
>=20
> On an unrelated note: when you log to syslog, you may need to turn
> down the logging a little bit. Syslog tends to drop log messages when
> the load gets heavy, and this makes it harder to figure out what is
> going on.

I also had that issue, but when using rsyslogd and using TCP for
transport instead of UDP I wasn't able to see any dropped packets.

To my experience it's not syslog dropping the packets, but UDP packets
which get lost due to buffers being full at the kernel.

# Sent all message to the remote syslog machine, then discard them to
prevent local logging
# Use TCP (@@) for transmission to prevent packet loss
:rawmsg,contains,"osd." @@loghost
& ~
:rawmsg,contains,"mon." @@loghost
& ~
:rawmsg,contains,"mds." @@loghost
& ~

Wido

>=20
> regards,
> Colin
>=20
>=20
>=20
> >
> > Thanks,
> > --
> > cc
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
