From: biyan chen <riby.chen@gmail.com>
Subject: Re: I can't ceph file system in writing on file
Date: Wed, 1 Jun 2011 16:13:11 +0800
Message-ID: <BANLkTimzY+ahEGC8gujO-G2dyhuTmuFtUw@mail.gmail.com>
References: <BANLkTik4K1we2z85ob-2Bmx1zNETkTj5Jw@mail.gmail.com>
	<BANLkTikho0M2BS3SztA=BN5i3gY=yBq0-A@mail.gmail.com>
	<1306943307.1527.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45581 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161649Ab1FAINM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 04:13:12 -0400
Received: by ywe9 with SMTP id 9so2141770ywe.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 01:13:11 -0700 (PDT)
In-Reply-To: <1306943307.1527.23.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jeff Wu

[root@ceph_client 1]# dd if=3D/dev/zero of=3D/1/512M bs=3D1M count=3D51=
2
dd: opening `/1/512M': Permission denied
[root@ceph_client 1]#

But it can read and write existing documents.



My configuration is :



;
; Sample ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

; If a 'host' is defined for a daemon, the start/stop script will
; verify that it matches the hostname (or else ignore it).  If it is
; not defined, it is assumed that the daemon is intended to start on
; the current host (e.g., in a setup with a startup.conf on each
; node).

; The variables $type, $id and $name are available to use in paths
; $type =3D The type of daemon, possible values: mon, mds and osd
; $id =3D The ID of the daemon, for mon.alpha, $id will be alpha
; $name =3D $type.$id

; For example:
; osd.0
;  $type =3D osd
;  $id =3D 0
;  $name =3D osd.0

; mon.beta
;  $type =3D mon
;  $id =3D beta
;  $name =3D mon.beta

; global
[global]
	; enable secure authentication
	auth supported =3D cephx
        keyring =3D /etc/ceph/keyring.bin
        debug ms =3D 0;

        ; allow ourselves to open a lot of files
        max open files =3D 131072

        ; set log file
        log file =3D /var/log/ceph/$name.log
        ; log_to_syslog =3D true        ; uncomment this line to log to=
 syslog

        ; set up pid files
        pid file =3D /var/run/ceph/$name.pid

        ; If you want to run a IPv6 cluster, set this to true.
Dual-stack isn't possible
        ;ms bind ipv6 =3D true

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
        mon data =3D /data/mon$id

        ; If you are using for example the RADOS Gateway and want to
have your newly created
        ; pools a higher replication level, you can set a default
        ;osd pool default size =3D 3

        ; You can also specify a CRUSH rule for new pools
        ; Wiki: http://ceph.newdream.net/wiki/Custom_data_placement_wit=
h_CRUSH
        ;osd pool default crush rule =3D 0

        ; Timing is critical for monitors, but if you want to allow
the clocks to drift a
        ; bit more, you can specify the max drift.
        ;mon clock drift allowed =3D 1

        ; Tell the monitor to backoff from this warning for 30 seconds
        ;mon clock drift warn backoff =3D 30

	; logging, for debugging monitor crashes, in order of
	; their likelihood of being helpful :)
	debug ms =3D 1
	debug mon =3D 20
	debug paxos =3D 20
	debug auth =3D 20

[mon.0]
	host =3D ceph_mon0
	mon addr =3D 192.168.0.211:6789

; mds
;  You need at least one.  Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring =3D /etc/ceph/keyring.$name

	; mds logging to debug issues.
	debug ms =3D 1
	debug mds =3D 20

[mds.alpha]
	host =3D ceph_mds0

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data =3D /data/$name
        keyring =3D /etc/ceph/keyring.$name
	debug osd =3D 1
	debug filestore =3D 1

	; Ideally, make this a separate disk or partition.  A few
 	; hundred MB should be enough; more if you have fast or many
 	; disks.  You can use a file under the osd data dir if need be
 	; (e.g. /data/$name/journal), but it will be slower than a
 	; separate disk or partition.

        ; This is an example of a file-based journal.
	osd journal =3D /data/$name/journal
	osd journal size =3D 1000 ; journal size, in megabytes

        ; If you want to run the journal on a tmpfs, disable DirectIO
        ;journal dio =3D false

        ; You can change the number of recovery operations to speed up =
recovery
        ; or slow it down if your machines can't handle it
        ; osd recovery max active =3D 3

	; osd logging to debug osd issues, in order of likelihood of being
	; helpful
	debug ms =3D 1
	debug osd =3D 20
	debug filestore =3D 20
	debug journal =3D 20

[osd.0]
	host =3D ceph_osd0

	; if 'btrfs devs' is not specified, you're responsible for
	; setting up the 'osd data' dir.  if it is not btrfs, things
	; will behave up until you try to recover from a crash (which
	; usually fine for basic testing).
	btrfs devs =3D /dev/sda7

        ; If you want to specify some other mount options, you can do s=
o.
        ; The default values are rw,noatime
        btrfs options =3D rw,noatime

[osd.1]
	host =3D ceph_osd1
	btrfs devs =3D /dev/sda7
	btrfs options =3D rw,noatime

[client]
      ; userspace client
      debug ms =3D 1
      debug client =3D 10


2011/6/1 Jeff Wu <cpwu@tnsoft.com.cn>:
>
> Hi,
>
> Are the other write commands also printf "Permission denied" ?
>
> Could you try to run:
>
> dd if=3D/dev/zero of=3D/1/512M bs=3D1M count=3D512
>
> If you detect a bug ,you can file it at
>
> http://tracker.newdream.net
>
> Jeff ,Wu
>
>
> On Wed, 2011-06-01 at 15:19 +0800, biyan chen wrote:
>> 2011-06-01 15:20:23.258669 7fee67a8c710 -- 192.168.0.211:6789/0 <=3D=
=3D
>> mds0 192.168.0.207:6800/7272 193 =3D=3D=3D=3D mdsbeacon(4297/alpha u=
p:active
>> seq 180 v14) v2 =3D=3D=3D=3D 244+0+0 (3951961624 0 0) 0x8e1a00 con 0=
x8efb40
>> 2011-06-01 15:20:23.258706 7fee67a8c710 mon.0@0(leader) e1 have conn=
ection
>> 2011-06-01 15:20:23.258720 7fee67a8c710 mon.0@0(leader) e1 ms_dispat=
ch
>> existing session MonSession: mds? 192.168.0.207:6800/7272 is openall=
ow
>> rwx for mds? 192.168.0.207:6800/7272
>> 2011-06-01 15:20:23.258728 7fee67a8c710 mon.0@0(leader) e1  caps all=
ow rwx
>> 2011-06-01 15:20:23.258748 7fee67a8c710
>> mon.0@0(leader).paxosservice(mdsmap) dispatch mdsbeacon(4297/alpha
>> up:active seq 180 v14) v2 from mds0 192.168.0.207:6800/7272
>> 2011-06-01 15:20:23.258763 7fee67a8c710 mon.0@0(leader).paxos(mdsmap
>> active lc 14) is_readable now=3D2011-06-01 15:20:23.258758
>> lease_expire=3D0.000000 has v14 lc 14
>> 2011-06-01 15:20:23.258777 7fee67a8c710 mon.0@0(leader).mds e14
>> preprocess_query mdsbeacon(4297/alpha up:active seq 180 v14) v2 from
>> mds0 192.168.0.207:6800/7272
>> 2011-06-01 15:20:23.258792 7fee67a8c710 mon.0@0(leader).mds e14
>> preprocess_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 fro=
m
>> mds0 192.168.0.207:6800/7272 compat=3D{},rocompat=3D{},incompat=3D{1=
=3Dbase
>> v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=
=3Ddir
>> inode in separate object}
>> 2011-06-01 15:20:23.258806 7fee67a8c710 mon.0@0(leader).mds e14
>> _note_beacon mdsbeacon(4297/alpha up:active seq 180 v14) v2 noting
>> time
>> 2011-06-01 15:20:23.258821 7fee67a8c710 -- 192.168.0.211:6789/0 -->
>> 192.168.0.207:6800/7272 -- mdsbeacon(4297/alpha up:active seq 180 v1=
4)
>> v1 -- ?+0 0x9b4c80 con 0x8efb40
>> ^C
>>
>> [root@ceph_mon0 ceph]# tail /var/log/ceph/mon.0.log -f
>> Display the above information =A3=A1
>>
>> Thanks!
>>
>> 2011/6/1 biyan chen <riby.chen@gmail.com>:
>> > When I mount ceph after the file system. I want to go to create a
>> > file, but hint permissions problem, cannot write
>> >
>> > In /var/log/ceph log information inside, didn't see more informati=
on
>> >
>> > [root@ceph_client /]# df
>> > Filesystem           1K-blocks      Used Available Use% Mounted on
>> > /dev/sda1            472658192  20199408 428449108   5% /
>> > tmpfs                  1984548         0   1984548   0% /dev/shm
>> > /dev/loop0             3351190   3351190         0 100% /mnt/cdrom
>> > 192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
>> > [root@ceph_client /]# cd /1
>> > [root@ceph_client 1]# echo "1">>1.txt
>> > -bash: 1.txt: Permission denied
>> > [root@ceph_client 1]# cd ..
>> > [root@ceph_client /]# ll
>> > total 112
>> > drwxr-xr-x.  1 root root     0 Jun  1 20:05 1
>> >
>>
>>
>>
>
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
