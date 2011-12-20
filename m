From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Problem with attaching rbd device in qemu-kvm
Date: Tue, 20 Dec 2011 10:38:21 +0100
Message-ID: <CAMwB3Tgc4VjkOm8U3v75B_0dSP-2m9LSehXn3bTXO4cEyqOn9g@mail.gmail.com>
References: <CAMwB3ThP55_KV4CQ1Yd=goqSDxug79vnznq3pqjFVQcbap1nWw@mail.gmail.com>
	<4ED7E69D.7070909@dreamhost.com>
	<CAMwB3TgS0XuhqPEh5kTdJsNf1BP=2uOXUex4izTZhfbLbT9FNQ@mail.gmail.com>
	<4EE64DC2.9090206@dreamhost.com>
	<CAMwB3Th9ycRbMmsGon0SCFEy9yeMQ-nE5dJ=NfntwxhXFyatpw@mail.gmail.com>
	<4EE7B0A5.6000906@dreamhost.com>
	<CAMwB3Tir5aotsbauoztfS3yb0hdMjrXXsNwCmLAYVMr9iSoruQ@mail.gmail.com>
	<CAMwB3Tg6z8qmAX3Bnmh68ZK_ddjFP8y7keFQE32Lz0H7eLPG6g@mail.gmail.com>
	<4EEFF5D4.9060307@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64439 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1LTJiX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 04:38:23 -0500
Received: by wgbdr13 with SMTP id dr13so12182171wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 01:38:21 -0800 (PST)
In-Reply-To: <4EEFF5D4.9060307@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Ehhh too long with this :) I forget to load acpiphp.

Thanks for everything, now its working beautifully. After 10h of
iozone on rbd devices, and no hang, or problem.

2011/12/20 Josh Durgin <josh.durgin@dreamhost.com>:
> On 12/19/2011 07:37 AM, S=B3awomir Skowron wrote:
>>
>> Hi,
>>
>> Actual setup:
>>
>> ii =A0libvirt-bin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.9.2-4=
ubuntu15.1
>> =A0 =A0 =A0 the programs for the libvirt library
>> ii =A0libvirt0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.9.2=
-4ubuntu15.1
>> =A0 =A0 =A0 library for interfacing with different virtualization sy=
stems
>> ii =A0qemu-kvm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.0.0=
+dfsg+rc2-1~oneiric1
>> =A0 =A0 =A0 Full virtualization on i386 and amd64 hardware
>>
>> I change many thing in system, and successfully attached rbd drives =
via
>> libvirt:
>>
>> virsh attach-device one-888 kvm-ceph.xml
>> Device attached successfully
>>
>> A new set of disks, appears in libvirt vm xml, but not in vm machine=
=2E
>> After reboot, all new rbd drives appear in VM.
>>
>> Is there any chance to hotadd rbd device to working VM without reboo=
t ??
>
>
> Hotplugging should work, but it does require guest support. Does your=
 guest
