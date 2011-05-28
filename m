From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Able to mount some but not all nodes
Date: Sat, 28 May 2011 14:12:50 -0700
Message-ID: <BANLkTims=Q=wC-2wO-UcnpsaJT-Dej-ePQ@mail.gmail.com>
References: <loom.20110528T225932-317@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43366 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab1E1VMx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 May 2011 17:12:53 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BE4E9C174
	for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 14:12:52 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1C1FCC180
	for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 14:12:51 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1010412eyx.19
        for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 14:12:50 -0700 (PDT)
In-Reply-To: <loom.20110528T225932-317@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Yee <adamjyee@gmail.com>
Cc: ceph-devel@vger.kernel.org

Mounting a Ceph cluster isn't quite like mounting an NFS machine. You
mount by connecting to one of the monitor servers, and then you
dynamically connect and disconnect to the other machines as needed. :)
So if you can only connect to your first server, using the monitor
address, then that's exactly how it should be!
-Greg

On Sat, May 28, 2011 at 2:02 PM, Adam Yee <adamjyee@gmail.com> wrote:
> Hi,
>
> I=92m new to Ceph. =A0I=92ve installed my test cluster on Ubuntu 10.1=
0 servers. =A0After
> following the instructions found on the wiki site and I=92ve been abl=
e to mount
> server1 (mds0 and mon0) and server2 (osd0) like so
>
> $ sudo mount -t ceph server1:/ /mnt/ceph
>
> However, server3 (osd1) and server4 (osd2) give me the following
>
> $ sudo mount -t ceph server1:/ /mnt/ceph
> mount error 5 =3D Input/output error
>
> Where do I look inside the log files for mounting info? =A0Am I missi=
ng
> configurations that activate important debug messages in the log file=
s? =A0Below
> are my configurations and output of dmesg after attempting to mount a=
t server3.
>
> Thank you very much!
> Adam
>
> $ sudo dmesg
> ...
> [ =A0402.180998] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5=
 5/5)
> [ =A0402.183563] ceph: client4101 fsid 6beefbba-0776-d6fd-003d-af78ac=
07b9da
> [ =A0402.183662] ceph: mon0 10.10.207.156:6789 session established
> [138449.435257] ceph: client4105 fsid 6beefbba-0776-d6fd-003d-af78ac0=
7b9da
> [138449.435352] ceph: mon0 10.10.207.156:6789 session established
> [138618.776870] INFO: task cosd:1948 blocked for more than 120 second=
s.
> [138618.776890] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" di=
sables this
> message.
> [138618.776911] cosd =A0 =A0 =A0 =A0 =A0D 0000000100d3237c =A0 =A0 0 =
=A01948 =A0 =A0 =A01 0x00000000
> [138618.776918] =A0ffff88013ab2be00 0000000000000086 ffffffff00000000
> 0000000000015980
> [138618.776925] =A0ffff88013ab2bfd8 0000000000015980 ffff88013ab2bfd8
> ffff88013a525b80
> [138618.776931] =A00000000000015980 0000000000015980 ffff88013ab2bfd8
> 0000000000015980
> [138618.776937] Call Trace:
> [138618.776947] =A0[<ffffffff81048e89>] ? __wake_up_common+0x59/0x90
> [138618.776955] =A0[<ffffffff8159e5ed>] rwsem_down_failed_common+0x9d=
/0x210
> [138618.776962] =A0[<ffffffff8117a810>] ? sync_one_sb+0x0/0x30
> [138618.776966] =A0[<ffffffff8117a810>] ? sync_one_sb+0x0/0x30
> [138618.776972] =A0[<ffffffff8159e7b6>] rwsem_down_read_failed+0x26/0=
x30
> [138618.776979] =A0[<ffffffff812c1224>] call_rwsem_down_read_failed+0=
x14/0x30
> [138618.776985] =A0[<ffffffff8159da27>] ? down_read+0x17/0x20
> [138618.776991] =A0[<ffffffff8115545b>] iterate_supers+0x7b/0xd0
> [138618.776996] =A0[<ffffffff8117a86f>] sys_sync+0x2f/0x70
> [138618.777004] =A0[<ffffffff8100a0f2>] system_call_fastpath+0x16/0x1=
b
> [140246.990289] ceph: client4301 fsid 6beefbba-0776-d6fd-003d-af78ac0=
7b9da
> [140246.990390] ceph: mon0 10.10.207.156:6789 session established
> $
>
>
> /etc/hosts
> 127.0.0.1 =A0 =A0 =A0 localhost
>
> 10.10.207.156 =A0 server1
> 10.10.207.150 =A0 server2
> 10.10.206.102 =A0 server3
> 10.10.207.44 =A0 =A0server4
>
> # server1 - MDS and Monitor
> # server2, server3, server4 - OSD
>
> # The following lines are desirable for IPv6 capable hosts
> ::1 =A0 =A0 localhost ip6-localhost ip6-loopback
> fe00::0 ip6-localnet
> ff00::0 ip6-mcastprefix
> ff02::1 ip6-allnodes
> ff02::2 ip6-allrouters
>
>
> /etc/ceph/ceph.conf
> [global]
> =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
> =A0 =A0 =A0 debug ms =3D 1
>
> ; Monitors
> [mon]
> =A0 =A0 =A0 mon data =3D /data-storage/ceph/mon$id
> =A0 =A0 =A0 debug mon =3D 20
> [mon.0]
> =A0 =A0 =A0 host =3D server1
> =A0 =A0 =A0 mon addr =3D 10.10.207.156:6789
>
> ; Metadata servers
> [mds]
> =A0 =A0 =A0 debug mds =3D 20
> [mds.0]
> =A0 =A0 =A0 host =3D server1
>
> ; OSDs
> [osd]
> =A0 =A0 =A0 debug osd =3D 20
> ; =A0 =A0 =A0 sudo =3D true
> =A0 =A0 =A0 osd data =3D /data-storage/ceph/osd$id
> ; =A0 =A0 =A0 osd journal =3D /journal
> =A0 =A0 =A0 osd journal size =3D 512
> =A0 =A0 =A0 filestore journal writeahead =3D true
> [osd.0]
> =A0 =A0 =A0 host =3D server2
> =A0 =A0 =A0 osd addr =3D 10.10.207.150
> [osd.1]
> =A0 =A0 =A0 host =3D server3
> =A0 =A0 =A0 osd addr =3D 10.10.206.102
> [osd.2]
> =A0 =A0 =A0 host =3D server4
> =A0 =A0 =A0 osd addr =3D 10.10.207.204
> [mount]
> =A0 =A0 =A0 allow =3D %everyone
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
