From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Problem with attaching rbd device in qemu-kvm
Date: Thu, 01 Dec 2011 12:42:05 -0800
Message-ID: <4ED7E69D.7070909@dreamhost.com>
References: <CAMwB3ThP55_KV4CQ1Yd=goqSDxug79vnznq3pqjFVQcbap1nWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43787 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1LAUmG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2011 15:42:06 -0500
In-Reply-To: <CAMwB3ThP55_KV4CQ1Yd=goqSDxug79vnznq3pqjFVQcbap1nWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U8WCYXdvbWlyIFNrb3dyb24=?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/01/2011 11:37 AM, S=C5=82awomir Skowron wrote:
> I have some problems. Can you help me ??
>
> ceph cluster:
> ceph 0.38, oneiric, kernel 3.0.0 x86_64 - now only one machine.
>
> kvm hypervisor:
> kvm version 1.0-rc4 (0.15.92), libvirt 0.9.2, kernel 3.0.0, Ubuntu
> oneiric x86_64.
>
> I create image from qemu-img on machine with kvm VM's, and it works v=
ery well:
>
> qemu-img create -f rbd rbd:kvmtest/kvmtest1 10G
> Formatting 'rbd:kvmtest/kvmtest1', fmt=3Drbd size=3D10737418240 clust=
er_size=3D0
>
> in ceph cluster machines:
>
> rados -p kvmtest ls
> kvmtest1.rbd
> rbd_directory
> rbd_info
>
> But when i try to attach new device to kvm VM like this:
>
> virsh attach-device one-10 /tmp/kvm.xml
>
> with kvm.xml like this:
>
> <disk type=3D'network' device=3D'disk'>
>          <driver name=3D'qemu' type=3D'raw' cache=3D'writeback'/>
>          <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>
>                  <host name=3D'10.177.64.4' port=3D'6789'/>
>          </source>
>          <target dev=3D'vdc' bus=3D'virtio'/>
> </disk>
>
> output of virsh:
>
> error: Failed to attach device from /tmp/kvm.xml
> error: cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or d=
irectory

 From the monitor output below, I'm assuming this is just a bad error=20
message from libvirt.

> and mon.0 log in ceph cluster.
>
> 2011-12-01 20:18:17.142595 7fe02dd04700 mon.0@0(leader) e1
> ms_verify_authorizer 10.177.32.66:0/25020608 client protocol 0
> 2011-12-01 20:18:17.143041 7fe03223b700 -- 10.177.64.4:6789/0<=3D=3D
> client.? 10.177.32.66:0/25020608 1 =3D=3D=3D=3D auth(proto 0 21 bytes=
) v1 =3D=3D=3D=3D
> 47+0+0 (3310669357 0 0) 0x29f6a00 con 0x297adc0
> 2011-12-01 20:18:17.143095 7fe03223b700 mon.0@0(leader) e1 ms_dispatc=
h
> new session MonSession: client.? 10.177.32.66:0/25020608 is open for
> client.? 10.177.32.66:0/25020608
> 2011-12-01 20:18:17.143125 7fe03223b700 mon.0@0(leader).auth v146
> preprocess_query auth(proto 0 21 bytes) v1 from client.?
> 10.177.32.66:0/25020608
> 2011-12-01 20:18:17.143168 7fe03223b700 -- 10.177.64.4:6789/0 -->
> 10.177.32.66:0/25020608 -- auth_reply(proto 0 -95 Operation not
> supported) v1 -- ?+0 0x2f30600 con 0x297adc0

Here you can see qemu isn't authenticating correctly, probably because=20
the rados user isn't being set by libvirt. With your libvirt version,=20
you'll need to change:

    <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>

to

    <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1:id=3Dfoo'>

to authenticate as client.foo. Any ceph config option can be set like=20
that, separated by colons.

If this still doesn't work, I'd suggest setting=20
debug_rbd=3D20:debug_monc=3D20:debug_auth=3D20:log_to_stderr=3D2 to get=
 more=20
info in the libvirt instance log (usually=20
/var/log/libvirt/qemu/instance_name.log). There may be apparmour=20
restrictions preventing qemu from reading the keyring or ceph config fi=
les.