> kernel have hotplugging enabled? Does hotplugging work with a raw ima=
ge file
> using the same configuration?
>
>
>>
>> 2011/12/16 S=B3awomir Skowron<szibis@gmail.com>:
>>>
>>> 2011/12/13 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>
>>>> On 12/13/2011 04:56 AM, S=B3awomir Skowron wrote:
>>>>>
>>>>>
>>>>> Finally, i manage the problem with rbd with kvm 1.0, and libvirt
>>>>> 0.9.8, or i think i manage :), but i get stuck with one thing aft=
er.
>>>>>
>>>>> 2011-12-13 12:13:31.173+0000: 21512: error :
>>>>> qemuMonitorJSONCheckError:318 : internal error unable to execute =
QEMU
>>>>> command 'device_add': Bus 'pci.0' does not support hotplugging
>>>>> 2011-12-13 12:13:31.173+0000: 21512: warning :
>>>>> qemuDomainAttachPciDiskDevice:244 : qemuMonitorAddDevice failed o=
n
>>>>>
>>>>>
>>>>> file=3Drbd:rbd/testdysk:id=3Dadmin:key=3DAQANeNFOiIx9DhAAv76MRXZj=
WNKn2sSSTQeJog=3D=3D:auth_supported=3Dcephx
>>>>>
>>>>> none:mon_host=3D10.177.64.4\:6789,if=3Dnone,id=3Ddrive-virtio-dis=
k2,format=3Draw
>>>>>
>>>>>
>>>>> (virtio-blk-pci,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk2=
,id=3Dvirtio-disk2)
>>>>> 2011-12-13 12:13:31.173+0000: 21512: error :
>>>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symli=
nk
>>>>> rbd/testdysk: No such file or directory2011-12-13 12:13:31.173+00=
00:
>>>>> 21512: warning : qemuDomainAttachPciDiskDevice:287 : Unable to re=
store
>>>>> security label on rbd/testdysk
>>>>> and i can't find any info about that.
>>>>>
>>>>> my kvm.xml inject file:
>>>>>
>>>>> <disk type=3D"network" device=3D"disk">
>>>>> =A0 =A0 =A0 =A0 =A0<driver name=3D"qemu" type=3D"raw"/>
>>>>> =A0 =A0 =A0 =A0 =A0<auth username=3D"admin">
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<secret type=3D"ceph"
>>>>> uuid=3D"0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f"/>
>>>>> =A0 =A0 =A0 =A0 =A0</auth>
>>>>> =A0 =A0 =A0 =A0 =A0<source protocol=3D"rbd" name=3D"rbd/testdysk"=
>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<host name=3D"10.177.64.4" por=
t=3D"6789"/>
>>>>> =A0 =A0 =A0 =A0 =A0</source>
>>>>> =A0 =A0 =A0 =A0 =A0<target dev=3D"sdc" bus=3D"virtio"/>
>>>>> </disk>
>>>>>
>>>>> secret:
>>>>>
>>>>> cat /tmp/secret.xml
>>>>> <secret ephemeral=3D'no' private=3D'no'>
>>>>> =A0 =A0 =A0<uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
>>>>> =A0 =A0 =A0<usage type=3D'ceph'>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0<domain>rbd/admin</domain>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0<name>admin</name>
>>>>> =A0 =A0 =A0</usage>
>>>>> </secret>
>>>>>
>>>>> virsh secret-define /tmp/secret.xml
>>>>> Secret 0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f created
>>>>>
>>>>> virsh secret-set-value 0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f
>>>>> AQANeNFOiIx9DhAAv76MRXZjWNKn2sSSTQeJog=3D=3D
>>>>> Secret value set
>>>>>
>>>>
>>>> Your xml and configuration are all fine, you're hitting the libvir=
t bug
>>>> that
>>>> I mentioned before. The fix isn't in any stable release yet, and 0=
=2E9.8
>>>> was
>>>> just released yesterday, so I guess you'll have to compile it your=
self
>>>> or
>>>> disable the libvirt security driver.
>>>
>>>
>>> Yes libvirt 0.9.8 with this patch solved problem with rbd, now it's
>>> clean. Thanks for that.
>>>
>>> But, a second problem appear.
>>>
>>> error: Failed to attach device from /root/kvm-ceph.xml
>>> error: internal error unable to execute QEMU command 'device_add':
>>> Property 'virtio-blk-pci.drive' can't find value 'drive-virtio-disk=
3'
>>>
>>> /var/log/libvirt/libvirtd.log
>>> 2011-12-16 12:03:04.950+0000: 1070: error :
>>> qemuMonitorJSONCheckError:318 : internal error unable to execute QE=
MU
>>> command 'device_add': Property 'virtio-blk-pci.drive' can't find va=
lue
>>> 'drive-virtio-disk3'
>>> 2011-12-16 12:03:04.950+0000: 1070: warning :
>>> qemuDomainAttachPciDiskDevice:244 : qemuMonitorAddDevice failed on
>>>
>>> file=3Drbd:rbd/testdysk:rbd_writeback_window=3D8000000:id=3Dadmin:k=
ey=3DAQANeNFOiIx9DhAAv76MRXZjWNKn2sSSTQeJog=3D=3D:auth_supported=3Dceph=
x
>>> none:mon_host=3D10.177.64.4\:6789,if=3Dnone,id=3Ddrive-virtio-disk3=
,format=3Draw
>>>
>>> (virtio-blk-pci,bus=3Dpci.0,addr=3D0xd,drive=3Ddrive-virtio-disk3,i=
d=3Dvirtio-disk3)
>>>
>>> if i attach a scsi device from img file everything is OK.
>>>
>>> Anyone have, any concept with this ??
>>>
>>>>
>>>>
>>>>> 2011/12/12 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>>>
>>>>>>
>>>>>> On 12/09/2011 04:48 AM, S=B3awomir Skowron wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Sorry, for my lag, but i was sick.
>>>>>>>
>>>>>>> I handled problem with apparmor before and now it's not a probl=
em,
>>>>>>> even when i send mail before, it was solved.
>>>>>>>
>>>>>>> Ok when i create image from qemu-img it's looks like that, and =
works
>>>>>>> perfect, (attachment with log of this opperation.)
>>>>>>>
>>>>>>> But when i use virsh, it's still a problem. Just like he don't =
know
>>>>>>> what user is going to be auth.
>>>>>>>
>>>>>>> I try, as client.admin (default i hope :)) only with id=3Dadmin=
 in
