From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Problem with attaching rbd device in qemu-kvm
Date: Fri, 9 Dec 2011 13:48:47 +0100
Message-ID: <CAMwB3TgS0XuhqPEh5kTdJsNf1BP=2uOXUex4izTZhfbLbT9FNQ@mail.gmail.com>
References: <CAMwB3ThP55_KV4CQ1Yd=goqSDxug79vnznq3pqjFVQcbap1nWw@mail.gmail.com>
	<4ED7E69D.7070909@dreamhost.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6de1792cb839204b3a834be
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47072 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1LIMsu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2011 07:48:50 -0500
Received: by wgbdr13 with SMTP id dr13so5673254wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2011 04:48:48 -0800 (PST)
In-Reply-To: <4ED7E69D.7070909@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

--0016e6de1792cb839204b3a834be
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Sorry, for my lag, but i was sick.

I handled problem with apparmor before and now it's not a problem,
even when i send mail before, it was solved.

Ok when i create image from qemu-img it's looks like that, and works
perfect, (attachment with log of this opperation.)

But when i use virsh, it's still a problem. Just like he don't know
what user is going to be auth.

I try, as client.admin (default i hope :)) only with id=3Dadmin in
kvm.xml, or client=3Dadmin, and other combinations - like client.rbd
etc., Still nothing.

I try, improve a keyring file, adding client rbd into keyring on
machine with kvm hypervisor in /etc/ceph/keyring.bin

[client.rbd]
        key =3D AAAAAAAAAAAAAAAA
        auid =3D 18446744073709551615
        caps mds =3D "allow"
        caps mon =3D "allow r"
        caps osd =3D "allow rw pool=3Dkvmtest"

and on cluster site like above. I was added, a section [client.rbd]
with keyring path, and it's still a problem.

2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
root@s3-10-177-64-4:~# tail -n10000 /var/log/ceph/mon.0.log | grep 13:29:11=
.
2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
2011-12-09 13:29:11.519624 7fe61b090700 -- 10.177.64.4:6789/0 <=3D=3D
client.? 10.177.32.66:0/58020608 1 =3D=3D=3D=3D auth(proto 0 21 bytes) v1 =
=3D=3D=3D=3D
47+0+0 (3310669357 0 0) 0x17f2e00 con 0x19d2c80
2011-12-09 13:29:11.519645 7fe61b090700 mon.0@0(leader) e1 have connection
2011-12-09 13:29:11.519655 7fe61b090700 mon.0@0(leader) e1 do not have
session, making new one
2011-12-09 13:29:11.519668 7fe61b090700 mon.0@0(leader) e1 ms_dispatch
new session MonSession: client.? 10.177.32.66:0/58020608 is open for
client.? 10.177.32.66:0/58020608
2011-12-09 13:29:11.519674 7fe61b090700 mon.0@0(leader) e1 setting
timeout on session
2011-12-09 13:29:11.519680 7fe61b090700 mon.0@0(leader) e1  caps
2011-12-09 13:29:11.519688 7fe61b090700 mon.0@0(leader).auth v353
AuthMonitor::update_from_paxos()
2011-12-09 13:29:11.519697 7fe61b090700 mon.0@0(leader).auth v353
preprocess_query auth(proto 0 21 bytes) v1 from client.?
10.177.32.66:0/58020608
2011-12-09 13:29:11.519703 7fe61b090700 mon.0@0(leader).auth v353
prep_auth() blob_size=3D21
2011-12-09 13:29:11.519735 7fe61b090700 -- 10.177.64.4:6789/0 -->
10.177.32.66:0/58020608 -- auth_reply(proto 0 -95 Operation not
supported) v1 -- ?+0 0x1246200 con 0x19d2c80

from libvirt.log

23:20:56.689: 1309: error : virSecurityDACRestoreSecurityFileLabel:143
: cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No such file
or directory
23:20:56.882: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
Unable to restore security label on rbd:kvmtest/kvmtest1:name=3Dadmin
23:21:09.172: 1309: error : qemuMonitorTextAddDrive:2418 : operation
failed: open disk image file failed
23:21:09.172: 1309: error : virSecurityDACRestoreSecurityFileLabel:143
: cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No such file
or directory
23:21:09.364: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
Unable to restore security label on rbd:kvmtest/kvmtest1:name=3Dadmin
23:21:49.645: 1309: error : qemuMonitorTextAddDrive:2418 : operation
failed: open disk image file failed
23:21:49.645: 1309: error : virSecurityDACRestoreSecurityFileLabel:143
: cannot resolve symlink rbd:kvmtest/kvmtest1:id=3Dadmin: No such file
or directory
23:21:49.853: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
Unable to restore security label on rbd:kvmtest/kvmtest1:id=3Dadmin
13:08:08.924: 1309: error : qemuMonitorTextAddDrive:2418 : operation
failed: open disk image file failed
13:08:08.924: 1309: error : virSecurityDACRestoreSecurityFileLabel:143
: cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or
directory
13:08:09.117: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
Unable to restore security label on rbd:kvmtest/kvmtest1
13:09:45.402: 1309: error : qemuMonitorTextAddDrive:2418 : operation
failed: open disk image file failed
13:29:05.554: 1310: error : qemuMonitorTextAddDrive:2418 : operation
failed: open disk image file failed
13:29:05.554: 1310: error : virSecurityDACRestoreSecurityFileLabel:143
: cannot resolve symlink kvmtest/kvmtest1: No such file or directory
13:29:05.751: 1310: warning : qemuDomainAttachPciDiskDevice:250 :
Unable to restore security label on kvmtest/kvmtest1
13:29:05.751: 1310: warning : virEventPollUpdateHandle:147 : Ignoring
invalid update watch -1

