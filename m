From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Problem with attaching rbd device in qemu-kvm
Date: Mon, 19 Dec 2011 16:37:19 +0100
Message-ID: <CAMwB3Tg6z8qmAX3Bnmh68ZK_ddjFP8y7keFQE32Lz0H7eLPG6g@mail.gmail.com>
References: <CAMwB3ThP55_KV4CQ1Yd=goqSDxug79vnznq3pqjFVQcbap1nWw@mail.gmail.com>
	<4ED7E69D.7070909@dreamhost.com>
	<CAMwB3TgS0XuhqPEh5kTdJsNf1BP=2uOXUex4izTZhfbLbT9FNQ@mail.gmail.com>
	<4EE64DC2.9090206@dreamhost.com>
	<CAMwB3Th9ycRbMmsGon0SCFEy9yeMQ-nE5dJ=NfntwxhXFyatpw@mail.gmail.com>
	<4EE7B0A5.6000906@dreamhost.com>
	<CAMwB3Tir5aotsbauoztfS3yb0hdMjrXXsNwCmLAYVMr9iSoruQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cd2a8e7b25304b473b93d
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60785 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab1LSPhW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 10:37:22 -0500
Received: by eaaj10 with SMTP id j10so4863637eaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 07:37:20 -0800 (PST)
In-Reply-To: <CAMwB3Tir5aotsbauoztfS3yb0hdMjrXXsNwCmLAYVMr9iSoruQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

--0015175cd2a8e7b25304b473b93d
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

Actual setup:

ii  libvirt-bin                      0.9.2-4ubuntu15.1
      the programs for the libvirt library
ii  libvirt0                         0.9.2-4ubuntu15.1
      library for interfacing with different virtualization systems
ii  qemu-kvm                         1.0.0+dfsg+rc2-1~oneiric1
      Full virtualization on i386 and amd64 hardware

I change many thing in system, and successfully attached rbd drives via lib=
virt:

virsh attach-device one-888 kvm-ceph.xml
Device attached successfully

A new set of disks, appears in libvirt vm xml, but not in vm machine.
After reboot, all new rbd drives appear in VM.

Is there any chance to hotadd rbd device to working VM without reboot ??