>>>>>>> kvm.xml, or client=3Dadmin, and other combinations - like clien=
t.rbd
>>>>>>> etc., Still nothing.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> admin is the default, and the correct option for client.admin is
>>>>>> id=3Dadmin,
>>>>>> or id=3Dfoo for client.foo.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> I try, improve a keyring file, adding client rbd into keyring o=
n
>>>>>>> machine with kvm hypervisor in /etc/ceph/keyring.bin
>>>>>>>
>>>>>>> [client.rbd]
>>>>>>> =A0 =A0 =A0 =A0 key =3D AAAAAAAAAAAAAAAA
>>>>>>> =A0 =A0 =A0 =A0 auid =3D 18446744073709551615
>>>>>>> =A0 =A0 =A0 =A0 caps mds =3D "allow"
>>>>>>> =A0 =A0 =A0 =A0 caps mon =3D "allow r"
>>>>>>> =A0 =A0 =A0 =A0 caps osd =3D "allow rw pool=3Dkvmtest"
>>>>>>>
>>>>>>> and on cluster site like above. I was added, a section [client.=
rbd]
>>>>>>> with keyring path, and it's still a problem.
>>>>>>>
>>>>>>
>>>>>> Did you run 'ceph auth add -i /etc/ceph/keyring.bin'?
>>>>>> Make sure 'ceph auth list' shows client.rbd with the right key.
>>>>>
>>>>>
>>>>>
>>>>> Overall i want to use admin id, and i think now it's correctly us=
ed in
>>>>> xml.
>>>>>
>>>>>>
>>>>>>
>>>>>>> 2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
>>>>>>> ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
>>>>>>> root@s3-10-177-64-4:~# tail -n10000 /var/log/ceph/mon.0.log | g=
rep
>>>>>>> 13:29:11.
>>>>>>> 2011-12-09 13:29:11.519096 7fe616b59700 mon.0@0(leader) e1
>>>>>>> ms_verify_authorizer 10.177.32.66:0/58020608 client protocol 0
>>>>>>> 2011-12-09 13:29:11.519624 7fe61b090700 -- 10.177.64.4:6789/0<=3D=
=3D
>>>>>>> client.? 10.177.32.66:0/58020608 1 =3D=3D=3D=3D auth(proto 0 21=
 bytes) v1
>>>>>>> =3D=3D=3D=3D
>>>>>>> 47+0+0 (3310669357 0 0) 0x17f2e00 con 0x19d2c80
>>>>>>> 2011-12-09 13:29:11.519645 7fe61b090700 mon.0@0(leader) e1 have
>>>>>>> connection
>>>>>>> 2011-12-09 13:29:11.519655 7fe61b090700 mon.0@0(leader) e1 do n=
ot
>>>>>>> have
>>>>>>> session, making new one
>>>>>>> 2011-12-09 13:29:11.519668 7fe61b090700 mon.0@0(leader) e1
>>>>>>> ms_dispatch
>>>>>>> new session MonSession: client.? 10.177.32.66:0/58020608 is ope=
n for
>>>>>>> client.? 10.177.32.66:0/58020608
>>>>>>> 2011-12-09 13:29:11.519674 7fe61b090700 mon.0@0(leader) e1 sett=
ing
>>>>>>> timeout on session
>>>>>>> 2011-12-09 13:29:11.519680 7fe61b090700 mon.0@0(leader) e1 =A0c=
aps
>>>>>>> 2011-12-09 13:29:11.519688 7fe61b090700 mon.0@0(leader).auth v3=
53
>>>>>>> AuthMonitor::update_from_paxos()
>>>>>>> 2011-12-09 13:29:11.519697 7fe61b090700 mon.0@0(leader).auth v3=
53
>>>>>>> preprocess_query auth(proto 0 21 bytes) v1 from client.?
>>>>>>> 10.177.32.66:0/58020608
>>>>>>> 2011-12-09 13:29:11.519703 7fe61b090700 mon.0@0(leader).auth v3=
53
>>>>>>> prep_auth() blob_size=3D21
>>>>>>> 2011-12-09 13:29:11.519735 7fe61b090700 -- 10.177.64.4:6789/0 -=
->
>>>>>>> 10.177.32.66:0/58020608 -- auth_reply(proto 0 -95 Operation not
>>>>>>> supported) v1 -- ?+0 0x1246200 con 0x19d2c80
>>>>>>>
>>>>>>> from libvirt.log
>>>>>>>
>>>>>>> 23:20:56.689: 1309: error :
>>>>>>> virSecurityDACRestoreSecurityFileLabel:143
>>>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No =
such
>>>>>>> file
>>>>>>> or directory
>>>>>>> 23:20:56.882: 1309: warning : qemuDomainAttachPciDiskDevice:250=
 :
