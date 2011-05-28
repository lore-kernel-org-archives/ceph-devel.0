From: Adam Yee <adamjyee@gmail.com>
Subject: Able to mount some but not all nodes
Date: Sat, 28 May 2011 21:02:31 +0000 (UTC)
Message-ID: <loom.20110528T225932-317@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38759 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516Ab1E1VFH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 28 May 2011 17:05:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QQQgz-0007kk-Md
	for ceph-devel@vger.kernel.org; Sat, 28 May 2011 23:05:06 +0200
Received: from adsl-69-225-1-199.dsl.skt2ca.pacbell.net ([69.225.1.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 23:05:05 +0200
Received: from adamjyee by adsl-69-225-1-199.dsl.skt2ca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 23:05:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I=E2=80=99m new to Ceph.  I=E2=80=99ve installed my test cluster on Ubu=
ntu 10.10 servers.  After=20
following the instructions found on the wiki site and I=E2=80=99ve been=
 able to mount=20
server1 (mds0 and mon0) and server2 (osd0) like so

$ sudo mount -t ceph server1:/ /mnt/ceph

However, server3 (osd1) and server4 (osd2) give me the following

$ sudo mount -t ceph server1:/ /mnt/ceph
mount error 5 =3D Input/output error

Where do I look inside the log files for mounting info?  Am I missing=20
configurations that activate important debug messages in the log files?=
  Below=20
are my configurations and output of dmesg after attempting to mount at =
server3.

Thank you very much!
Adam

$ sudo dmesg
=2E..
[  402.180998] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5 5/5=
)
[  402.183563] ceph: client4101 fsid 6beefbba-0776-d6fd-003d-af78ac07b9=
da
[  402.183662] ceph: mon0 10.10.207.156:6789 session established
[138449.435257] ceph: client4105 fsid 6beefbba-0776-d6fd-003d-af78ac07b=
9da
[138449.435352] ceph: mon0 10.10.207.156:6789 session established
[138618.776870] INFO: task cosd:1948 blocked for more than 120 seconds.
[138618.776890] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this=20
message.
[138618.776911] cosd          D 0000000100d3237c     0  1948      1 0x0=
0000000
[138618.776918]  ffff88013ab2be00 0000000000000086 ffffffff00000000=20
0000000000015980
[138618.776925]  ffff88013ab2bfd8 0000000000015980 ffff88013ab2bfd8=20
ffff88013a525b80
[138618.776931]  0000000000015980 0000000000015980 ffff88013ab2bfd8=20
0000000000015980
[138618.776937] Call Trace:
[138618.776947]  [<ffffffff81048e89>] ? __wake_up_common+0x59/0x90
[138618.776955]  [<ffffffff8159e5ed>] rwsem_down_failed_common+0x9d/0x2=
10
[138618.776962]  [<ffffffff8117a810>] ? sync_one_sb+0x0/0x30
[138618.776966]  [<ffffffff8117a810>] ? sync_one_sb+0x0/0x30
[138618.776972]  [<ffffffff8159e7b6>] rwsem_down_read_failed+0x26/0x30
[138618.776979]  [<ffffffff812c1224>] call_rwsem_down_read_failed+0x14/=
0x30
[138618.776985]  [<ffffffff8159da27>] ? down_read+0x17/0x20
[138618.776991]  [<ffffffff8115545b>] iterate_supers+0x7b/0xd0
[138618.776996]  [<ffffffff8117a86f>] sys_sync+0x2f/0x70
[138618.777004]  [<ffffffff8100a0f2>] system_call_fastpath+0x16/0x1b
[140246.990289] ceph: client4301 fsid 6beefbba-0776-d6fd-003d-af78ac07b=
9da
[140246.990390] ceph: mon0 10.10.207.156:6789 session established
$


/etc/hosts
127.0.0.1	localhost

10.10.207.156	server1
10.10.207.150	server2
10.10.206.102	server3
10.10.207.44	server4

# server1 - MDS and Monitor
# server2, server3, server4 - OSD

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters


/etc/ceph/ceph.conf
[global]
       pid file =3D /var/run/ceph/$name.pid
       debug ms =3D 1

; Monitors
[mon]
       mon data =3D /data-storage/ceph/mon$id
       debug mon =3D 20
[mon.0]
       host =3D server1
       mon addr =3D 10.10.207.156:6789

; Metadata servers
[mds]
       debug mds =3D 20
[mds.0]
       host =3D server1

; OSDs
[osd]
       debug osd =3D 20
;       sudo =3D true
       osd data =3D /data-storage/ceph/osd$id
;       osd journal =3D /journal
       osd journal size =3D 512
       filestore journal writeahead =3D true
[osd.0]
       host =3D server2
       osd addr =3D 10.10.207.150
[osd.1]
       host =3D server3
       osd addr =3D 10.10.206.102
[osd.2]
       host =3D server4
       osd addr =3D 10.10.207.204
[mount]
       allow =3D %everyone

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