2011/12/16 S=B3awomir Skowron <szibis@gmail.com>:
> 2011/12/13 Josh Durgin <josh.durgin@dreamhost.com>:
>> On 12/13/2011 04:56 AM, S=B3awomir Skowron wrote:
>>>
>>> Finally, i manage the problem with rbd with kvm 1.0, and libvirt
>>> 0.9.8, or i think i manage :), but i get stuck with one thing after.
>>>
>>> 2011-12-13 12:13:31.173+0000: 21512: error :
>>> qemuMonitorJSONCheckError:318 : internal error unable to execute QEMU
>>> command 'device_add': Bus 'pci.0' does not support hotplugging
>>> 2011-12-13 12:13:31.173+0000: 21512: warning :
>>> qemuDomainAttachPciDiskDevice:244 : qemuMonitorAddDevice failed on
>>>
>>> file=3Drbd:rbd/testdysk:id=3Dadmin:key=3DAQANeNFOiIx9DhAAv76MRXZjWNKn2s=
SSTQeJog=3D=3D:auth_supported=3Dcephx
>>> none:mon_host=3D10.177.64.4\:6789,if=3Dnone,id=3Ddrive-virtio-disk2,for=
mat=3Draw
>>>
>>> (virtio-blk-pci,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk2,id=3D=
virtio-disk2)
>>> 2011-12-13 12:13:31.173+0000: 21512: error :
>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
>>> rbd/testdysk: No such file or directory2011-12-13 12:13:31.173+0000:
>>> 21512: warning : qemuDomainAttachPciDiskDevice:287 : Unable to restore
>>> security label on rbd/testdysk
>>> and i can't find any info about that.
>>>
>>> my kvm.xml inject file:
>>>
>>> <disk type=3D"network" device=3D"disk">
>>> =A0 =A0 =A0 =A0 =A0<driver name=3D"qemu" type=3D"raw"/>
>>> =A0 =A0 =A0 =A0 =A0<auth username=3D"admin">
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<secret type=3D"ceph"
>>> uuid=3D"0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f"/>
>>> =A0 =A0 =A0 =A0 =A0</auth>
>>> =A0 =A0 =A0 =A0 =A0<source protocol=3D"rbd" name=3D"rbd/testdysk">
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<host name=3D"10.177.64.4" port=3D"6=
789"/>
>>> =A0 =A0 =A0 =A0 =A0</source>
>>> =A0 =A0 =A0 =A0 =A0<target dev=3D"sdc" bus=3D"virtio"/>
>>> </disk>
>>>
>>> secret:
>>>
>>> cat /tmp/secret.xml
>>> <secret ephemeral=3D'no' private=3D'no'>
>>> =A0 =A0 =A0<uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
>>> =A0 =A0 =A0<usage type=3D'ceph'>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0<domain>rbd/admin</domain>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0<name>admin</name>
>>> =A0 =A0 =A0</usage>
>>> </secret>
>>>
>>> virsh secret-define /tmp/secret.xml
>>> Secret 0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f created
>>>
>>> virsh secret-set-value 0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f
>>> AQANeNFOiIx9DhAAv76MRXZjWNKn2sSSTQeJog=3D=3D
>>> Secret value set
>>>
>>
>> Your xml and configuration are all fine, you're hitting the libvirt bug =
that
>> I mentioned before. The fix isn't in any stable release yet, and 0.9.8 w=
as
>> just released yesterday, so I guess you'll have to compile it yourself o=
r
>> disable the libvirt security driver.
>
> Yes libvirt 0.9.8 with this patch solved problem with rbd, now it's
> clean. Thanks for that.
>
> But, a second problem appear.
>
> error: Failed to attach device from /root/kvm-ceph.xml
> error: internal error unable to execute QEMU command 'device_add':
> Property 'virtio-blk-pci.drive' can't find value 'drive-virtio-disk3'
>
> /var/log/libvirt/libvirtd.log
> 2011-12-16 12:03:04.950+0000: 1070: error :
> qemuMonitorJSONCheckError:318 : internal error unable to execute QEMU
> command 'device_add': Property 'virtio-blk-pci.drive' can't find value
> 'drive-virtio-disk3'
> 2011-12-16 12:03:04.950+0000: 1070: warning :
> qemuDomainAttachPciDiskDevice:244 : qemuMonitorAddDevice failed on
> file=3Drbd:rbd/testdysk:rbd_writeback_window=3D8000000:id=3Dadmin:key=3DA=
QANeNFOiIx9DhAAv76MRXZjWNKn2sSSTQeJog=3D=3D:auth_supported=3Dcephx
> none:mon_host=3D10.177.64.4\:6789,if=3Dnone,id=3Ddrive-virtio-disk3,forma=
t=3Draw
> (virtio-blk-pci,bus=3Dpci.0,addr=3D0xd,drive=3Ddrive-virtio-disk3,id=3Dvi=
rtio-disk3)
>
> if i attach a scsi device from img file everything is OK.
>
> Anyone have, any concept with this ??
>
>>
>>
>>> 2011/12/12 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>
>>>> On 12/09/2011 04:48 AM, S=B3awomir Skowron wrote:
>>>>>
>>>>>
>>>>> Sorry, for my lag, but i was sick.
>>>>>
>>>>> I handled problem with apparmor before and now it's not a problem,
>>>>> even when i send mail before, it was solved.
>>>>>
>>>>> Ok when i create image from qemu-img it's looks like that, and works
>>>>> perfect, (attachment with log of this opperation.)
>>>>>
>>>>> But when i use virsh, it's still a problem. Just like he don't know
>>>>> what user is going to be auth.
>>>>>
>>>>> I try, as client.admin (default i hope :)) only with id=3Dadmin in
>>>>> kvm.xml, or client=3Dadmin, and other combinations - like client.rbd
>>>>> etc., Still nothing.
>>>>
>>>>
>>>>
>>>> admin is the default, and the correct option for client.admin is
>>>> id=3Dadmin,
>>>> or id=3Dfoo for client.foo.
>>>>
>>>>
>>>>>
>>>>> I try, improve a keyring file, adding client rbd into keyring on
>>>>> machine with kvm hypervisor in /etc/ceph/keyring.bin
>>>>>
>>>>> [client.rbd]
>>>>> =A0 =A0 =A0 =A0 key =3D AAAAAAAAAAAAAAAA
>>>>> =A0 =A0 =A0 =A0 auid =3D 18446744073709551615
>>>>> =A0 =A0 =A0 =A0 caps mds =3D "allow"
>>>>> =A0 =A0 =A0 =A0 caps mon =3D "allow r"
>>>>> =A0 =A0 =A0 =A0 caps osd =3D "allow rw pool=3Dkvmtest"
>>>>>
>>>>> and on cluster site like above. I was added, a section [client.rbd]
>>>>> with keyring path, and it's still a problem.
>>>>>
>>>>
>>>> Did you run 'ceph auth add -i /etc/ceph/keyring.bin'?
>>>> Make sure 'ceph auth list' shows client.rbd with the right key.
>>>
>>>
>>> Overall i want to use admin id, and i think now it's correctly used in
>>> xml.
>>>
>>>>
>>>>
>>>>> 2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
>>>>> ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
>>>>> root@s3-10-177-64-4:~# tail -n10000 /var/log/ceph/mon.0.log | grep
>>>>> 13:29:11.
>>>>> 2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
>>>>> ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
>>>>> 2011-12-09 13:29:11.519624 7fe61b090700 -- 10.177.64.4:6789/0<=3D=3D
>>>>> client.? 10.177.32.66:0/58020608 1 =3D=3D=3D=3D auth(proto 0 21 bytes=
) v1 =3D=3D=3D=3D
>>>>> 47+0+0 (3310669357 0 0) 0x17f2e00 con 0x19d2c80
>>>>> 2011-12-09 13:29:11.519645 7fe61b090700 mon.0@0(leader) e1 have
>>>>> connection
>>>>> 2011-12-09 13:29:11.519655 7fe61b090700 mon.0@0(leader) e1 do not hav=
e
>>>>> session, making new one
>>>>> 2011-12-09 13:29:11.519668 7fe61b090700 mon.0@0(leader) e1 ms_dispatc=
h
>>>>> new session MonSession: client.? 10.177.32.66:0/58020608 is open for
>>>>> client.? 10.177.32.66:0/58020608
>>>>> 2011-12-09 13:29:11.519674 7fe61b090700 mon.0@0(leader) e1 setting
>>>>> timeout on session
>>>>> 2011-12-09 13:29:11.519680 7fe61b090700 mon.0@0(leader) e1 =A0caps
>>>>> 2011-12-09 13:29:11.519688 7fe61b090700 mon.0@0(leader).auth v353
>>>>> AuthMonitor::update_from_paxos()
>>>>> 2011-12-09 13:29:11.519697 7fe61b090700 mon.0@0(leader).auth v353
>>>>> preprocess_query auth(proto 0 21 bytes) v1 from client.?
>>>>> 10.177.32.66:0/58020608
>>>>> 2011-12-09 13:29:11.519703 7fe61b090700 mon.0@0(leader).auth v353
>>>>> prep_auth() blob_size=3D21
>>>>> 2011-12-09 13:29:11.519735 7fe61b090700 -- 10.177.64.4:6789/0 -->
>>>>> 10.177.32.66:0/58020608 -- auth_reply(proto 0 -95 Operation not
>>>>> supported) v1 -- ?+0 0x1246200 con 0x19d2c80
>>>>>
>>>>> from libvirt.log
>>>>>
>>>>> 23:20:56.689: 1309: error : virSecurityDACRestoreSecurityFileLabel:14=
3
>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No such f=
ile
>>>>> or directory
>>>>> 23:20:56.882: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:name=3Dadmin
>>>>> 23:21:09.172: 1309: error : qemuMonitorTextAddDrive:2418 : operation
>>>>> failed: open disk image file failed
>>>>> 23:21:09.172: 1309: error : virSecurityDACRestoreSecurityFileLabel:14=
3
>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No such f=
ile
>>>>> or directory
>>>>> 23:21:09.364: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:name=3Dadmin
>>>>> 23:21:49.645: 1309: error : qemuMonitorTextAddDrive:2418 : operation
>>>>> failed: open disk image file failed
>>>>> 23:21:49.645: 1309: error : virSecurityDACRestoreSecurityFileLabel:14=
3
>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:id=3Dadmin: No such fil=
e
>>>>> or directory
>>>>> 23:21:49.853: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:id=3Dadmin
>>>>> 13:08:08.924: 1309: error : qemuMonitorTextAddDrive:2418 : operation
>>>>> failed: open disk image file failed
>>>>> 13:08:08.924: 1309: error : virSecurityDACRestoreSecurityFileLabel:14=
3
>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or
>>>>> directory
>>>>> 13:08:09.117: 1309: warning : qemuDomainAttachPciDiskDevice:250 :
>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1
>>>>> 13:09:45.402: 1309: error : qemuMonitorTextAddDrive:2418 : operation
>>>>> failed: open disk image file failed
>>>>> 13:29:05.554: 1310: error : qemuMonitorTextAddDrive:2418 : operation
>>>>> failed: open disk image file failed
>>>>> 13:29:05.554: 1310: error : virSecurityDACRestoreSecurityFileLabel:14=
3
>>>>> : cannot resolve symlink kvmtest/kvmtest1: No such file or directory
>>>>> 13:29:05.751: 1310: warning : qemuDomainAttachPciDiskDevice:250 :
>>>>> Unable to restore security label on kvmtest/kvmtest1
>>>>> 13:29:05.751: 1310: warning : virEventPollUpdateHandle:147 : Ignoring
>>>>> invalid update watch -1
>>>>
>>>>
>>>>
>>>> This is libvirt mistakenly trying to treat the rbd disk as a file - fi=
xed
>>>> in
>>>> 20e1233c31e3150d259073c523077acdccb5d419 to libvirt. If you don't want=
 to