>>>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:name=3D=
admin
>>>>>>> 23:21:09.172: 1309: error : qemuMonitorTextAddDrive:2418 : oper=
ation
>>>>>>> failed: open disk image file failed
>>>>>>> 23:21:09.172: 1309: error :
>>>>>>> virSecurityDACRestoreSecurityFileLabel:143
>>>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:name=3Dadmin: No =
such
>>>>>>> file
>>>>>>> or directory
>>>>>>> 23:21:09.364: 1309: warning : qemuDomainAttachPciDiskDevice:250=
 :
>>>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:name=3D=
admin
>>>>>>> 23:21:49.645: 1309: error : qemuMonitorTextAddDrive:2418 : oper=
ation
>>>>>>> failed: open disk image file failed
>>>>>>> 23:21:49.645: 1309: error :
>>>>>>> virSecurityDACRestoreSecurityFileLabel:143
>>>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1:id=3Dadmin: No su=
ch file
>>>>>>> or directory
>>>>>>> 23:21:49.853: 1309: warning : qemuDomainAttachPciDiskDevice:250=
 :
>>>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1:id=3Da=
dmin
>>>>>>> 13:08:08.924: 1309: error : qemuMonitorTextAddDrive:2418 : oper=
ation
>>>>>>> failed: open disk image file failed
>>>>>>> 13:08:08.924: 1309: error :
>>>>>>> virSecurityDACRestoreSecurityFileLabel:143
>>>>>>> : cannot resolve symlink rbd:kvmtest/kvmtest1: No such file or
>>>>>>> directory
>>>>>>> 13:08:09.117: 1309: warning : qemuDomainAttachPciDiskDevice:250=
 :
>>>>>>> Unable to restore security label on rbd:kvmtest/kvmtest1
>>>>>>> 13:09:45.402: 1309: error : qemuMonitorTextAddDrive:2418 : oper=
ation
>>>>>>> failed: open disk image file failed
>>>>>>> 13:29:05.554: 1310: error : qemuMonitorTextAddDrive:2418 : oper=
ation
>>>>>>> failed: open disk image file failed
>>>>>>> 13:29:05.554: 1310: error :
>>>>>>> virSecurityDACRestoreSecurityFileLabel:143
>>>>>>> : cannot resolve symlink kvmtest/kvmtest1: No such file or dire=
ctory
>>>>>>> 13:29:05.751: 1310: warning : qemuDomainAttachPciDiskDevice:250=
 :