2011/12/1 Josh Durgin <josh.durgin@dreamhost.com>:
> On 12/01/2011 11:37 AM, S=B3awomir Skowron wrote:
>>
>> I have some problems. Can you help me ??
>>
>> ceph cluster:
>> ceph 0.38, oneiric, kernel 3.0.0 x86_64 - now only one machine.
>>
>> kvm hypervisor:
>> kvm version 1.0-rc4 (0.15.92), libvirt 0.9.2, kernel 3.0.0, Ubuntu
>> oneiric x86_64.
>>
>> I create image from qemu-img on machine with kvm VM's, and it works very
>> well:
>>
>> qemu-img create -f rbd rbd:kvmtest/kvmtest1 10G
>> Formatting 'rbd:kvmtest/kvmtest1', fmt=3Drbd size=3D10737418240 cluster_=
size=3D0
>>
>> in ceph cluster machines:
>>
>> rados -p kvmtest ls
>> kvmtest1.rbd
>> rbd_directory
>> rbd_info
>>
>> But when i try to attach new device to kvm VM like this:
>>
>> virsh attach-device one-10 /tmp/kvm.xml
>>
>> with kvm.xml like this:
>>
>> <disk type=3D'network' device=3D'disk'>
>> =A0 =A0 =A0 =A0 <driver name=3D'qemu' type=3D'raw' cache=3D'writeback'/>
>> =A0 =A0 =A0 =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <host name=3D'10.177.64.4' port=3D'6789'=
/>
>> =A0 =A0 =A0 =A0 </source>
>> =A0 =A0 =A0 =A0 <target dev=3D'vdc' bus=3D'virtio'/>
>> </disk>
>>
>> output of virsh:
>>
>> error: Failed to attach device from /tmp/kvm.xml
>> error: cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or
>> directory
>
>
> From the monitor output below, I'm assuming this is just a bad error mess=
age
> from libvirt.
>
>
>> and mon.0 log in ceph cluster.
>>
>> 2011-12-01 20:18:17.142595 7fe02dd04700 mon.0@0(leader) e1
>> ms_verify_authorizer 10.177.32.66:0/25020608 client protocol 0
>> 2011-12-01 20:18:17.143041 7fe03223b700 -- 10.177.64.4:6789/0<=3D=3D
>> client.? 10.177.32.66:0/25020608 1 =3D=3D=3D=3D auth(proto 0 21 bytes) v=
1 =3D=3D=3D=3D
>> 47+0+0 (3310669357 0 0) 0x29f6a00 con 0x297adc0
>> 2011-12-01 20:18:17.143095 7fe03223b700 mon.0@0(leader) e1 ms_dispatch
>> new session MonSession: client.? 10.177.32.66:0/25020608 is open for
>> client.? 10.177.32.66:0/25020608
>> 2011-12-01 20:18:17.143125 7fe03223b700 mon.0@0(leader).auth v146
>> preprocess_query auth(proto 0 21 bytes) v1 from client.?
>> 10.177.32.66:0/25020608
>> 2011-12-01 20:18:17.143168 7fe03223b700 -- 10.177.64.4:6789/0 -->
>> 10.177.32.66:0/25020608 -- auth_reply(proto 0 -95 Operation not
>> supported) v1 -- ?+0 0x2f30600 con 0x297adc0
>
>
> Here you can see qemu isn't authenticating correctly, probably because th=
e
> rados user isn't being set by libvirt. With your libvirt version, you'll
> need to change:
>
>
> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>
>
> to
>
> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1:id=3Dfoo'>
>
> to authenticate as client.foo. Any ceph config option can be set like tha=
t,
> separated by colons.
>
> If this still doesn't work, I'd suggest setting
> debug_rbd=3D20:debug_monc=3D20:debug_auth=3D20:log_to_stderr=3D2 to get m=
ore info in
> the libvirt instance log (usually /var/log/libvirt/qemu/instance_name.log=
).
> There may be apparmour restrictions preventing qemu from reading the keyr=
ing
> or ceph config files.
>
>
>> ceph.conf, and keyring.bin exists on server, and machine with qemu-kvm
>> in same directory:
>> ; global
>> [global]
>> =A0 =A0 =A0 =A0 ; enable secure authentication
>>
>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.bin
>>
>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>>
>> =A0 =A0 =A0 =A0 rgw print continue =3D false
>> =A0 =A0 =A0 =A0 rgw socket path =3D /var/run/radosgw.sock
>>
>> ; monitors
>> ; =A0You need at least one. =A0You need at least three if you want to
>> ; =A0tolerate any node failures. =A0Always create an odd number.
>> [mon]
>> =A0 =A0 =A0 =A0 mon data =3D /vol0/data/mon.$id
>>
>> =A0 =A0 =A0 =A0 ; some minimal logging (just message traffic) to aid deb=
ugging
>>
>> =A0 =A0 =A0 =A0 debug ms =3D 1 =A0 =A0 ; see message traffic
>> =A0 =A0 =A0 =A0 debug mon =3D 0 =A0 ; monitor
>> =A0 =A0 =A0 =A0 debug paxos =3D 0 ; monitor replication
>> =A0 =A0 =A0 =A0 debug auth =3D 0 =A0;
>>
>> =A0 =A0 =A0 =A0 mon allowed clock drift =3D 2
>>
>> [mon.0]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 mon addr =3D 10.177.64.4:6789
>>
>> ; radosgw client list
>> [client.radosgw.10-177-64-4]
>>
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 log file =3D /var/log/ceph/$name.log
>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>> =A0 =A0 =A0 =A0 debug ms =3D 1
>>
>> ; osd
>> ; =A0You need at least one. =A0Two if you want data to be replicated.
>> ; =A0Define as many as you like.
>> [osd]
>> =A0 =A0 =A0 =A0 ; This is where the btrfs volume will be mounted.
>>
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.$id
>>
>> =A0 =A0 =A0 =A0 ; Ideally, make this a separate disk or partition. =A0A =
few GB
>> =A0 =A0 =A0 =A0 ; is usually enough; more if you have fast disks. =A0You=
 can use