>>>> upgrade libvirt, someone on IRC last week reported that installing
>>>> libapparmor1 fixed this problem for them, since libvirt no longer fell
>>>> back
>>>> to it's own DAC implementation.
>>>
>>>
>>> hmm is this commited to any stable version now ?? i have installed
>>> libapparmor1,
>>>
>>> ri =A0libapparmor1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.7.0~beta1+b=
zr1774-1ubuntu2
>>> =A0 =A0 =A0 =A0 changehat AppArmor library
>>>
>>> and i use newest stable libvirt 0.9.8.
>>>
>>>>
>>>>
>>>>> 2011/12/1 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>>>
>>>>>>
>>>>>> On 12/01/2011 11:37 AM, S=B3awomir Skowron wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I have some problems. Can you help me ??
>>>>>>>
>>>>>>> ceph cluster:
>>>>>>> ceph 0.38, oneiric, kernel 3.0.0 x86_64 - now only one machine.
>>>>>>>
>>>>>>> kvm hypervisor:
>>>>>>> kvm version 1.0-rc4 (0.15.92), libvirt 0.9.2, kernel 3.0.0, Ubuntu
>>>>>>> oneiric x86_64.
>>>>>>>
>>>>>>> I create image from qemu-img on machine with kvm VM's, and it works
>>>>>>> very
>>>>>>> well:
>>>>>>>
>>>>>>> qemu-img create -f rbd rbd:kvmtest/kvmtest1 10G
>>>>>>> Formatting 'rbd:kvmtest/kvmtest1', fmt=3Drbd size=3D10737418240
>>>>>>> cluster_size=3D0
>>>>>>>
>>>>>>> in ceph cluster machines:
>>>>>>>
>>>>>>> rados -p kvmtest ls
>>>>>>> kvmtest1.rbd
>>>>>>> rbd_directory
>>>>>>> rbd_info
>>>>>>>
>>>>>>> But when i try to attach new device to kvm VM like this:
>>>>>>>
>>>>>>> virsh attach-device one-10 /tmp/kvm.xml
>>>>>>>
>>>>>>> with kvm.xml like this:
>>>>>>>
>>>>>>> <disk type=3D'network' device=3D'disk'>
>>>>>>> =A0 =A0 =A0 =A0 <driver name=3D'qemu' type=3D'raw' cache=3D'writeba=
ck'/>
>>>>>>> =A0 =A0 =A0 =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtes=
t1'>
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <host name=3D'10.177.64.4' port=3D'=
6789'/>
>>>>>>> =A0 =A0 =A0 =A0 </source>
>>>>>>> =A0 =A0 =A0 =A0 <target dev=3D'vdc' bus=3D'virtio'/>
>>>>>>> </disk>
>>>>>>>
>>>>>>> output of virsh:
>>>>>>>
>>>>>>> error: Failed to attach device from /tmp/kvm.xml
>>>>>>> error: cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or
>>>>>>> directory
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> =A0From the monitor output below, I'm assuming this is just a bad er=
ror
>>>>>> message
>>>>>> from libvirt.
>>>>>>
>>>>>>
>>>>>>> and mon.0 log in ceph cluster.
>>>>>>>
>>>>>>> 2011-12-01 20:18:17.142595 7fe02dd04700 mon.0@0(leader) e1
>>>>>>> ms_verify_authorizer 10.177.32.66:0/25020608 client protocol 0
>>>>>>> 2011-12-01 20:18:17.143041 7fe03223b700 -- 10.177.64.4:6789/0<=3D=
=3D
>>>>>>> client.? 10.177.32.66:0/25020608 1 =3D=3D=3D=3D auth(proto 0 21 byt=
es) v1 =3D=3D=3D=3D
>>>>>>> 47+0+0 (3310669357 0 0) 0x29f6a00 con 0x297adc0
>>>>>>> 2011-12-01 20:18:17.143095 7fe03223b700 mon.0@0(leader) e1 ms_dispa=
tch
>>>>>>> new session MonSession: client.? 10.177.32.66:0/25020608 is open fo=
r
>>>>>>> client.? 10.177.32.66:0/25020608
>>>>>>> 2011-12-01 20:18:17.143125 7fe03223b700 mon.0@0(leader).auth v146
>>>>>>> preprocess_query auth(proto 0 21 bytes) v1 from client.?
>>>>>>> 10.177.32.66:0/25020608
>>>>>>> 2011-12-01 20:18:17.143168 7fe03223b700 -- 10.177.64.4:6789/0 -->
>>>>>>> 10.177.32.66:0/25020608 -- auth_reply(proto 0 -95 Operation not
>>>>>>> supported) v1 -- ?+0 0x2f30600 con 0x297adc0
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Here you can see qemu isn't authenticating correctly, probably becau=
se
>>>>>> the
>>>>>> rados user isn't being set by libvirt. With your libvirt version,
>>>>>> you'll
>>>>>> need to change:
>>>>>>
>>>>>>
>>>>>> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>
>>>>>>
>>>>>> to
>>>>>>
>>>>>> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1:id=3Dfoo'>
>>>>>>
>>>>>> to authenticate as client.foo. Any ceph config option can be set lik=
e
>>>>>> that,
>>>>>> separated by colons.
>>>>>>
>>>>>> If this still doesn't work, I'd suggest setting
>>>>>> debug_rbd=3D20:debug_monc=3D20:debug_auth=3D20:log_to_stderr=3D2 to =
get more
>>>>>> info
>>>>>> in
>>>>>> the libvirt instance log (usually
>>>>>> /var/log/libvirt/qemu/instance_name.log).
>>>>>> There may be apparmour restrictions preventing qemu from reading the
>>>>>> keyring
>>>>>> or ceph config files.
>>>>>>
>>>>>>
>>>>>>> ceph.conf, and keyring.bin exists on server, and machine with qemu-=
kvm
>>>>>>> in same directory:
>>>>>>> ; global
>>>>>>> [global]
>>>>>>> =A0 =A0 =A0 =A0 ; enable secure authentication
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.bin
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 rgw print continue =3D false
>>>>>>> =A0 =A0 =A0 =A0 rgw socket path =3D /var/run/radosgw.sock
>>>>>>>
>>>>>>> ; monitors
>>>>>>> ; =A0You need at least one. =A0You need at least three if you want =
to
>>>>>>> ; =A0tolerate any node failures. =A0Always create an odd number.
>>>>>>> [mon]
>>>>>>> =A0 =A0 =A0 =A0 mon data =3D /vol0/data/mon.$id
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 ; some minimal logging (just message traffic) to ai=
d debugging
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 1 =A0 =A0 ; see message traffic
>>>>>>> =A0 =A0 =A0 =A0 debug mon =3D 0 =A0 ; monitor
>>>>>>> =A0 =A0 =A0 =A0 debug paxos =3D 0 ; monitor replication
>>>>>>> =A0 =A0 =A0 =A0 debug auth =3D 0 =A0;
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 mon allowed clock drift =3D 2
>>>>>>>
>>>>>>> [mon.0]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 mon addr =3D 10.177.64.4:6789
>>>>>>>
>>>>>>> ; radosgw client list
>>>>>>> [client.radosgw.10-177-64-4]
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 log file =3D /var/log/ceph/$name.log
>>>>>>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 1
>>>>>>>
>>>>>>> ; osd
>>>>>>> ; =A0You need at least one. =A0Two if you want data to be replicate=
d.
>>>>>>> ; =A0Define as many as you like.
>>>>>>> [osd]
>>>>>>> =A0 =A0 =A0 =A0 ; This is where the btrfs volume will be mounted.
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.$id
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 ; Ideally, make this a separate disk or partition. =
=A0A few GB
>>>>>>> =A0 =A0 =A0 =A0 ; is usually enough; more if you have fast disks. =
=A0You can use
>>>>>>> =A0 =A0 =A0 =A0 ; a file under the osd data dir if need be
>>>>>>> =A0 =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be slowe=
r than a
>>>>>>> =A0 =A0 =A0 =A0 ; separate disk or partition.
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 osd journal =3D /vol0/data/osd.$id/journal
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 ; If the OSD journal is a file, you need to specify=
 the size.