>>>>>>> Unable to restore security label on kvmtest/kvmtest1
>>>>>>> 13:29:05.751: 1310: warning : virEventPollUpdateHandle:147 : Ig=
noring
>>>>>>> invalid update watch -1
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> This is libvirt mistakenly trying to treat the rbd disk as a fil=
e -
>>>>>> fixed
>>>>>> in
>>>>>> 20e1233c31e3150d259073c523077acdccb5d419 to libvirt. If you don'=
t want
>>>>>> to
>>>>>> upgrade libvirt, someone on IRC last week reported that installi=
ng
>>>>>> libapparmor1 fixed this problem for them, since libvirt no longe=
r fell
>>>>>> back
>>>>>> to it's own DAC implementation.
>>>>>
>>>>>
>>>>>
>>>>> hmm is this commited to any stable version now ?? i have installe=
d
>>>>> libapparmor1,
>>>>>
>>>>> ri =A0libapparmor1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.7.0~b=
eta1+bzr1774-1ubuntu2
>>>>> =A0 =A0 =A0 =A0 changehat AppArmor library
>>>>>
>>>>> and i use newest stable libvirt 0.9.8.
>>>>>
>>>>>>
>>>>>>
>>>>>>> 2011/12/1 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/01/2011 11:37 AM, S=B3awomir Skowron wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have some problems. Can you help me ??
>>>>>>>>>
>>>>>>>>> ceph cluster:
>>>>>>>>> ceph 0.38, oneiric, kernel 3.0.0 x86_64 - now only one machin=
e.
>>>>>>>>>
>>>>>>>>> kvm hypervisor:
>>>>>>>>> kvm version 1.0-rc4 (0.15.92), libvirt 0.9.2, kernel 3.0.0, U=
buntu
>>>>>>>>> oneiric x86_64.
>>>>>>>>>
>>>>>>>>> I create image from qemu-img on machine with kvm VM's, and it=
 works
>>>>>>>>> very
>>>>>>>>> well:
>>>>>>>>>
>>>>>>>>> qemu-img create -f rbd rbd:kvmtest/kvmtest1 10G
>>>>>>>>> Formatting 'rbd:kvmtest/kvmtest1', fmt=3Drbd size=3D107374182=
40
>>>>>>>>> cluster_size=3D0
>>>>>>>>>
>>>>>>>>> in ceph cluster machines:
>>>>>>>>>
>>>>>>>>> rados -p kvmtest ls
>>>>>>>>> kvmtest1.rbd
>>>>>>>>> rbd_directory
>>>>>>>>> rbd_info
>>>>>>>>>
>>>>>>>>> But when i try to attach new device to kvm VM like this:
>>>>>>>>>
>>>>>>>>> virsh attach-device one-10 /tmp/kvm.xml
>>>>>>>>>
>>>>>>>>> with kvm.xml like this:
>>>>>>>>>
>>>>>>>>> <disk type=3D'network' device=3D'disk'>
>>>>>>>>> =A0 =A0 =A0 =A0 <driver name=3D'qemu' type=3D'raw' cache=3D'w=
riteback'/>
>>>>>>>>> =A0 =A0 =A0 =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/=
kvmtest1'>
>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <host name=3D'10.177.64.4' po=
rt=3D'6789'/>
>>>>>>>>> =A0 =A0 =A0 =A0 </source>
>>>>>>>>> =A0 =A0 =A0 =A0 <target dev=3D'vdc' bus=3D'virtio'/>
>>>>>>>>> </disk>
>>>>>>>>>
>>>>>>>>> output of virsh:
>>>>>>>>>
>>>>>>>>> error: Failed to attach device from /tmp/kvm.xml
>>>>>>>>> error: cannot resolve symlink rbd:kvmtest/kvmtest1: No such f=
ile or
>>>>>>>>> directory
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> =A0From the monitor output below, I'm assuming this is just a =
bad
>>>>>>>> error
>>>>>>>> message
>>>>>>>> from libvirt.
>>>>>>>>
>>>>>>>>
>>>>>>>>> and mon.0 log in ceph cluster.
>>>>>>>>>
>>>>>>>>> 2011-12-01 20:18:17.142595 7fe02dd04700 mon.0@0(leader) e1
>>>>>>>>> ms_verify_authorizer 10.177.32.66:0/25020608 client protocol =
0
>>>>>>>>> 2011-12-01 20:18:17.143041 7fe03223b700 -- 10.177.64.4:6789/0=
<=3D=3D
>>>>>>>>> client.? 10.177.32.66:0/25020608 1 =3D=3D=3D=3D auth(proto 0 =
21 bytes) v1
>>>>>>>>> =3D=3D=3D=3D
>>>>>>>>> 47+0+0 (3310669357 0 0) 0x29f6a00 con 0x297adc0
>>>>>>>>> 2011-12-01 20:18:17.143095 7fe03223b700 mon.0@0(leader) e1
>>>>>>>>> ms_dispatch
>>>>>>>>> new session MonSession: client.? 10.177.32.66:0/25020608 is o=
pen
>>>>>>>>> for
>>>>>>>>> client.? 10.177.32.66:0/25020608
>>>>>>>>> 2011-12-01 20:18:17.143125 7fe03223b700 mon.0@0(leader).auth =
v146
>>>>>>>>> preprocess_query auth(proto 0 21 bytes) v1 from client.?
>>>>>>>>> 10.177.32.66:0/25020608
>>>>>>>>> 2011-12-01 20:18:17.143168 7fe03223b700 -- 10.177.64.4:6789/0=
 -->
