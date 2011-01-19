From: Qian Wei <hzqianwei@gmail.com>
Subject: can't read the superbloack
Date: Wed, 19 Jan 2011 10:38:59 +0800
Message-ID: <AANLkTim8CMPTHE9nWOxoza9WZPwwJ3=ZU5T+Y6iKyXdv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37295 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab1ASCjA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 21:39:00 -0500
Received: by qwa26 with SMTP id 26so327377qwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jan 2011 18:39:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now the my client machine still can't mount the system, the error
message is "can't read the superblock ".Moreover, I can use
"init-ceph" command to start the system,and the  "cosd cmon cmds" is
on process table(so I think the system is running), but I can't  use
=93ceph=94 command to administrate the system, =932011-01-13 13:27:05.8=
00552
b5f41b70 -- :/4555 >> 192.168.178.160:0/0 pipe(0x8429c48 sd=3D3 pgs=3D0
cs=3D0 l=3D0).fault first fault =94 is the error message.Do you know wh=
at's
wrong may cause these problems?  If you have encounteren these
problems, please tell me how to resolve them. Thanks.
I have turned off the iptables, and disabled the firewall.
I install the ceph(0.24) on Fedora 14 ( 2.6.35.6-45 )which runs on
Vmware 6.5.70(for test).Moreover, my mon,mds and osd was on the same
system.
My ceph.conf on mon&mds&osd is:

[global]
        ; enable secure authentication
        ;auth supported =3D cephx
; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
        mon data =3D /data/mon$id
        ; logging, for debugging monitor crashes, in order of
        ; their likelihood of being helpful :)
        ;debug ms =3D 1
        ;debug mon =3D 20
        ;debug paxos =3D 20
        ;debug auth =3D 20
[mon0]
        host =3D cephosd
        mon addr =3D 192.168.178.160
; mds
;  You need at least one.  Define two to get a standby.
[mds]
        ; where the mds keeps it's secret encryption keys
        ;keyring =3D /data/keyring.$name
        ; mds logging to debug issues.
        ;debug ms =3D 1
        ;debug mds =3D 20
[mds.alpha]
        host =3D cephosd
; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
        sudo =3D true
        ; This is where the btrfs volume will be mounted.
        osd data =3D/mnt/btrfs/osd0$id
        ; Ideally, make this a separate disk or partition.  A few
        ; hundred MB should be enough; more if you have fast or many
        ; disks.  You can use a file under the osd data dir if need be
        ; (e.g. /data/osd$id/journal), but it will be slower than a
        ; separate disk or partition.
        ; This is an example of a file-based journal.
        osd journal =3D /mnt/btrfs/osd$id/journal
        osd journal size =3D 1000 ; journal size, in megabytes
        ; osd logging to debug osd issues, in order of likelihood of be=
ing
        ; helpful
        ;debug ms =3D 1
        ;debug osd =3D 20
        ;debug filestore =3D 20
        ;debug journal =3D 20
[osd0]
        host =3D cephosd
        ; if 'btrfs devs' is not specified, you're responsible for
        ; setting up the 'osd data' dir.  if it is not btrfs, things
        ; will behave up until you try to recover from a crash (which
        ; usually fine for basic testing).
        btrfs devs =3D /dev/sda3
        osd data =3D /mnt/btrfs/osd0
; access control
[group everyone]
; you probably want to limit this to a small or a list of
; hosts. clients are fully trusted.
addr =3D 0.0.0.0/0

On the client side my install commands is :
$git clone git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-clie=
nt.git
$cd ceph-client
$make menuconfig //I select "Yes" on all of three option about Ceph
$make && make modules && make modules_install && make install && reboot


Thank you!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