> ceph.conf, and keyring.bin exists on server, and machine with qemu-kv=
m
> in same directory:
> ; global
> [global]
>          ; enable secure authentication
>
>          auth supported =3D cephx
>          keyring =3D /etc/ceph/keyring.bin
>
>          debug rgw =3D 1
>
>          rgw print continue =3D false
>          rgw socket path =3D /var/run/radosgw.sock
>
> ; monitors
> ;  You need at least one.  You need at least three if you want to
> ;  tolerate any node failures.  Always create an odd number.
> [mon]
>          mon data =3D /vol0/data/mon.$id
>
>          ; some minimal logging (just message traffic) to aid debuggi=
ng
>
>          debug ms =3D 1     ; see message traffic
>          debug mon =3D 0   ; monitor
>          debug paxos =3D 0 ; monitor replication
>          debug auth =3D 0  ;
>
>          mon allowed clock drift =3D 2
>
> [mon.0]
>          host =3D 10-177-64-4
>          mon addr =3D 10.177.64.4:6789
>
> ; radosgw client list
> [client.radosgw.10-177-64-4]
>
>          host =3D 10-177-64-4
>          log file =3D /var/log/ceph/$name.log
>          debug rgw =3D 1
>          debug ms =3D 1
>
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
>          ; This is where the btrfs volume will be mounted.
>
>          osd data =3D /vol0/data/osd.$id
>
>          ; Ideally, make this a separate disk or partition.  A few GB
>          ; is usually enough; more if you have fast disks.  You can u=
se
>          ; a file under the osd data dir if need be
>          ; (e.g. /data/osd$id/journal), but it will be slower than a
>          ; separate disk or partition.
>
>          osd journal =3D /vol0/data/osd.$id/journal
>
>          ; If the OSD journal is a file, you need to specify the size=
=2E
> This is specified in MB.
>
>          osd journal size =3D 512
>
>          filestore journal writeahead =3D 1
>          osd heartbeat grace =3D 5
>
>          debug ms =3D 0         ; message traffic
>          debug osd =3D 0
>          debug filestore =3D 0 ; local object storage
>          debug journal =3D 0   ; local journaling
>          debug monc =3D 0
>          debug rados =3D 1
>
> [osd.0]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.0
>          keyring =3D /vol0/data/osd.0/keyring
>
> [osd.1]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.1
>          keyring =3D /vol0/data/osd.1/keyring
>
> [osd.2]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.2
>          keyring =3D /vol0/data/osd.2/keyring
>
> [osd.3]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.3
>          keyring =3D /vol0/data/osd.3/keyring
>
> [osd.4]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.4
>          keyring =3D /vol0/data/osd.4/keyring
>
> [osd.5]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.5
>          keyring =3D /vol0/data/osd.5/keyring
>
> [osd.6]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.6
>          keyring =3D /vol0/data/osd.6/keyring
>
> [osd.7]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.7
>          keyring =3D /vol0/data/osd.7/keyring
>
> [osd.8]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.8
>          keyring =3D /vol0/data/osd.8/keyring
>
> [osd.9]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.9
>          keyring =3D /vol0/data/osd.9/keyring
>
> [osd.10]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.10
>          keyring =3D /vol0/data/osd.10/keyring
>
> [osd.11]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.11
>          keyring =3D /vol0/data/osd.11/keyring
>
> [osd.12]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.12
>          keyring =3D /vol0/data/osd.12/keyring
>
> [osd.13]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.13
>          keyring =3D /vol0/data/osd.13/keyring
>
> [osd.14]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.14
>          keyring =3D /vol0/data/osd.14/keyring
>
> [osd.15]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.15
>          keyring =3D /vol0/data/osd.15/keyring
>
> [osd.16]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.16
>          keyring =3D /vol0/data/osd.16/keyring
>
> [osd.17]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.17
>          keyring =3D /vol0/data/osd.17/keyring
>
> [osd.18]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.18
>          keyring =3D /vol0/data/osd.18/keyring
>
> [osd.19]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.19
>          keyring =3D /vol0/data/osd.19/keyring
>
> [osd.20]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.20
>          keyring =3D /vol0/data/osd.20/keyring
>
> [osd.21]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.21
>          keyring =3D /vol0/data/osd.21/keyring
>
> [osd.22]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.22
>          keyring =3D /vol0/data/osd.22/keyring
>
> [osd.23]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.23
>          keyring =3D /vol0/data/osd.23/keyring
>
> [osd.24]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.24
>          keyring =3D /vol0/data/osd.24/keyring
>
> [osd.25]
>          host =3D 10-177-64-4
>          osd data =3D /vol0/data/osd.25
>          keyring =3D /vol0/data/osd.25/keyring
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