>>>>>>>>> 10.177.32.66:0/25020608 -- auth_reply(proto 0 -95 Operation n=
ot
>>>>>>>>> supported) v1 -- ?+0 0x2f30600 con 0x297adc0
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Here you can see qemu isn't authenticating correctly, probably
>>>>>>>> because
>>>>>>>> the
>>>>>>>> rados user isn't being set by libvirt. With your libvirt versi=
on,
>>>>>>>> you'll
>>>>>>>> need to change:
>>>>>>>>
>>>>>>>>
>>>>>>>> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1'>
>>>>>>>>
>>>>>>>> to
>>>>>>>>
>>>>>>>> =A0 <source protocol=3D'rbd' name=3D'rbd:kvmtest/kvmtest1:id=3D=
foo'>
>>>>>>>>
>>>>>>>> to authenticate as client.foo. Any ceph config option can be s=
et
>>>>>>>> like
>>>>>>>> that,
>>>>>>>> separated by colons.
>>>>>>>>
>>>>>>>> If this still doesn't work, I'd suggest setting
>>>>>>>> debug_rbd=3D20:debug_monc=3D20:debug_auth=3D20:log_to_stderr=3D=
2 to get more
>>>>>>>> info
>>>>>>>> in
>>>>>>>> the libvirt instance log (usually
>>>>>>>> /var/log/libvirt/qemu/instance_name.log).
>>>>>>>> There may be apparmour restrictions preventing qemu from readi=
ng the
>>>>>>>> keyring
>>>>>>>> or ceph config files.
>>>>>>>>
>>>>>>>>
>>>>>>>>> ceph.conf, and keyring.bin exists on server, and machine with
>>>>>>>>> qemu-kvm
>>>>>>>>> in same directory:
>>>>>>>>> ; global
>>>>>>>>> [global]
>>>>>>>>> =A0 =A0 =A0 =A0 ; enable secure authentication
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.bin
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 rgw print continue =3D false
>>>>>>>>> =A0 =A0 =A0 =A0 rgw socket path =3D /var/run/radosgw.sock
>>>>>>>>>
>>>>>>>>> ; monitors
>>>>>>>>> ; =A0You need at least one. =A0You need at least three if you=
 want to
>>>>>>>>> ; =A0tolerate any node failures. =A0Always create an odd numb=
er.
>>>>>>>>> [mon]
>>>>>>>>> =A0 =A0 =A0 =A0 mon data =3D /vol0/data/mon.$id
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 ; some minimal logging (just message traffic)=
 to aid
>>>>>>>>> debugging
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 1 =A0 =A0 ; see message traffic
>>>>>>>>> =A0 =A0 =A0 =A0 debug mon =3D 0 =A0 ; monitor
>>>>>>>>> =A0 =A0 =A0 =A0 debug paxos =3D 0 ; monitor replication
>>>>>>>>> =A0 =A0 =A0 =A0 debug auth =3D 0 =A0;
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 mon allowed clock drift =3D 2
>>>>>>>>>
>>>>>>>>> [mon.0]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 mon addr =3D 10.177.64.4:6789
>>>>>>>>>
>>>>>>>>> ; radosgw client list
>>>>>>>>> [client.radosgw.10-177-64-4]
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 log file =3D /var/log/ceph/$name.log
>>>>>>>>> =A0 =A0 =A0 =A0 debug rgw =3D 1
>>>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 1
>>>>>>>>>
>>>>>>>>> ; osd
>>>>>>>>> ; =A0You need at least one. =A0Two if you want data to be rep=
licated.
>>>>>>>>> ; =A0Define as many as you like.
>>>>>>>>> [osd]
>>>>>>>>> =A0 =A0 =A0 =A0 ; This is where the btrfs volume will be moun=
ted.
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.$id
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 ; Ideally, make this a separate disk or parti=
tion. =A0A few
>>>>>>>>> GB
>>>>>>>>> =A0 =A0 =A0 =A0 ; is usually enough; more if you have fast di=
sks. =A0You can
>>>>>>>>> use
>>>>>>>>> =A0 =A0 =A0 =A0 ; a file under the osd data dir if need be
>>>>>>>>> =A0 =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be=
 slower than a