>> =A0 =A0 =A0 =A0 ; a file under the osd data dir if need be
>> =A0 =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be slower tha=
n a
>> =A0 =A0 =A0 =A0 ; separate disk or partition.
>>
>> =A0 =A0 =A0 =A0 osd journal =3D /vol0/data/osd.$id/journal
>>
>> =A0 =A0 =A0 =A0 ; If the OSD journal is a file, you need to specify the =
size.
>> This is specified in MB.
>>
>> =A0 =A0 =A0 =A0 osd journal size =3D 512
>>
>> =A0 =A0 =A0 =A0 filestore journal writeahead =3D 1
>> =A0 =A0 =A0 =A0 osd heartbeat grace =3D 5
>>
>> =A0 =A0 =A0 =A0 debug ms =3D 0 =A0 =A0 =A0 =A0 ; message traffic
>> =A0 =A0 =A0 =A0 debug osd =3D 0
>> =A0 =A0 =A0 =A0 debug filestore =3D 0 ; local object storage
>> =A0 =A0 =A0 =A0 debug journal =3D 0 =A0 ; local journaling
>> =A0 =A0 =A0 =A0 debug monc =3D 0
>> =A0 =A0 =A0 =A0 debug rados =3D 1
>>
>> [osd.0]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.0
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.0/keyring
>>
>> [osd.1]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.1
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.1/keyring
>>
>> [osd.2]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.2
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.2/keyring
>>
>> [osd.3]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.3
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.3/keyring
>>
>> [osd.4]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.4
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.4/keyring
>>
>> [osd.5]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.5
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.5/keyring
>>
>> [osd.6]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.6
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.6/keyring
>>
>> [osd.7]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.7
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.7/keyring
>>
>> [osd.8]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.8
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.8/keyring
>>
>> [osd.9]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.9
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.9/keyring
>>
>> [osd.10]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.10
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.10/keyring
>>
>> [osd.11]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.11
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.11/keyring
>>
>> [osd.12]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.12
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.12/keyring
>>
>> [osd.13]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.13
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.13/keyring
>>
>> [osd.14]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.14
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.14/keyring
>>
>> [osd.15]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.15
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.15/keyring
>>
>> [osd.16]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.16
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.16/keyring
>>
>> [osd.17]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.17
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.17/keyring
>>
>> [osd.18]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.18
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.18/keyring
>>
>> [osd.19]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.19
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.19/keyring
>>
>> [osd.20]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.20
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.20/keyring
>>
>> [osd.21]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.21
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.21/keyring
>>
>> [osd.22]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.22
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.22/keyring
>>
>> [osd.23]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.23
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.23/keyring
>>
>> [osd.24]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.24
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.24/keyring
>>
>> [osd.25]
>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.25
>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.25/keyring
>>
>>
>



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron

--0016e6de1792cb839204b3a834be
Content-Type: application/octet-stream; name="mon.0.log"
Content-Disposition: attachment; filename="mon.0.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gvocaal51

MjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzUyMTAgN2ZlNjE3MTVmNzAwIG1vbi4wQDAobGVhZGVyKSBl
MSBtc192ZXJpZnlfYXV0aG9yaXplciAxMC4xNzcuMzIuNjY6MC8xMDA2MjEwIGNsaWVudCBwcm90
b2NvbCAwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc1NzA1IDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcu
NjQuNDo2Nzg5LzAgPD09IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgMSA9PT09IGF1
dGgocHJvdG8gMCAzMCBieXRlcykgdjEgPT09PSA1NiswKzAgKDYyNTU0MDI4OSAwIDApIDB4MTEz
MzAwMCBjb24gMHgxNDUxNTAwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc1NzI4IDdmZTYxYjA5MDcw
MCBtb24uMEAwKGxlYWRlcikgZTEgaGF2ZSBjb25uZWN0aW9uCjIwMTEtMTItMDEgMjM6Mjc6NDIu
Mjc1NzM3IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikgZTEgZG8gbm90IGhhdmUgc2Vzc2lv
biwgbWFraW5nIG5ldyBvbmUKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzU3NTEgN2ZlNjFiMDkwNzAw
IG1vbi4wQDAobGVhZGVyKSBlMSBtc19kaXNwYXRjaCBuZXcgc2Vzc2lvbiBNb25TZXNzaW9uOiBj
bGllbnQuPyAxMC4xNzcuMzIuNjY6MC8xMDA2MjEwIGlzIG9wZW4gZm9yIGNsaWVudC4/IDEwLjE3
Ny4zMi42NjowLzEwMDYyMTAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzU3NTggN2ZlNjFiMDkwNzAw
IG1vbi4wQDAobGVhZGVyKSBlMSBzZXR0aW5nIHRpbWVvdXQgb24gc2Vzc2lvbgoyMDExLTEyLTAx
IDIzOjI3OjQyLjI3NTc2NSA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxICBjYXBzIAoy
MDExLTEyLTAxIDIzOjI3OjQyLjI3NTc3MyA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpLmF1
dGggdjE1NSBBdXRoTW9uaXRvcjo6dXBkYXRlX2Zyb21fcGF4b3MoKQoyMDExLTEyLTAxIDIzOjI3
OjQyLjI3NTc4MyA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjE1NSBwcmVwcm9j
ZXNzX3F1ZXJ5IGF1dGgocHJvdG8gMCAzMCBieXRlcykgdjEgZnJvbSBjbGllbnQuPyAxMC4xNzcu
MzIuNjY6MC8xMDA2MjEwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc1NzkxIDdmZTYxYjA5MDcwMCBt
b24uMEAwKGxlYWRlcikuYXV0aCB2MTU1IHByZXBfYXV0aCgpIGJsb2Jfc2l6ZT0zMAoyMDExLTEy
LTAxIDIzOjI3OjQyLjI3NTgxNiA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjE1
NSBBdXRoTW9uaXRvcjo6YXNzaWduX2dsb2JhbF9pZCBtPWF1dGgocHJvdG8gMCAzMCBieXRlcykg
djEgbW9uPTAvMSBsYXN0X2FsbG9jYXRlZD01NzA1IG1heF9nbG9iYWxfaWQ9NTc5NgoyMDExLTEy
LTAxIDIzOjI3OjQyLjI3NTgyNSA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjE1
NSBuZXh0X2dsb2JhbF9pZCBzaG91bGQgYmUgNTcwNgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3NTg1
MyA3ZmU2MWIwOTA3MDAgY2VwaHggc2VydmVyIGNsaWVudC5hZG1pbjogc3RhcnRfc2Vzc2lvbiBz
ZXJ2ZXJfY2hhbGxlbmdlIGY1ZjE5M2Y1YTA5ZWEwNTkKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzU4
OTQgN2ZlNjFiMDkwNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4gMTAuMTc3LjMyLjY2OjAv
MTAwNjIxMCAtLSBhdXRoX3JlcGx5KHByb3RvIDIgMCBTdWNjZXNzKSB2MSAtLSA/KzAgMHgxMWVj
NDAwIGNvbiAweDE0NTE1MDAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzY3MzcgN2ZlNjFiMDkwNzAw
IC0tIDEwLjE3Ny42NC40OjY3ODkvMCA8PT0gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIx
MCAyID09PT0gYXV0aChwcm90byAyIDMyIGJ5dGVzKSB2MSA9PT09IDU4KzArMCAoMjUwNzIzMzk1
NCAwIDApIDB4MTFlY2EwMCBjb24gMHgxNDUxNTAwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc2NzU4
IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikgZTEgaGF2ZSBjb25uZWN0aW9uCjIwMTEtMTIt
MDEgMjM6Mjc6NDIuMjc2NzcxIDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikgZTEgbXNfZGlz
cGF0Y2ggZXhpc3Rpbmcgc2Vzc2lvbiBNb25TZXNzaW9uOiBjbGllbnQuPyAxMC4xNzcuMzIuNjY6
MC8xMDA2MjEwIGlzIG9wZW4gZm9yIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAKMjAx
MS0xMi0wMSAyMzoyNzo0Mi4yNzY3NzggN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSAg
Y2FwcyAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzY3ODUgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVh
ZGVyKS5hdXRoIHYxNTUgQXV0aE1vbml0b3I6OnVwZGF0ZV9mcm9tX3BheG9zKCkKMjAxMS0xMi0w
MSAyMzoyNzo0Mi4yNzY3OTUgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKS5hdXRoIHYxNTUg
cHJlcHJvY2Vzc19xdWVyeSBhdXRoKHByb3RvIDIgMzIgYnl0ZXMpIHYxIGZyb20gY2xpZW50Lj8g
MTAuMTc3LjMyLjY2OjAvMTAwNjIxMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3NjgwMiA3ZmU2MWIw
OTA3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjE1NSBwcmVwX2F1dGgoKSBibG9iX3NpemU9MzIK
MjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzY4MDggN2ZlNjFiMDkwNzAwIGNlcGh4IHNlcnZlciBjbGll
bnQuYWRtaW46IGhhbmRsZV9yZXF1ZXN0IGdldF9hdXRoX3Nlc3Npb25fa2V5IGZvciBjbGllbnQu
YWRtaW4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzY4NTMgN2ZlNjFiMDkwNzAwIGNlcGh4IHNlcnZl
ciBjbGllbnQuYWRtaW46ICBjaGVja2luZyBrZXk6IHJlcS5rZXk9YjQzZjBmYjRlMmQ3MjhmMCBl
eHBlY3RlZF9rZXk9YjQzZjBmYjRlMmQ3MjhmMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3NjkwNyA3
ZmU2MWIwOTA3MDAgY2VwaHgga2V5c2VydmVyZGF0YTogZ2V0X3NlcnZpY2Vfc2VjcmV0IHNlcnZp
Y2UgYXV0aCBpZCAxMCBBUUE0dnRaT3dBTU5LaEFBV0NreDJIZW1yWEZTYy9lbEdCVGdpUT09IGV4
cGlyZXMgMjAxMS0xMi0wMiAwMDozNzoyOC43MDU0NTkKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzY5
MjIgN2ZlNjFiMDkwNzAwIGNlcGh4OiBidWlsZF9zZXJ2aWNlX3RpY2tldF9yZXBseSBlbmNvZGlu
ZyAxIHRpY2tldHMgd2l0aCBzZWNyZXQgQVFBTmVORk9pSXg5RGhBQXY3Nk1SWFpqV05LbjJzU1NU
UWVKb2c9PQoyMDExLTEyLTAxIDIzOjI3OjQyLjI3Njk0NSA3ZmU2MWIwOTA3MDAgY2VwaHg6IGJ1
aWxkX3NlcnZpY2VfdGlja2V0IHNlcnZpY2UgYXV0aCBzZWNyZXRfaWQgMTAgdGlja2V0X2luZm8u
dGlja2V0Lm5hbWU9Y2xpZW50LmFkbWluCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc2OTcwIDdmZTYx
YjA5MDcwMCBjZXBoeDogc2VydmljZV90aWNrZXRfYmxvYiBpcyAwMDAwIDogMDEgMGEgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgNjAgMDAgMDAgMDAgM2IgYmIgZDMgOiAuLi4uLi4uLi5gLi4uOy4uCjIw
MTEtMTItMDEgMjM6Mjc6NDIuMjc2OTgzIDAxMCA6IGFjIGRiIGU5IDc0IGRhIGNkIDNmIGU0IDli
IDhkIGM4IDFmIGExIDM3IDZiIGRjIDogLi4udC4uPy4uLi4uLjdrLgoyMDExLTEyLTAxIDIzOjI3
OjQyLjI3Njk5MyAwMjAgOiA4NyA5MSBlOSA5NiBmOCAxYSA2NyAxYiAzMSAwMyA5OSA3ZiAwOCA1
ZSAzNiA4NyA6IC4uLi4uLmcuMS4uLi5eNi4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzcwMDIgMDMw
IDogNzAgMTIgNGYgNGQgZmYgNTMgZGYgYWYgOTIgMTggNDcgYjkgMzYgZDEgOGMgYzkgOiBwLk9N
LlMuLi4uRy42Li4uCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc3MDExIDA0MCA6IGU5IDZmIGI4IGYz
IDc5IDU5IDhkIDIwIDkwIGRhIDczIGM3IGM0IGY5IDJkIDYyIDogLm8uLnlZLiAuLnMuLi4tYgoy
MDExLTEyLTAxIDIzOjI3OjQyLjI3NzAxOSAwNTAgOiBmZSA2OCBjMiBjZCBlOSAwMiAyMiBjNiBi
MiBlOCBiYyAzYiBlMSBmZCA4OSBhYiA6IC5oLi4uLiIuLi4uOy4uLi4KMjAxMS0xMi0wMSAyMzoy
Nzo0Mi4yNzcwMjcgMDYwIDogMDYgNmQgYWQgYjEgNDYgNTUgYzUgNGYgM2YgNzQgYTggNDIgZDgg
ICAgICAgICAgOiAubS4uRlUuTz90LkIuCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc3MDMyIDIwMTEt
MTItMDEgMjM6Mjc6NDIuMjc3MDQwIDdmZTYxYjA5MDcwMCBjZXBoeCBrZXlzZXJ2ZXJkYXRhOiBn
ZXRfY2FwczogbmFtZT1jbGllbnQuYWRtaW4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzcwNDcgN2Zl
NjFiMDkwNzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6IGdldF9zZWNyZXQ6IG51bSBvZiBjYXBzPTMK
MjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzcwNzIgN2ZlNjFiMDkwNzAwIC0tIDEwLjE3Ny42NC40OjY3
ODkvMCAtLT4gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMCAtLSBhdXRoX3JlcGx5KHByb3RvIDIgMCBT
dWNjZXNzKSB2MSAtLSA/KzAgMHgxMTMzMDAwIGNvbiAweDE0NTE1MDAKMjAxMS0xMi0wMSAyMzoy
Nzo0Mi4yNzc2NzUgN2ZlNjFiMDkwNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCA8PT0gY2xpZW50
Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMCAzID09PT0gYXV0aChwcm90byAyIDE2NSBieXRlcykg
djEgPT09PSAxOTErMCswICgzODg1Mzg0NjYwIDAgMCkgMHgxMWVjODAwIGNvbiAweDE0NTE1MDAK
MjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc2OTIgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBl
MSBoYXZlIGNvbm5lY3Rpb24KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc3MDUgN2ZlNjFiMDkwNzAw
IG1vbi4wQDAobGVhZGVyKSBlMSBtc19kaXNwYXRjaCBleGlzdGluZyBzZXNzaW9uIE1vblNlc3Np
b246IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgaXMgb3BlbmFsbG93ICogZm9yIGNs
aWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc3MTEg
N2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSAgY2FwcyBhbGxvdyAqCjIwMTEtMTItMDEg
MjM6Mjc6NDIuMjc3NzE4IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikuYXV0aCB2MTU1IEF1
dGhNb25pdG9yOjp1cGRhdGVfZnJvbV9wYXhvcygpCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc3NzI4
IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikuYXV0aCB2MTU1IHByZXByb2Nlc3NfcXVlcnkg
YXV0aChwcm90byAyIDE2NSBieXRlcykgdjEgZnJvbSBjbGllbnQuPyAxMC4xNzcuMzIuNjY6MC8x
MDA2MjEwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc3NzM0IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxl
YWRlcikuYXV0aCB2MTU1IHByZXBfYXV0aCgpIGJsb2Jfc2l6ZT0xNjUKMjAxMS0xMi0wMSAyMzoy
Nzo0Mi4yNzc3NDEgN2ZlNjFiMDkwNzAwIGNlcGh4IHNlcnZlciBjbGllbnQuYWRtaW46IGhhbmRs
ZV9yZXF1ZXN0IGdldF9wcmluY2lwYWxfc2Vzc2lvbl9rZXkKMjAxMS0xMi0wMSAyMzoyNzo0Mi4y
Nzc3NDkgN2ZlNjFiMDkwNzAwIGNlcGh4OiB2ZXJpZnlfYXV0aG9yaXplciBkZWNyeXB0ZWQgc2Vy
dmljZSBhdXRoIHNlY3JldF9pZD0xMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3Nzc4MyA3ZmU2MWIw
OTA3MDAgY2VwaHg6IHZlcmlmeV9hdXRob3JpemVyIGdsb2JhbF9pZD01NzA2CjIwMTEtMTItMDEg
MjM6Mjc6NDIuMjc3ODExIDdmZTYxYjA5MDcwMCBjZXBoeDogdmVyaWZ5X2F1dGhvcml6ZXIgb2sg
bm9uY2UgMTcwZGViMTI3NWNkMjFiZSByZXBseV9ibC5sZW5ndGgoKT0zNgoyMDExLTEyLTAxIDIz
OjI3OjQyLjI3NzgyMSA3ZmU2MWIwOTA3MDAgY2VwaHggc2VydmVyIGNsaWVudC5hZG1pbjogIHRp
Y2tldF9yZXEua2V5cyA9IDUKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc4MzYgN2ZlNjFiMDkwNzAw
IGNlcGh4IHNlcnZlciBjbGllbnQuYWRtaW46ICBhZGRpbmcga2V5IGZvciBzZXJ2aWNlIG1vbgoy
MDExLTEyLTAxIDIzOjI3OjQyLjI3Nzg1MiA3ZmU2MWIwOTA3MDAgY2VwaHgga2V5c2VydmVyZGF0
YTogZ2V0X3NlcnZpY2Vfc2VjcmV0IHNlcnZpY2UgbW9uIGlkIDExOSBBUUN1NWRkT3VGc3NMaEFB
NlEzV3ROUWFnTDNZRWRiSHRGQzk0UT09IGV4cGlyZXMgMjAxMS0xMi0wMSAyMzozODowNi43NzQ2
MjAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc4NzYgN2ZlNjFiMDkwNzAwIGNlcGh4IGtleXNlcnZl
cmRhdGE6IGdldF9jYXBzOiBuYW1lPWNsaWVudC5hZG1pbgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3
Nzg4NSA3ZmU2MWIwOTA3MDAgY2VwaHgga2V5c2VydmVyZGF0YTogZ2V0X3NlY3JldDogbnVtIG9m
IGNhcHM9MwoyMDExLTEyLTAxIDIzOjI3OjQyLjI3Nzg5NSA3ZmU2MWIwOTA3MDAgY2VwaHggc2Vy
dmVyIGNsaWVudC5hZG1pbjogIGFkZGluZyBrZXkgZm9yIHNlcnZpY2Ugb3NkCjIwMTEtMTItMDEg
MjM6Mjc6NDIuMjc3OTA3IDdmZTYxYjA5MDcwMCBjZXBoeCBrZXlzZXJ2ZXJkYXRhOiBnZXRfc2Vy
dmljZV9zZWNyZXQgc2VydmljZSBvc2QgaWQgMTE5IEFRQ3U1ZGRPb053c0xoQUEwZTBMSW9xMDRD
QmFZbDF3UkVPaER3PT0gZXhwaXJlcyAyMDExLTEyLTAxIDIzOjM4OjA2Ljc3NDY4MQoyMDExLTEy
LTAxIDIzOjI3OjQyLjI3NzkyNiA3ZmU2MWIwOTA3MDAgY2VwaHgga2V5c2VydmVyZGF0YTogZ2V0
X2NhcHM6IG5hbWU9Y2xpZW50LmFkbWluCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc3OTM1IDdmZTYx
YjA5MDcwMCBjZXBoeCBrZXlzZXJ2ZXJkYXRhOiBnZXRfc2VjcmV0OiBudW0gb2YgY2Fwcz0zCjIw
MTEtMTItMDEgMjM6Mjc6NDIuMjc3OTQ5IDdmZTYxYjA5MDcwMCBjZXBoeDogYnVpbGRfc2Vydmlj
ZV90aWNrZXRfcmVwbHkgZW5jb2RpbmcgMiB0aWNrZXRzIHdpdGggc2VjcmV0IEFRQmUvOWRPR0JX
QkVCQUFQeExrUkJ6c2ExdHEyaG5OOGNycDlRPT0KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzc5NzAg
N2ZlNjFiMDkwNzAwIGNlcGh4OiBidWlsZF9zZXJ2aWNlX3RpY2tldCBzZXJ2aWNlIG1vbiBzZWNy
ZXRfaWQgMTE5IHRpY2tldF9pbmZvLnRpY2tldC5uYW1lPWNsaWVudC5hZG1pbgoyMDExLTEyLTAx
IDIzOjI3OjQyLjI3Nzk5NSA3ZmU2MWIwOTA3MDAgY2VwaHg6IHNlcnZpY2VfdGlja2V0X2Jsb2Ig
aXMgMDAwMCA6IDAxIDc3IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDcwIDAwIDAwIDAwIGU0IDk2IDM0
IDogLncuLi4uLi4ucC4uLi4uNAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODAwNyAwMTAgOiBjZSA3
YSBkZiBiYiBlMSBmZCA3ZCA3OCBmMiA5ZiA5MSA5MiBmNyA2ZCA2MyBkMyA6IC56Li4uLn14Li4u
Li5tYy4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgwMTYgMDIwIDogOGEgNjAgZGUgMDYgMTkgZGYg
ZDEgYjYgMjUgMjggZDggZjIgOWMgM2IgOTkgNjcgOiAuYC4uLi4uLiUoLi4uOy5nCjIwMTEtMTIt
MDEgMjM6Mjc6NDIuMjc4MDI1IDAzMCA6IGFkIDJkIGI0IDA4IGQ5IDQyIDMxIDcwIGU2IDY4IDAz
IGMwIGM0IGVhIDQ3IGVhIDogLi0uLi5CMXAuaC4uLi5HLgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3
ODAzNCAwNDAgOiA1YSA3OSA3YSA0OSA3NCA1NyBiMCBiYiA0ZCA0NyA5ZSAyOSBjZCBmOSAwOSA0
MCA6IFp5ekl0Vy4uTUcuKS4uLkAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgwNDMgMDUwIDogNGQg
ZTcgOGUgOWEgZDggYzYgNjMgZWIgN2UgNzggZjQgMjIgOTcgOTcgNzkgZDUgOiBNLi4uLi5jLn54
LiIuLnkuCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc4MDUxIDA2MCA6IGE2IGQyIGVlIGNmIDc2IGY5
IDc4IDY2IDVlIDc1IGY5IDgzIDVlIGJjIDllIGZmIDogLi4uLnYueGZedS4uXi4uLgoyMDExLTEy
LTAxIDIzOjI3OjQyLjI3ODA1OSAwNzAgOiA1NiA1YyBhZiA3NiA3MCA2MiA0YSA1MyA5NiA3YyAy
ZSA1NCBjYSAgICAgICAgICA6IFZcLnZwYkpTLnwuVC4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgw
NjUgMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgwODEgN2ZlNjFiMDkwNzAwIGNlcGh4OiBidWlsZF9z
ZXJ2aWNlX3RpY2tldCBzZXJ2aWNlIG9zZCBzZWNyZXRfaWQgMTE5IHRpY2tldF9pbmZvLnRpY2tl
dC5uYW1lPWNsaWVudC5hZG1pbgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODEwNSA3ZmU2MWIwOTA3
MDAgY2VwaHg6IHNlcnZpY2VfdGlja2V0X2Jsb2IgaXMgMDAwMCA6IDAxIDc3IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDcwIDAwIDAwIDAwIDUyIGJjIDU3IDogLncuLi4uLi4ucC4uLlIuVwoyMDExLTEy
LTAxIDIzOjI3OjQyLjI3ODExNSAwMTAgOiA3ZiBmZCBiNiA3MSAxMCA1YSAxNSA0NyA3OSA1MyBi
YSBhMCAwMiA1YiA1MiAwNSA6IC4uLnEuWi5HeVMuLi5bUi4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4y
NzgxMjQgMDIwIDogNGQgN2IgYjQgYzYgZjMgNDcgY2IgNmYgMWIgMTcgODUgOGQgYzEgYzYgN2Qg
ZDIgOiBNey4uLkcuby4uLi4uLn0uCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc4MTMzIDAzMCA6IDk2
IDVlIGQwIGMzIDZhIDg3IDI4IGMxIGNkIDVmIDAyIDE0IDE2IDZjIGE3IDJkIDogLl4uLmouKC4u
Xy4uLmwuLQoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODE0MSAwNDAgOiAzYyBmZCAxMSAwNSA5YyBk
MiA2ZSAxMyBkNiBmNCBkOCBmNSBjNiA1NCAwZiBkYiA6IDwuLi4uLm4uLi4uLi5ULi4KMjAxMS0x
Mi0wMSAyMzoyNzo0Mi4yNzgxNTAgMDUwIDogZDAgNjUgYzYgYjYgZmIgNWYgZjEgMTUgNTggNjIg
ZGMgZWQgZjUgZDMgOWIgODAgOiAuZS4uLl8uLlhiLi4uLi4uCjIwMTEtMTItMDEgMjM6Mjc6NDIu
Mjc4MTU4IDA2MCA6IDVkIDBiIDZjIDQ3IDhlIDk3IDU5IDg3IGRjIDFiIGY3IGI3IDFiIDY2IGZk
IDYzIDogXS5sRy4uWS4uLi4uLmYuYwoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODE2OCAwNzAgOiBm
MiBkMiBjNCAwOCBhNiA4OCA0NyBiZiBmNiBkMiA0ZSAyOSBjZCAgICAgICAgICA6IC4uLi4uLkcu
Li5OKS4KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgxNzMgMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzgx
OTIgN2ZlNjFiMDkwNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4gMTAuMTc3LjMyLjY2OjAv
MTAwNjIxMCAtLSBhdXRoX3JlcGx5KHByb3RvIDIgMCBTdWNjZXNzKSB2MSAtLSA/KzAgMHgxMWVj
YTAwIGNvbiAweDE0NTE1MDAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzg3MTkgN2ZlNjFiMDkwNzAw
IC0tIDEwLjE3Ny42NC40OjY3ODkvMCA8PT0gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIx
MCA0ID09PT0gbW9uX3N1YnNjcmliZSh7bW9ubWFwPTArfSkgdjIgPT09PSAyMyswKzAgKDE2MjA1
OTMzNTQgMCAwKSAweDEyMGEwMDAgY29uIDB4MTQ1MTUwMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3
ODc0MCA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxIGhhdmUgY29ubmVjdGlvbgoyMDEx
LTEyLTAxIDIzOjI3OjQyLjI3ODc2MCA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxIG1z
X2Rpc3BhdGNoIGV4aXN0aW5nIHNlc3Npb24gTW9uU2Vzc2lvbjogY2xpZW50Lj8gMTAuMTc3LjMy
LjY2OjAvMTAwNjIxMCBpcyBvcGVuYWxsb3cgKiBmb3IgY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAv
MTAwNjIxMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODc3MyA3ZmU2MWIwOTA3MDAgbW9uLjBAMChs
ZWFkZXIpIGUxICBjYXBzIGFsbG93ICoKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzg3ODYgN2ZlNjFi
MDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBoYW5kbGVfc3Vic2NyaWJlIG1vbl9zdWJzY3JpYmUo
e21vbm1hcD0wK30pIHYyCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc4ODA1IDdmZTYxYjA5MDcwMCBt
b24uMEAwKGxlYWRlcikgZTEgY2hlY2tfc3ViIG1vbm1hcCBuZXh0IDAgaGF2ZSAxCjIwMTEtMTIt
MDEgMjM6Mjc6NDIuMjc4ODMwIDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+
IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgLS0gbW9uX21hcCB2MSAtLSA/KzAgMHgxM2U3MDAwIGNv
biAweDE0NTE1MDAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzg4NTcgN2ZlNjFiMDkwNzAwIC0tIDEw
LjE3Ny42NC40OjY3ODkvMCAtLT4gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMCAtLSBt
b25fc3Vic2NyaWJlX2FjaygzMDBzKSB2MSAtLSA/KzAgMHgxMWJkOTAwCjIwMTEtMTItMDEgMjM6
Mjc6NDIuMjc4ODc3IDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgPD09IGNsaWVu
dC41NzA2IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgNSA9PT09IG1vbl9zdWJzY3JpYmUoe21vbm1h
cD0wKyxvc2RtYXA9MH0pIHYyID09PT0gNDIrMCswICg5ODI1ODM3MTMgMCAwKSAweDE0ODUxYzAg
Y29uIDB4MTQ1MTUwMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODg4OSA3ZmU2MWIwOTA3MDAgbW9u
LjBAMChsZWFkZXIpIGUxIGhhdmUgY29ubmVjdGlvbgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3ODkw
MiA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxIG1zX2Rpc3BhdGNoIGV4aXN0aW5nIHNl
c3Npb24gTW9uU2Vzc2lvbjogY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMCBpcyBvcGVu
YWxsb3cgKiBmb3IgY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMAoyMDExLTEyLTAxIDIz
OjI3OjQyLjI3ODkwOSA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxICBjYXBzIGFsbG93
ICoKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzg5NDkgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVy
KSBlMSBoYW5kbGVfc3Vic2NyaWJlIG1vbl9zdWJzY3JpYmUoe21vbm1hcD0wKyxvc2RtYXA9MH0p
IHYyCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc4OTY1IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRl
cikgZTEgY2hlY2tfc3ViIG1vbm1hcCBuZXh0IDAgaGF2ZSAxCjIwMTEtMTItMDEgMjM6Mjc6NDIu
Mjc4OTgwIDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IDEwLjE3Ny4zMi42
NjowLzEwMDYyMTAgLS0gbW9uX21hcCB2MSAtLSA/KzAgMHgxMjBhMDAwIGNvbiAweDE0NTE1MDAK
MjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzkxMTYgN2ZlNjFiMDkwNzAwIC0tIDEwLjE3Ny42NC40OjY3
ODkvMCAtLT4gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTAwNjIxMCAtLSBvc2RfbWFwKDI2OS4u
MjY5IHNyYyBoYXMgMS4uMjY5KSB2MSAtLSA/KzAgMHgxMWVjODAwCjIwMTEtMTItMDEgMjM6Mjc6
NDIuMjc5MTQzIDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IGNsaWVudC41
NzA2IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgLS0gbW9uX3N1YnNjcmliZV9hY2soMzAwcykgdjEg
LS0gPyswIDB4MTFiZDc4MAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3OTE2MyA3ZmU2MWIwOTA3MDAg
LS0gMTAuMTc3LjY0LjQ6Njc4OS8wIDw9PSBjbGllbnQuNTcwNiAxMC4xNzcuMzIuNjY6MC8xMDA2
MjEwIDYgPT09PSBtb25fc3Vic2NyaWJlKHttb25tYXA9MCssb3NkbWFwPTB9KSB2MiA9PT09IDQy
KzArMCAoOTgyNTgzNzEzIDAgMCkgMHgxNDg1MDAwIGNvbiAweDE0NTE1MDAKMjAxMS0xMi0wMSAy
MzoyNzo0Mi4yNzkxNzEgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBoYXZlIGNvbm5l
Y3Rpb24KMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzkxODIgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVh
ZGVyKSBlMSBtc19kaXNwYXRjaCBleGlzdGluZyBzZXNzaW9uIE1vblNlc3Npb246IGNsaWVudC4/
IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAgaXMgb3BlbmFsbG93ICogZm9yIGNsaWVudC4/IDEwLjE3
Ny4zMi42NjowLzEwMDYyMTAKMjAxMS0xMi0wMSAyMzoyNzo0Mi4yNzkxODkgN2ZlNjFiMDkwNzAw
IG1vbi4wQDAobGVhZGVyKSBlMSAgY2FwcyBhbGxvdyAqCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc5
MTk3IDdmZTYxYjA5MDcwMCBtb24uMEAwKGxlYWRlcikgZTEgaGFuZGxlX3N1YnNjcmliZSBtb25f
c3Vic2NyaWJlKHttb25tYXA9MCssb3NkbWFwPTB9KSB2MgoyMDExLTEyLTAxIDIzOjI3OjQyLjI3
OTIwOCA3ZmU2MWIwOTA3MDAgbW9uLjBAMChsZWFkZXIpIGUxIGNoZWNrX3N1YiBtb25tYXAgbmV4
dCAwIGhhdmUgMQoyMDExLTEyLTAxIDIzOjI3OjQyLjI3OTIyNiA3ZmU2MWIwOTA3MDAgLS0gMTAu
MTc3LjY0LjQ6Njc4OS8wIC0tPiAxMC4xNzcuMzIuNjY6MC8xMDA2MjEwIC0tIG1vbl9tYXAgdjEg
LS0gPyswIDB4MTQ4NTFjMCBjb24gMHgxNDUxNTAwCjIwMTEtMTItMDEgMjM6Mjc6NDIuMjc5MzE3
IDdmZTYxYjA5MDcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IGNsaWVudC4/IDEwLjE3Ny4z
Mi42NjowLzEwMDYyMTAgLS0gb3NkX21hcCgyNjkuLjI2OSBzcmMgaGFzIDEuLjI2OSkgdjEgLS0g
PyswIDB4MTFlYzYwMAoyMDExLTEyLTAxIDIzOjI3OjQyLjI3OTMzOCA3ZmU2MWIwOTA3MDAgLS0g
MTAuMTc3LjY0LjQ6Njc4OS8wIC0tPiBjbGllbnQuNTcwNiAxMC4xNzcuMzIuNjY6MC8xMDA2MjEw
IC0tIG1vbl9zdWJzY3JpYmVfYWNrKDMwMHMpIHYxIC0tID8rMCAweDExYmQ2MDAKMjAxMS0xMi0w
MSAyMzoyNzo0Mi4yOTQyNzggN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBtc19oYW5k
bGVfcmVzZXQgMHgxNDUxNTAwIDEwLjE3Ny4zMi42NjowLzEwMDYyMTAKMjAxMS0xMi0wMSAyMzoy
Nzo0Mi4yOTQzMDUgN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSByZXNldC9jbG9zZSBv
biBzZXNzaW9uIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAKMjAxMS0xMi0wMSAyMzoy
Nzo0Mi4yOTQzMTggN2ZlNjFiMDkwNzAwIG1vbi4wQDAobGVhZGVyKSBlMSByZW1vdmVfc2Vzc2lv
biBNb25TZXNzaW9uOiBjbGllbnQuPyAxMC4xNzcuMzIuNjY6MC8xMDA2MjEwIGlzIG9wZW5hbGxv
dyAqIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEwMDYyMTAK
--0016e6de1792cb839204b3a834be--
