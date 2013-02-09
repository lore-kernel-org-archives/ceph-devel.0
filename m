From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: mkcephfs error: cannot remove `/var/lib/ceph/osd/ceph-0'
Date: Sat, 09 Feb 2013 13:39:29 +1000
Message-ID: <kf4gdf$nn4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56090 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270Ab3BIDju (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Feb 2013 22:39:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U41IF-0005mE-Aq
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 04:39:59 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 04:39:59 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 04:39:59 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm trying to set up a test Ceph node, but mkcephfs is failing because =
it's=20
trying to erase my mount point, which it can't do because the disk I wa=
nt to=20
use with Ceph is mounted there.  I finally found some manual installati=
on=20
steps in the mkcephfs manpage (I think these really should be included =
in the=20
online docs!) and this is the bit that fails:

$ mkcephfs --init-local-daemons mon -d /tmp/foo
=3D=3D=3D mon.0 =3D=3D=3D
rm: cannot remove `/var/lib/ceph/osd/ceph-0': Device or resource busy
/usr/bin/ceph-mon: error creating monfs: (5) Input/output error
2013-02-09 13:17:24.941676 b7358710 -1 store(/var/lib/ceph/osd/ceph-0/)=
=20
MonitorStore::mkfs: failed to remove /var/lib/ceph/osd/ceph-0/: rm retu=
rned=20
run_cmd(rm): exited with status 1
2013-02-09 13:17:24.941746 b7358710 -1 mon.0@-1(probing) e0 store->mkfs=
 failed=20
with: (5) Input/output error

What am I doing wrong?  I am going off the ceph.com docs[1], which says=
 "If=20
you are running multiple OSDs per host and one hard disk per OSD, you s=
hould=20
mount the disk under the OSD data directory (if you haven=E2=80=99t don=
e so already)".=20
  I am only running one OSD on this host, does this mean I shouldn't mo=
unt the=20
disk before running mkcephfs?  Won't that just create all the files on =
the=20
wrong disk?

I'm running Debian Squeeze with the debian-bobtail packages installed a=
s per=20
the ceph.com Debian instructions[2].

Any suggestions?

Many thanks,
Adam.

[1] http://ceph.com/docs/master/rados/deployment/mkcephfs/
[2] http://ceph.com/docs/master/install/debian/

P.S. I would've posted on ceph-users except it's not carried on GMane y=
et.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