>>>>>>>>> =A0 =A0 =A0 =A0 ; separate disk or partition.
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 osd journal =3D /vol0/data/osd.$id/journal
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 ; If the OSD journal is a file, you need to s=
pecify the
>>>>>>>>> size.
>>>>>>>>> This is specified in MB.
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 osd journal size =3D 512
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 filestore journal writeahead =3D 1
>>>>>>>>> =A0 =A0 =A0 =A0 osd heartbeat grace =3D 5
>>>>>>>>>
>>>>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 0 =A0 =A0 =A0 =A0 ; message traf=
fic
>>>>>>>>> =A0 =A0 =A0 =A0 debug osd =3D 0
>>>>>>>>> =A0 =A0 =A0 =A0 debug filestore =3D 0 ; local object storage
>>>>>>>>> =A0 =A0 =A0 =A0 debug journal =3D 0 =A0 ; local journaling
>>>>>>>>> =A0 =A0 =A0 =A0 debug monc =3D 0
>>>>>>>>> =A0 =A0 =A0 =A0 debug rados =3D 1
>>>>>>>>>
>>>>>>>>> [osd.0]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.0
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.0/keyring
>>>>>>>>>
>>>>>>>>> [osd.1]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.1
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.1/keyring
>>>>>>>>>
>>>>>>>>> [osd.2]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.2
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.2/keyring
>>>>>>>>>
>>>>>>>>> [osd.3]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.3
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.3/keyring
>>>>>>>>>
>>>>>>>>> [osd.4]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.4
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.4/keyring
>>>>>>>>>
>>>>>>>>> [osd.5]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.5
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.5/keyring
>>>>>>>>>
>>>>>>>>> [osd.6]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.6
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.6/keyring
>>>>>>>>>
>>>>>>>>> [osd.7]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.7
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.7/keyring
>>>>>>>>>
>>>>>>>>> [osd.8]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.8
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.8/keyring
>>>>>>>>>
>>>>>>>>> [osd.9]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.9
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.9/keyring
>>>>>>>>>
>>>>>>>>> [osd.10]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.10
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.10/keyring
>>>>>>>>>
>>>>>>>>> [osd.11]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.11
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.11/keyring
>>>>>>>>>
>>>>>>>>> [osd.12]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.12
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.12/keyring
>>>>>>>>>
>>>>>>>>> [osd.13]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.13
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.13/keyring
>>>>>>>>>
>>>>>>>>> [osd.14]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.14
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.14/keyring
>>>>>>>>>
>>>>>>>>> [osd.15]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.15
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.15/keyring
>>>>>>>>>
>>>>>>>>> [osd.16]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.16
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.16/keyring
>>>>>>>>>
>>>>>>>>> [osd.17]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.17
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.17/keyring
>>>>>>>>>
>>>>>>>>> [osd.18]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.18
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.18/keyring
>>>>>>>>>
>>>>>>>>> [osd.19]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.19
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.19/keyring
>>>>>>>>>
>>>>>>>>> [osd.20]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.20
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.20/keyring
>>>>>>>>>
>>>>>>>>> [osd.21]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.21
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.21/keyring
>>>>>>>>>
>>>>>>>>> [osd.22]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.22
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.22/keyring
>>>>>>>>>
>>>>>>>>> [osd.23]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.23
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.23/keyring
>>>>>>>>>
>>>>>>>>> [osd.24]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.24
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.24/keyring
>>>>>>>>>
>>>>>>>>> [osd.25]
>>>>>>>>> =A0 =A0 =A0 =A0 host =3D 10-177-64-4
>>>>>>>>> =A0 =A0 =A0 =A0 osd data =3D /vol0/data/osd.25
>>>>>>>>> =A0 =A0 =A0 =A0 keyring =3D /vol0/data/osd.25/keyring
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
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
>>> --
>>> -----
>>> Pozdrawiam
>>>
>>> S=B3awek "sZiBis" Skowron
>>
>>
>>
>>
>



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