>>>>>>> This is specified in MB.
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 osd journal size =3D 512
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 filestore journal writeahead =3D 1
>>>>>>> =A0 =A0 =A0 =A0 osd heartbeat grace =3D 5
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 0 =A0 =A0 =A0 =A0 ; message traffic
>>>>>>> =A0 =A0 =A0 =A0 debug osd =3D 0
>>>>>>> =A0 =A0 =A0 =A0 debug filestore =3D 0 ; local object storage
>>>>>>> =A0 =A0 =A0 =A0 debug journal =3D 0 =A0 ; local journaling
>>>>>>> =A0 =A0 =A0 =A0 debug monc =3D 0
>>>>>>> =A0 =A0 =A0 =A0 debug rados =3D 1
>>>>>>>
>>>>>>> [osd.0]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.0
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.0/keyring
>>>>>>>
>>>>>>> [osd.1]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.1
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.1/keyring
>>>>>>>
>>>>>>> [osd.2]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.2
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.2/keyring
>>>>>>>
>>>>>>> [osd.3]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.3
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.3/keyring
>>>>>>>
>>>>>>> [osd.4]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.4
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.4/keyring
>>>>>>>
>>>>>>> [osd.5]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.5
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.5/keyring
>>>>>>>
>>>>>>> [osd.6]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.6
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.6/keyring
>>>>>>>
>>>>>>> [osd.7]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.7
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.7/keyring
>>>>>>>
>>>>>>> [osd.8]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.8
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.8/keyring
>>>>>>>
>>>>>>> [osd.9]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.9
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.9/keyring
>>>>>>>
>>>>>>> [osd.10]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.10
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.10/keyring
>>>>>>>
>>>>>>> [osd.11]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.11
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.11/keyring
>>>>>>>
>>>>>>> [osd.12]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.12
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.12/keyring
>>>>>>>
>>>>>>> [osd.13]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.13
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.13/keyring
>>>>>>>
>>>>>>> [osd.14]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.14
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.14/keyring
>>>>>>>
>>>>>>> [osd.15]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.15
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.15/keyring
>>>>>>>
>>>>>>> [osd.16]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.16
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.16/keyring
>>>>>>>
>>>>>>> [osd.17]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.17
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.17/keyring
>>>>>>>
>>>>>>> [osd.18]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.18
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.18/keyring
>>>>>>>
>>>>>>> [osd.19]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.19
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.19/keyring
>>>>>>>
>>>>>>> [osd.20]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.20
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.20/keyring
>>>>>>>
>>>>>>> [osd.21]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.21
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.21/keyring
>>>>>>>
>>>>>>> [osd.22]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.22
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.22/keyring
>>>>>>>
>>>>>>> [osd.23]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.23
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.23/keyring
>>>>>>>
>>>>>>> [osd.24]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.24
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.24/keyring
>>>>>>>
>>>>>>> [osd.25]
>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.25
>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.25/keyring
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>
>>
>
>
>
> --
> -----
> Pozdrawiam
>
> S=B3awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron

--0015175cd2a8e7b25304b473b93d
Content-Type: text/plain; charset=US-ASCII; name="ceph_mon_log.txt"
Content-Disposition: attachment; filename="ceph_mon_log.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gwdmtcqi0

MjAxMS0xMi0xOSAxNjoxNjoxMy40MzQ0MDggN2Y5MDRmMzJiNzAwIG1vbi4wQDAobGVhZGVyKSBl
MSBtc192ZXJpZnlfYXV0aG9yaXplciAxMC4xNzcuMzIuNjY6MC8xMzAxNDM5MSBjbGllbnQgcHJv
dG9jb2wgMA0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzQ3OTcgN2Y5MDU0MjZjNzAwIC0tIDEwLjE3
Ny42NC40OjY3ODkvMCA8PT0gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTEgMSA9PT09
IGF1dGgocHJvdG8gMCAzMCBieXRlcykgdjEgPT09PSA1NiswKzAgKDYyNTU0MDI4OSAwIDApIDB4
MTFmYzAwMCBjb24gMHhjZDcyODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM0ODE0IDdmOTA1NDI2
YzcwMCBtb24uMEAwKGxlYWRlcikgZTEgaGF2ZSBjb25uZWN0aW9uDQoyMDExLTEyLTE5IDE2OjE2
OjEzLjQzNDgyMSA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIGRvIG5vdCBoYXZlIHNl
c3Npb24sIG1ha2luZyBuZXcgb25lDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNDgzMyA3ZjkwNTQy
NmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIG1zX2Rpc3BhdGNoIG5ldyBzZXNzaW9uIE1vblNlc3Np
b246IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIGlzIG9wZW4gZm9yIGNsaWVudC4/
IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNDgzOCA3Zjkw
NTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIHNldHRpbmcgdGltZW91dCBvbiBzZXNzaW9uDQoy
MDExLTEyLTE5IDE2OjE2OjEzLjQzNDg0NCA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUx
ICBjYXBzDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNDg1MiA3ZjkwNTQyNmM3MDAgbW9uLjBAMChs
ZWFkZXIpLmF1dGggdjYyNiB1cGRhdGVfZnJvbV9wYXhvcygpDQoyMDExLTEyLTE5IDE2OjE2OjEz
LjQzNDg2MSA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjYyNiBwcmVwcm9jZXNz
X3F1ZXJ5IGF1dGgocHJvdG8gMCAzMCBieXRlcykgdjEgZnJvbSBjbGllbnQuPyAxMC4xNzcuMzIu
NjY6MC8xMzAxNDM5MQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzQ4NjcgN2Y5MDU0MjZjNzAwIG1v
bi4wQDAobGVhZGVyKS5hdXRoIHY2MjYgcHJlcF9hdXRoKCkgYmxvYl9zaXplPTMwDQoyMDExLTEy
LTE5IDE2OjE2OjEzLjQzNDg5MCA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjYy
NiBBdXRoTW9uaXRvcjo6YXNzaWduX2dsb2JhbF9pZCBtPWF1dGgocHJvdG8gMCAzMCBieXRlcykg
djEgbW9uPTAvMSBsYXN0X2FsbG9jYXRlZD02MjUyIG1heF9nbG9iYWxfaWQ9NjI5Ng0KMjAxMS0x
Mi0xOSAxNjoxNjoxMy40MzQ4OTYgN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVhZGVyKS5hdXRoIHY2
MjYgbmV4dF9nbG9iYWxfaWQgc2hvdWxkIGJlIDYyNTMNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM0
OTM2IDdmOTA1NDI2YzcwMCBjZXBoeCBzZXJ2ZXIgY2xpZW50LmFkbWluOiBzdGFydF9zZXNzaW9u
IHNlcnZlcl9jaGFsbGVuZ2UgNTQzYTQyNDUxOTIzYjRjZg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40
MzQ5NjMgN2Y5MDU0MjZjNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4gMTAuMTc3LjMyLjY2
OjAvMTMwMTQzOTEgLS0gYXV0aF9yZXBseShwcm90byAyIDAgU3VjY2VzcykgdjEgLS0gPyswIDB4
MTliNGEwMCBjb24gMHhjZDcyODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM1NjUxIDdmOTA1NDI2
YzcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgPD09IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEz
MDE0MzkxIDIgPT09PSBhdXRoKHByb3RvIDIgMzIgYnl0ZXMpIHYxID09PT0gNTgrMCswICgyMDkx
NjgxMDEzIDAgMCkgMHhkOWMyMDAgY29uIDB4Y2Q3MjgwDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQz
NTY2NyA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIGhhdmUgY29ubmVjdGlvbg0KMjAx
MS0xMi0xOSAxNjoxNjoxMy40MzU2NzggN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBt
c19kaXNwYXRjaCBleGlzdGluZyBzZXNzaW9uIE1vblNlc3Npb246IGNsaWVudC4/IDEwLjE3Ny4z
Mi42NjowLzEzMDE0MzkxIGlzIG9wZW4gZm9yIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0
MzkxDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNTY4NCA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFk
ZXIpIGUxICBjYXBzDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNTY5MSA3ZjkwNTQyNmM3MDAgbW9u
LjBAMChsZWFkZXIpLmF1dGggdjYyNiB1cGRhdGVfZnJvbV9wYXhvcygpDQoyMDExLTEyLTE5IDE2
OjE2OjEzLjQzNTcwMCA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpLmF1dGggdjYyNiBwcmVw
cm9jZXNzX3F1ZXJ5IGF1dGgocHJvdG8gMiAzMiBieXRlcykgdjEgZnJvbSBjbGllbnQuPyAxMC4x
NzcuMzIuNjY6MC8xMzAxNDM5MQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU3MDYgN2Y5MDU0MjZj
NzAwIG1vbi4wQDAobGVhZGVyKS5hdXRoIHY2MjYgcHJlcF9hdXRoKCkgYmxvYl9zaXplPTMyDQoy
MDExLTEyLTE5IDE2OjE2OjEzLjQzNTcxMiA3ZjkwNTQyNmM3MDAgY2VwaHggc2VydmVyIGNsaWVu
dC5hZG1pbjogaGFuZGxlX3JlcXVlc3QgZ2V0X2F1dGhfc2Vzc2lvbl9rZXkgZm9yIGNsaWVudC5h
ZG1pbg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU3NTcgN2Y5MDU0MjZjNzAwIGNlcGh4IHNlcnZl
ciBjbGllbnQuYWRtaW46ICBjaGVja2luZyBrZXk6IHJlcS5rZXk9ZTg0NTY2NDQ2Mzc1NzAwZSBl
eHBlY3RlZF9rZXk9ZTg0NTY2NDQ2Mzc1NzAwZQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU3OTYg
N2Y5MDU0MjZjNzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6IGdldF9zZXJ2aWNlX3NlY3JldCBzZXJ2
aWNlIGF1dGggaWQgNDYgQVFCZWVlNU9nQlRYQnhBQU9XNVR6anJzM21JelZyWjhOK2xmc2c9PSBl
eHBpcmVzIDIwMTEtMTItMjAgMDA6Mzg6MDYuMTMxNTAwDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQz
NTgxMSA3ZjkwNTQyNmM3MDAgY2VwaHg6IGJ1aWxkX3NlcnZpY2VfdGlja2V0X3JlcGx5IGVuY29k
aW5nIDEgdGlja2V0cyB3aXRoIHNlY3JldCBBUUFOZU5GT2lJeDlEaEFBdjc2TVJYWmpXTktuMnNT
U1RRZUpvZz09DQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNTgzMSA3ZjkwNTQyNmM3MDAgY2VwaHg6
IGJ1aWxkX3NlcnZpY2VfdGlja2V0IHNlcnZpY2UgYXV0aCBzZWNyZXRfaWQgNDYgdGlja2V0X2lu
Zm8udGlja2V0Lm5hbWU9Y2xpZW50LmFkbWluDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNTg1NCA3
ZjkwNTQyNmM3MDAgY2VwaHg6IHNlcnZpY2VfdGlja2V0X2Jsb2IgaXMgMDAwMCA6IDAxIDJlIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDYwIDAwIDAwIDAwIDE5IDg2IGE5IDogLi4uLi4uLi4uYC4uLi4u
Lg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU4NjMgMDEwIDogZGMgZDYgNTUgZWYgNWIgOGQgZDUg
NTQgMTcgNjggMGMgODIgYzIgZGUgNTcgZTQgOiAuLlUuWy4uVC5oLi4uLlcuDQoyMDExLTEyLTE5
IDE2OjE2OjEzLjQzNTg3MSAwMjAgOiA3OCAyMSBmMyBkMCA3MSBlZiBhMyAxNyBjNiBmNSA4OCAy
NCBlMSAwYiBmOSBlYSA6IHghLi5xLi4uLi4uJC4uLi4NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM1
ODc4IDAzMCA6IDc5IGM1IGIyIGJlIDM2IGQzIDY3IDA5IDc2IGUxIDg4IDQ3IDc1IGRhIGVjIDRm
IDogeS4uLjYuZy52Li5HdS4uTw0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU4ODYgMDQwIDogYWUg
NzUgZjEgYjQgMjQgMzMgYTIgZmMgZjcgZjkgZmQgMjAgYTIgZDUgZjQgNWEgOiAudS4uJDMuLi4u
LiAuLi5aDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNTg5NCAwNTAgOiAxYyA1NiAwMyA0MyA5YiAx
YiAzNiBhZiBkNyAxZSA5OSA3NiAyMiA2MyA4MyA5OSA6IC5WLkMuLjYuLi4udiJjLi4NCjIwMTEt
MTItMTkgMTY6MTY6MTMuNDM1OTAxIDA2MCA6IGFjIGFmIGE0IDljIDA5IDY3IDA5IGE0IDgyIDdl
IDA2IGM0IDZiICAgICAgICAgIDogLi4uLi5nLi4ufi4uaw0KMjAxMS0xMi0xOSAxNjoxNjoxMy40
MzU5MDUgMjAxMS0xMi0xOSAxNjoxNjoxMy40MzU5MTIgN2Y5MDU0MjZjNzAwIGNlcGh4IGtleXNl
cnZlcmRhdGE6IGdldF9jYXBzOiBuYW1lPWNsaWVudC5hZG1pbg0KMjAxMS0xMi0xOSAxNjoxNjox
My40MzU5MTggN2Y5MDU0MjZjNzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6IGdldF9zZWNyZXQ6IG51
bSBvZiBjYXBzPTMNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM1OTQyIDdmOTA1NDI2YzcwMCAtLSAx
MC4xNzcuNjQuNDo2Nzg5LzAgLS0+IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIC0tIGF1dGhfcmVw
bHkocHJvdG8gMiAwIFN1Y2Nlc3MpIHYxIC0tID8rMCAweDExZmMwMDAgY29uIDB4Y2Q3MjgwDQoy
MDExLTEyLTE5IDE2OjE2OjEzLjQzNjY5OSA3ZjkwNTQyNmM3MDAgLS0gMTAuMTc3LjY0LjQ6Njc4
OS8wIDw9PSBjbGllbnQuPyAxMC4xNzcuMzIuNjY6MC8xMzAxNDM5MSAzID09PT0gYXV0aChwcm90
byAyIDE2NSBieXRlcykgdjEgPT09PSAxOTErMCswICgxMTQ2OTk1MzkxIDAgMCkgMHgxMWY4ODAw
IGNvbiAweGNkNzI4MA0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzY3MTUgN2Y5MDU0MjZjNzAwIG1v
bi4wQDAobGVhZGVyKSBlMSBoYXZlIGNvbm5lY3Rpb24NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2
NzI3IDdmOTA1NDI2YzcwMCBtb24uMEAwKGxlYWRlcikgZTEgbXNfZGlzcGF0Y2ggZXhpc3Rpbmcg
c2Vzc2lvbiBNb25TZXNzaW9uOiBjbGllbnQuPyAxMC4xNzcuMzIuNjY6MC8xMzAxNDM5MSBpcyBv
cGVuYWxsb3cgKiBmb3IgY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTENCjIwMTEtMTIt
MTkgMTY6MTY6MTMuNDM2NzMzIDdmOTA1NDI2YzcwMCBtb24uMEAwKGxlYWRlcikgZTEgIGNhcHMg
YWxsb3cgKg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzY3MzkgN2Y5MDU0MjZjNzAwIG1vbi4wQDAo
bGVhZGVyKS5hdXRoIHY2MjYgdXBkYXRlX2Zyb21fcGF4b3MoKQ0KMjAxMS0xMi0xOSAxNjoxNjox
My40MzY3NDggN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVhZGVyKS5hdXRoIHY2MjYgcHJlcHJvY2Vz
c19xdWVyeSBhdXRoKHByb3RvIDIgMTY1IGJ5dGVzKSB2MSBmcm9tIGNsaWVudC4/IDEwLjE3Ny4z
Mi42NjowLzEzMDE0MzkxDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNjc1NCA3ZjkwNTQyNmM3MDAg
bW9uLjBAMChsZWFkZXIpLmF1dGggdjYyNiBwcmVwX2F1dGgoKSBibG9iX3NpemU9MTY1DQoyMDEx
LTEyLTE5IDE2OjE2OjEzLjQzNjc2MCA3ZjkwNTQyNmM3MDAgY2VwaHggc2VydmVyIGNsaWVudC5h
ZG1pbjogaGFuZGxlX3JlcXVlc3QgZ2V0X3ByaW5jaXBhbF9zZXNzaW9uX2tleQ0KMjAxMS0xMi0x
OSAxNjoxNjoxMy40MzY3NjcgN2Y5MDU0MjZjNzAwIGNlcGh4OiB2ZXJpZnlfYXV0aG9yaXplciBk
ZWNyeXB0ZWQgc2VydmljZSBhdXRoIHNlY3JldF9pZD00Ng0KMjAxMS0xMi0xOSAxNjoxNjoxMy40
MzY4MDIgN2Y5MDU0MjZjNzAwIGNlcGh4OiB2ZXJpZnlfYXV0aG9yaXplciBnbG9iYWxfaWQ9NjI1
Mw0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzY4MjggN2Y5MDU0MjZjNzAwIGNlcGh4OiB2ZXJpZnlf
YXV0aG9yaXplciBvayBub25jZSA0NjdkYzFmZjcwY2ZiM2ExIHJlcGx5X2JsLmxlbmd0aCgpPTM2
DQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNjgzNiA3ZjkwNTQyNmM3MDAgY2VwaHggc2VydmVyIGNs
aWVudC5hZG1pbjogIHRpY2tldF9yZXEua2V5cyA9IDUNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2
ODQxIDdmOTA1NDI2YzcwMCBjZXBoeCBzZXJ2ZXIgY2xpZW50LmFkbWluOiAgYWRkaW5nIGtleSBm
b3Igc2VydmljZSBtb24NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2ODU1IDdmOTA1NDI2YzcwMCBj
ZXBoeCBrZXlzZXJ2ZXJkYXRhOiBnZXRfc2VydmljZV9zZWNyZXQgc2VydmljZSBtb24gaWQgNTQ0
IEFRQWhQKzlPMEJheEt4QUFCeVNrUzV1QVdQbTZmL2xGT2hLUWhBPT0gZXhwaXJlcyAyMDExLTEy
LTE5IDE2OjQxOjUzLjczMjk5MQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzY4NzkgN2Y5MDU0MjZj
NzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6IGdldF9jYXBzOiBuYW1lPWNsaWVudC5hZG1pbg0KMjAx
MS0xMi0xOSAxNjoxNjoxMy40MzY4ODYgN2Y5MDU0MjZjNzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6
IGdldF9zZWNyZXQ6IG51bSBvZiBjYXBzPTMNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2ODkzIDdm
OTA1NDI2YzcwMCBjZXBoeCBzZXJ2ZXIgY2xpZW50LmFkbWluOiAgYWRkaW5nIGtleSBmb3Igc2Vy
dmljZSBvc2QNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2OTA1IDdmOTA1NDI2YzcwMCBjZXBoeCBr
ZXlzZXJ2ZXJkYXRhOiBnZXRfc2VydmljZV9zZWNyZXQgc2VydmljZSBvc2QgaWQgNTQ0IEFRQWhQ
KzlPNExxeEt4QUF3Q1VBY09tc1N2cWprZEJOamZPNHNBPT0gZXhwaXJlcyAyMDExLTEyLTE5IDE2
OjQxOjUzLjczMzA0Nw0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzY5MjIgN2Y5MDU0MjZjNzAwIGNl
cGh4IGtleXNlcnZlcmRhdGE6IGdldF9jYXBzOiBuYW1lPWNsaWVudC5hZG1pbg0KMjAxMS0xMi0x
OSAxNjoxNjoxMy40MzY5MjggN2Y5MDU0MjZjNzAwIGNlcGh4IGtleXNlcnZlcmRhdGE6IGdldF9z
ZWNyZXQ6IG51bSBvZiBjYXBzPTMNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2OTQxIDdmOTA1NDI2
YzcwMCBjZXBoeDogYnVpbGRfc2VydmljZV90aWNrZXRfcmVwbHkgZW5jb2RpbmcgMiB0aWNrZXRz
IHdpdGggc2VjcmV0IEFRQTlWZTlPUUluNUdSQUFrd0d1RjRHZjJFT09YQ1ZxUjFQcW5BPT0NCjIw
MTEtMTItMTkgMTY6MTY6MTMuNDM2OTYwIDdmOTA1NDI2YzcwMCBjZXBoeDogYnVpbGRfc2Vydmlj
ZV90aWNrZXQgc2VydmljZSBtb24gc2VjcmV0X2lkIDU0NCB0aWNrZXRfaW5mby50aWNrZXQubmFt
ZT1jbGllbnQuYWRtaW4NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM2OTgyIDdmOTA1NDI2YzcwMCBj
ZXBoeDogc2VydmljZV90aWNrZXRfYmxvYiBpcyAwMDAwIDogMDEgMjAgMDIgMDAgMDAgMDAgMDAg
MDAgMDAgNzAgMDAgMDAgMDAgMWUgNjMgMjggOiAuIC4uLi4uLi5wLi4uLmMoDQoyMDExLTEyLTE5
IDE2OjE2OjEzLjQzNjk5MiAwMTAgOiBlYiBiNSBjZCA4ZSA3ZCA0YSAzMyAzMyBkNiBiMCA2OSAz
MSBkYyA2MCBhOCA2MSA6IC4uLi59SjMzLi5pMS5gLmENCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3
MDAwIDAyMCA6IDU0IDIzIDU1IDE3IDZmIDBhIDg2IDU0IGYxIDE3IDY0IGM5IDk5IDVkIDgxIDgw
IDogVCNVLm8uLlQuLmQuLl0uLg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzcwMDggMDMwIDogMmMg
ODUgODMgZGMgZDEgZmUgNDQgMWQgMGYgZjAgYWEgYzIgOWUgYjYgZmIgMGIgOiAsLi4uLi5ELi4u
Li4uLi4uDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNzAxNSAwNDAgOiAwMiA1MiA2OSAzZSBjYyBi
OCAyOSAyNCA5MyA2YSBhMSA4YyA3ZCBiOCA5OCAyOCA6IC5SaT4uLikkLmouLn0uLigNCjIwMTEt
MTItMTkgMTY6MTY6MTMuNDM3MDIzIDA1MCA6IGRjIDIwIGUzIDI0IDNhIDA2IGM1IGI0IDhiIGEz
IDg0IDljIDU0IDhiIDZjIGZmIDogLiAuJDouLi4uLi4uVC5sLg0KMjAxMS0xMi0xOSAxNjoxNjox
My40MzcwMzAgMDYwIDogOTAgZTIgYTEgNzMgNGYgN2IgN2YgMzAgYmEgMmIgY2EgMjAgODkgOTYg
NTcgMjIgOiAuLi5zT3suMC4rLiAuLlciDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNzAzNyAwNzAg
OiA4NyBhYiBjZSBhMSBkZiA2NyBiOSA2MCA5OSA5NyBiMiBlNCAwNSAgICAgICAgICA6IC4uLi4u
Zy5gLi4uLi4NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3MDQxIDIwMTEtMTItMTkgMTY6MTY6MTMu
NDM3MDU3IDdmOTA1NDI2YzcwMCBjZXBoeDogYnVpbGRfc2VydmljZV90aWNrZXQgc2VydmljZSBv
c2Qgc2VjcmV0X2lkIDU0NCB0aWNrZXRfaW5mby50aWNrZXQubmFtZT1jbGllbnQuYWRtaW4NCjIw
MTEtMTItMTkgMTY6MTY6MTMuNDM3MDc4IDdmOTA1NDI2YzcwMCBjZXBoeDogc2VydmljZV90aWNr
ZXRfYmxvYiBpcyAwMDAwIDogMDEgMjAgMDIgMDAgMDAgMDAgMDAgMDAgMDAgNzAgMDAgMDAgMDAg
MWUgN2QgOGYgOiAuIC4uLi4uLi5wLi4uLn0uDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNzA4NyAw
MTAgOiAyNSA3NSA1NSA4YSAwOCBkYSAxZSBhMSAyYyAxNiA2MiBhYiBlYSAxOSAzMCA0MCA6ICV1
VS4uLi4uLC5iLi4uMEANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3MDk1IDAyMCA6IDJlIGE5IDJk
IDFiIDgzIDE0IGM0IDIxIGU1IGY4IDVhIDVkIDVjIGYzIDJjIDJkIDogLi4tLi4uLiEuLlpdXC4s
LQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzcxMDIgMDMwIDogYTcgNmEgZWEgMzcgYzkgZDEgNTMg
ZGIgYTAgMDIgYjQgZGYgNDMgZjUgZTAgZGQgOiAuai43Li5TLi4uLi5DLi4uDQoyMDExLTEyLTE5
IDE2OjE2OjEzLjQzNzExMCAwNDAgOiAyOSBkNiAwMSBjZiA3OCBmZSA1ZSAyZiBhNyBmOSAzZCAw
NyBhZSBmYiAwOCAxYSA6ICkuLi54Ll4vLi49Li4uLi4NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3
MTI1IDA1MCA6IDRiIDM4IDdlIGRhIDk4IDgxIDE0IDA3IDA1IGQzIGYzIDAxIGM5IGNhIDE1IDZm
IDogSzh+Li4uLi4uLi4uLi4ubw0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzcxMzMgMDYwIDogYmIg
YWUgYmQgYTEgN2UgNzYgNzAgMGYgYjcgZTYgNDIgNWQgNjQgMDMgMGYgNmIgOiAuLi4ufnZwLi4u
Ql1kLi5rDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNzE0MCAwNzAgOiAwYiAyOCA3YSBmMyA2MiBj
MyBlNyA5MSA3ZiBlNSAzMyAxNSA1ZiAgICAgICAgICA6IC4oei5iLi4uLi4zLl8NCjIwMTEtMTIt
MTkgMTY6MTY6MTMuNDM3MTQ0IDIwMTEtMTItMTkgMTY6MTY6MTMuNDM3MTYzIDdmOTA1NDI2Yzcw
MCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIC0tIGF1
dGhfcmVwbHkocHJvdG8gMiAwIFN1Y2Nlc3MpIHYxIC0tID8rMCAweGQ5YzIwMCBjb24gMHhjZDcy
ODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3NzUwIDdmOTA1NDI2YzcwMCAtLSAxMC4xNzcuNjQu
NDo2Nzg5LzAgPD09IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIDQgPT09PSBtb25f
c3Vic2NyaWJlKHttb25tYXA9MCt9KSB2MiA9PT09IDIzKzArMCAoMTYyMDU5MzM1NCAwIDApIDB4
MTI4ZWE4MCBjb24gMHhjZDcyODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3NzY4IDdmOTA1NDI2
YzcwMCBtb24uMEAwKGxlYWRlcikgZTEgaGF2ZSBjb25uZWN0aW9uDQoyMDExLTEyLTE5IDE2OjE2
OjEzLjQzNzc4NiA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIG1zX2Rpc3BhdGNoIGV4
aXN0aW5nIHNlc3Npb24gTW9uU2Vzc2lvbjogY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQz
OTEgaXMgb3BlbmFsbG93ICogZm9yIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxDQoy
MDExLTEyLTE5IDE2OjE2OjEzLjQzNzc5NiA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUx
ICBjYXBzIGFsbG93ICoNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3ODM3IDdmOTA1NDI2YzcwMCBt
b24uMEAwKGxlYWRlcikgZTEgaGFuZGxlX3N1YnNjcmliZSBtb25fc3Vic2NyaWJlKHttb25tYXA9
MCt9KSB2Mg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40Mzc4NTIgN2Y5MDU0MjZjNzAwIG1vbi4wQDAo
bGVhZGVyKSBlMSBjaGVja19zdWIgbW9ubWFwIG5leHQgMCBoYXZlIDENCjIwMTEtMTItMTkgMTY6
MTY6MTMuNDM3ODc1IDdmOTA1NDI2YzcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IDEwLjE3
Ny4zMi42NjowLzEzMDE0MzkxIC0tIG1vbl9tYXAgdjEgLS0gPyswIDB4ZWE1YTgwIGNvbiAweGNk
NzI4MA0KMjAxMS0xMi0xOSAxNjoxNjoxMy40Mzc4OTkgN2Y5MDU0MjZjNzAwIC0tIDEwLjE3Ny42
NC40OjY3ODkvMCAtLT4gY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTEgLS0gbW9uX3N1
YnNjcmliZV9hY2soMzAwcykgdjEgLS0gPyswIDB4ZDQ4NjAwDQoyMDExLTEyLTE5IDE2OjE2OjEz
LjQzNzkxOSA3ZjkwNTQyNmM3MDAgLS0gMTAuMTc3LjY0LjQ6Njc4OS8wIDw9PSBjbGllbnQuNjI1
MyAxMC4xNzcuMzIuNjY6MC8xMzAxNDM5MSA1ID09PT0gbW9uX3N1YnNjcmliZSh7bW9ubWFwPTAr
LG9zZG1hcD0wfSkgdjIgPT09PSA0MiswKzAgKDk4MjU4MzcxMyAwIDApIDB4MTRmZDcwMCBjb24g
MHhjZDcyODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3OTI2IDdmOTA1NDI2YzcwMCBtb24uMEAw
KGxlYWRlcikgZTEgaGF2ZSBjb25uZWN0aW9uDQoyMDExLTEyLTE5IDE2OjE2OjEzLjQzNzkzNyA3
ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIG1zX2Rpc3BhdGNoIGV4aXN0aW5nIHNlc3Np
b24gTW9uU2Vzc2lvbjogY2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTEgaXMgb3BlbmFs
bG93ICogZm9yIGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxDQoyMDExLTEyLTE5IDE2
OjE2OjEzLjQzNzk0MiA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxICBjYXBzIGFsbG93
ICoNCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM3OTQ5IDdmOTA1NDI2YzcwMCBtb24uMEAwKGxlYWRl
cikgZTEgaGFuZGxlX3N1YnNjcmliZSBtb25fc3Vic2NyaWJlKHttb25tYXA9MCssb3NkbWFwPTB9
KSB2Mg0KMjAxMS0xMi0xOSAxNjoxNjoxMy40Mzc5NTcgN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVh
ZGVyKSBlMSBjaGVja19zdWIgbW9ubWFwIG5leHQgMCBoYXZlIDENCjIwMTEtMTItMTkgMTY6MTY6
MTMuNDM3OTY5IDdmOTA1NDI2YzcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IDEwLjE3Ny4z
Mi42NjowLzEzMDE0MzkxIC0tIG1vbl9tYXAgdjEgLS0gPyswIDB4MTI4ZWE4MCBjb24gMHhjZDcy
ODANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM4MDUyIDdmOTA1NDI2YzcwMCAtLSAxMC4xNzcuNjQu
NDo2Nzg5LzAgLS0+IGNsaWVudC4/IDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIC0tIG9zZF9tYXAo
NDYxLi40NjEgc3JjIGhhcyAxLi40NjEpIHYxIC0tID8rMCAweDExZjg4MDANCjIwMTEtMTItMTkg
MTY6MTY6MTMuNDM4MDY3IDdmOTA1NDI2YzcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgLS0+IGNs
aWVudC42MjUzIDEwLjE3Ny4zMi42NjowLzEzMDE0MzkxIC0tIG1vbl9zdWJzY3JpYmVfYWNrKDMw
MHMpIHYxIC0tID8rMCAweDE4NTEwMDANCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM4MDgzIDdmOTA1
NDI2YzcwMCAtLSAxMC4xNzcuNjQuNDo2Nzg5LzAgPD09IGNsaWVudC42MjUzIDEwLjE3Ny4zMi42
NjowLzEzMDE0MzkxIDYgPT09PSBtb25fc3Vic2NyaWJlKHttb25tYXA9MCssb3NkbWFwPTB9KSB2
MiA9PT09IDQyKzArMCAoOTgyNTgzNzEzIDAgMCkgMHgxNGZkOGMwIGNvbiAweGNkNzI4MA0KMjAx
MS0xMi0xOSAxNjoxNjoxMy40MzgwOTEgN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBo
YXZlIGNvbm5lY3Rpb24NCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM4MTAwIDdmOTA1NDI2YzcwMCBt
b24uMEAwKGxlYWRlcikgZTEgbXNfZGlzcGF0Y2ggZXhpc3Rpbmcgc2Vzc2lvbiBNb25TZXNzaW9u
OiBjbGllbnQuPyAxMC4xNzcuMzIuNjY6MC8xMzAxNDM5MSBpcyBvcGVuYWxsb3cgKiBmb3IgY2xp
ZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTENCjIwMTEtMTItMTkgMTY6MTY6MTMuNDM4MTA2
IDdmOTA1NDI2YzcwMCBtb24uMEAwKGxlYWRlcikgZTEgIGNhcHMgYWxsb3cgKg0KMjAxMS0xMi0x
OSAxNjoxNjoxMy40MzgxMTMgN2Y5MDU0MjZjNzAwIG1vbi4wQDAobGVhZGVyKSBlMSBoYW5kbGVf
c3Vic2NyaWJlIG1vbl9zdWJzY3JpYmUoe21vbm1hcD0wKyxvc2RtYXA9MH0pIHYyDQoyMDExLTEy
LTE5IDE2OjE2OjEzLjQzODEyMCA3ZjkwNTQyNmM3MDAgbW9uLjBAMChsZWFkZXIpIGUxIGNoZWNr
X3N1YiBtb25tYXAgbmV4dCAwIGhhdmUgMQ0KMjAxMS0xMi0xOSAxNjoxNjoxMy40MzgxMzIgN2Y5
MDU0MjZjNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4gMTAuMTc3LjMyLjY2OjAvMTMwMTQz
OTEgLS0gbW9uX21hcCB2MSAtLSA/KzAgMHgxNGZkNzAwIGNvbiAweGNkNzI4MA0KMjAxMS0xMi0x
OSAxNjoxNjoxMy40MzgyMzQgN2Y5MDU0MjZjNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4g
Y2xpZW50Lj8gMTAuMTc3LjMyLjY2OjAvMTMwMTQzOTEgLS0gb3NkX21hcCg0NjEuLjQ2MSBzcmMg
aGFzIDEuLjQ2MSkgdjEgLS0gPyswIDB4MTliNDIwMA0KMjAxMS0xMi0xOSAxNjoxNjoxMy40Mzgy
NTggN2Y5MDU0MjZjNzAwIC0tIDEwLjE3Ny42NC40OjY3ODkvMCAtLT4gY2xpZW50LjYyNTMgMTAu
MTc3LjMyLjY2OjAvMTMwMTQzOTEgLS0gbW9uX3N1YnNjcmliZV9hY2soMzAwcykgdjEgLS0gPysw
IDB4ZGE3NzgwDQoyMDExLTEyLTE5IDE2OjE2OjEzLjY0OTI0NyA3ZjkwNTQyNmM3MDAgLS0gMTAu
MTc3LjY0LjQ6Njc4OS8wIDw9PSBvc2QuMjUgMTAuMTc3LjY0LjQ6Njg1MS81MTcwIDE2MiA9PT09
IHBnX3N0YXRzKDAgcGdzIHRpZCA3MiB2IDQ2MSkgdjEgPT09PSAyNzUrMCswICgxMTAzODI5NTYw
IDAgMCkgMHhkODlkODAgY29uIDB4Y2Q0ZGMwDQo=
--0015175cd2a8e7b25304b473b93d--
