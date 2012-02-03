From: Masuko Tomoya <tomoya.masuko@gmail.com>
Subject: Re: couldn't use rbd
Date: Fri, 3 Feb 2012 14:54:08 -0800
Message-ID: <CAM2zNoORjF7aXvU7+XRzGbuwpX4g6JWD=cu_c=8zNZnJXU_ukg@mail.gmail.com>
References: <CAM2zNoOyURtLAzh=DNcPjazj1RpgEY7WeJ_-QVjOWzbTp+qSUQ@mail.gmail.com>
	<4F2B37DB.4070506@dreamhost.com>
	<CAM2zNoOgENLwoziggjN-Xi=iOqKwa914i7JTUDonvFGw9OjJ9w@mail.gmail.com>
	<4F2C13E7.5000509@dreamhost.com>
	<CAM2zNoNwetayC4w4Jd5z_WxtvYKr0vOSFrijzsw1Qb739dCmKA@mail.gmail.com>
	<4F2C6167.7030607@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35496 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904Ab2BCWyK convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Feb 2012 17:54:10 -0500
Received: by lagu2 with SMTP id u2so2096060lag.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 14:54:08 -0800 (PST)
In-Reply-To: <4F2C6167.7030607@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi,

The output of 'ceph pg dump' is below.

root@ceph01:~# ceph pg dump
2012-02-04 07:50:15.453151 mon <- [pg,dump]
2012-02-04 07:50:15.453734 mon.0 -> 'dumped all in format plain' (0)
version 63
last_osdmap_epoch 37
last_pg_scan 1
full_ratio 0.95
nearfull_ratio 0.85
pg_stat objects mip     degr    unf     kb      bytes   log
disklog state   v       reported        up      acting  last_scrub
1.1p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'30   [0]     [0] 0'0
2012-02-03 10:25:55.383343
0.0p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'32   [0]     [0] 0'0
2012-02-03 10:25:51.380648
1.0p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'30   [0]     [0] 0'0
2012-02-03 10:25:53.381291
0.1p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'32   [0]     [0] 0'0
2012-02-03 10:25:52.380881
2.0p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'30   [0]     [0] 0'0
2012-02-03 10:25:59.387441
2.1p0   0       0       0       0       0       0       0       0
 active+clean+degraded   0'0     34'30   [0]     [0] 0'0
2012-02-03 10:26:04.392778
pool 0  0       0       0       0       0       0       0       0
pool 1  0       0       0       0       0       0       0       0
pool 2  0       0       0       0       0       0       0       0
 sum    0       0       0       0       0       0       0       0
osdstat kbused  kbavail kb      hb in   hb out
0       1568    15726032        15727600        []      []
 sum    1568    15726032        15727600


2012/2/3 Josh Durgin <josh.durgin@dreamhost.com>:
> On 02/03/2012 02:14 PM, Masuko Tomoya wrote:
>>
>> Hi Josh,
>>
>> Thank you for your comments.
>>
>>> =A0 =A0debug osd =3D 20
>>> =A0 =A0debug ms =3D 1
>>> =A0 =A0debug filestore =3D 20
>>
>>
>> I added this to the osd section of ceph.conf and ran /etc/init.d/cep=
h
>> stop&start.
>>
>> The output of OSD.log when 'rbd list' was executed is below.
>>
>> -----
>> 2012-02-04 04:29:22.457990 7fe0e08fb710 osd.0 32
>> OSD::ms_verify_authorizer name=3Dclient.admin auid=3D0
>> 2012-02-04 04:29:22.458041 7fe0e08fb710 osd.0 32 =A0new session
>> 0x24f5240 con=3D0x24d4dc0 addr=3D10.68.119.191:0/1005110
>> 2012-02-04 04:29:22.458069 7fe0e08fb710 osd.0 32 =A0session 0x24f524=
0
>> has caps osdcaps(pools=3D{} default allow=3D default_deny=3D)
>> 2012-02-04 04:29:22.458415 7fe0e6c0a710 -- 10.68.119.191:6801/4992<=3D=
=3D
>> client.4201 10.68.119.191:0/1005110 1 =3D=3D=3D=3D osd_op(client.420=
1.0:1
>> rbd_directory [read 0~0] 2.30a98c1c) v3 =3D=3D=3D=3D 143+0+0 (372016=
4172 0 0)
>> 0x24d8900 con 0x24d4dc0
>> 2012-02-04 04:29:22.458442 7fe0e6c0a710 osd.0 32 _dispatch 0x24d8900
>> osd_op(client.4201.0:1 rbd_directory [read 0~0] 2.30a98c1c) v3
>> 2012-02-04 04:29:22.458463 7fe0e6c0a710 osd.0 32
>> require_same_or_newer_map 32 (i am 32) 0x24d8900
>> 2012-02-04 04:29:22.458487 7fe0e6c0a710 osd.0 32 _share_map_incoming
>> client.4201 10.68.119.191:0/1005110 32
>> 2012-02-04 04:29:22.458507 7fe0e6c0a710 osd.0 32 hit non-existent pg
>> 2.0, waiting
>
>
> The pg should have been created already. What's the output of 'ceph p=
g
> dump'?
>
>
>>
>>
>> 2012/2/3 Josh Durgin<josh.durgin@dreamhost.com>:
>>>
>>> On 02/03/2012 12:51 AM, Masuko Tomoya wrote:
>>>>
>>>>
>>>> Hi Josh,
>>>>
>>>> Thank you for reply !
>>>>
>>>>> This might mean the rbd image list object can't be read for some
>>>>> reason, or the rbd tool is doing something weird that the rados t=
ool
>>>>> isn't. Can you share the output of 'ceph -s' and
>>>>> 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20 --debug-=
monc
>>>>> 20
>>>>> --debug-auth 20'?
>>>>
>>>>
>>>>
>>>> The output of 'ceph -s' is below.
>>>> -------
>>>> root@ceph01:~# ceph -s
>>>> 2012-02-03 17:01:47.881960 =A0 =A0pg v33: 6 pgs: 6 active+clean+de=
graded;
>>>> 0 KB data, 1056 KB used, 15357 MB / 15358 MB avail
>>>> 2012-02-03 17:01:47.882583 =A0 mds e9: 1/1/1 up {0=3D0=3Dup:creati=
ng}
>>>> 2012-02-03 17:01:47.882733 =A0 osd e21: 1 osds: 1 up, 1 in
>>>> 2012-02-03 17:01:47.883042 =A0 log 2012-02-03 16:35:11.183897 osd.=
0
>>>> 10.68.119.191:6801/2912 12 : [WRN] map e19 wrongly marked me down =
or
>>>> wrong addr
>>>> 2012-02-03 17:01:47.883144 =A0 mon e1: 1 mons at {0=3D10.68.119.19=
1:6789/0}
>>>>
>>>> The output of 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecte=
r 20
>>>> --debug-monc 20 --debug-auth 20' is below.
>>>> ------
>>>> root@ceph01:~# rbd ls --log-to-stderr --debug-ms 1 --debug-objecte=
r 20
>>>> --debug-monc 20 --debug-auth 20
>>>
>>>
>>>
>>> <snip>
>>>
>>>
>>>> 2012-02-03 17:02:10.971391 7f88cbb91720 client.4106.objecter op_su=
bmit
>>>> oid rbd_directory @2 [read 0~0] tid 1 osd.0
>>>> 2012-02-03 17:02:10.971465 7f88cbb91720 client.4106.objecter send_=
op 1
>>>> to
>>>> osd.0
>>>> 2012-02-03 17:02:10.971533 7f88cbb91720 -- 10.68.119.191:0/1003500=
 -->
>>>> 10.68.119.191:6801/2912 -- osd_op(client.4106.0:1 rbd_directory [r=
ead
>>>> 0~0] 2.30a98c1c) v1 -- ?+0 0x24664c0 con 0x24661b0
>>>
>>>
>>>
>>> Everything above here is normal - the rbd tool connected to the
>>> monitors, got the monmap and osdmap, and sent a request to read the
>>> 'rbd_directory' object.
>>>
>>> <snip>
>>>
>>>
>>>> 2012-02-03 17:02:25.969338 7f88c7261710 client.4106.objecter =A0ti=
d 1 on
>>>> osd.0 is laggy
>>>
>>>
>>>
>>> This means the osd isn't responding to the read. Check the osd log =
for
>>> errors. If there's nothing obvious, add this to the osd section of =
your
>>> ceph.conf and restart the osd:
>>>
>>> =A0 =A0debug osd =3D 20
>>> =A0 =A0debug ms =3D 1
>>> =A0 =A0debug filestore =3D 20
>>>
>>> Then run 'rbd ls' and look at what happens after
>>> 'osd_op.*rbd_directory' appears in the osd log.
>>>
>>> <rados lspools log>
>>>
>>>
>>>>
>>>> I compared those logs and found there is differences.
>>>> 'rbd list'
>>>> 2012-02-03 17:02:10.971770 7f88c9366710 -- 10.68.119.191:0/1003500=
<=3D=3D
>>>> mon.0 10.68.119.191:6789/0 10 =3D=3D=3D=3D osd_map(21..21 src has =
1..21) v2
>>>> =3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x24655a0 con 0x24603e0
>>>> 2012-02-03 17:02:10.971789 7f88c9366710 client.4106.objecter
>>>> handle_osd_map ignoring epochs [21,21]<=3D 21
>>>> 2012-02-03 17:02:10.971801 7f88c9366710 client.4106.objecter
>>>> dump_active .. 0 homeless
>>>> 2012-02-03 17:02:10.971815 7f88c9366710 client.4106.objecter 1
>>>> 2.30a98c1c =A0 =A0 =A0osd.0 =A0 rbd_directory =A0 [read 0~0]
>>>> --(snip)--
>>>>
>>>> 'rados lspools'
>>>> 2012-02-03 17:11:52.866072 7f9c5764b710 -- 10.68.119.191:0/1003868=
<=3D=3D
>>>> mon.0 10.68.119.191:6789/0 7 =3D=3D=3D=3D osd_map(21..21 src has 1=
=2E.21) v2
>>>> =3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x770a70 con 0x771440
>>>> 2012-02-03 17:11:52.866103 7f9c5764b710 client.4107.objecter
>>>> handle_osd_map got epochs [21,21]> =A0 =A00
>>>> 2012-02-03 17:11:52.866111 7f9c5764b710 client.4107.objecter
>>>> handle_osd_map decoding full epoch 21
>>>> 2012-02-03 17:11:52.866272 7f9c5764b710 client.4107.objecter
>>>> dump_active .. 0 homeless
>>>> data
>>>> metadata
>>>> rbd
>>>> --(snip)--
>>>>
>>>> What do these logs mean ?
>>>
>>>
>>>
>>> The difference is that 'rbd ls' talks to the monitors and osds, whi=
le
>>> 'rados
>>> lspools' just needs to talk to the monitors. The objecter dump_acti=
ve
>>> part
>>> is listing in-flight osd requests.
>>>
>>>
>>>>
>>>>>> *ceph cluster is configured on single server.
>>>>>> *server is ubuntu 10.10 maverick.
>>>>>> *ceph, librados2 and librbd1 packages are installed.
>>>>>> =A0(version: 0.38-1maverick)
>>>>>> *apparmor is disable.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> apparmor shouldn't matter if you have libvirt 0.9.9 or newer.
>>>>
>>>>
>>>>
>>>> I use libvirt 0.8.3 (latest version for maverick), so I disabled
>>>> apparmor.
>>>>
>>>>
>>>>
>>>> 2012/2/2 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>>
>>>>>
>>>>> On 02/02/2012 01:49 AM, Masuko Tomoya wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi, all.
>>>>>>
>>>>>> When I execute "rbd" command, it is not success.
>>>>>>
>>>>>> root@ceph01:~# rbd list
>>>>>> (no response)
>>>>>>
>>>>>> /var/log/ceph/mon.0.log
>>>>>> -----
>>>>>> 2012-02-02 17:58:19.801762 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.? 10.68.119.191:0/1002580 1 =3D=3D=3D=3D auth(proto 0 30 =
bytes) v1 =3D=3D=3D=3D
>>>>>> 56+0+0 (625540289 0 0) 0x1619a00 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.801919 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?=
+0
>>>>>> 0x1619c00 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.802505 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.? 10.68.119.191:0/1002580 2 =3D=3D=3D=3D auth(proto 2 32 =
bytes) v1 =3D=3D=3D=3D
>>>>>> 58+0+0 (346146289 0 0) 0x161fc00 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.802673 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?=
+0
>>>>>> 0x1619a00 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.803473 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.? 10.68.119.191:0/1002580 3 =3D=3D=3D=3D auth(proto 2 165=
 bytes) v1
>>>>>> =3D=3D=3D=3D 191+0+0 (3737796417 0 0) 0x1619600 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.803745 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?=
+0
>>>>>> 0x161fc00 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.804425 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.? 10.68.119.191:0/1002580 4 =3D=3D=3D=3D mon_subscribe({m=
onmap=3D0+}) v2
>>>>>> =3D=3D=3D=3D 23+0+0 (1620593354 0 0) 0x1617380 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.804488 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1635700 con 0x161=
5a00
>>>>>> 2012-02-02 17:58:19.804517 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> client.? 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 -=
- ?+0
>>>>>> 0x163d780
>>>>>> 2012-02-02 17:58:19.804550 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.4112 10.68.119.191:0/1002580 5 =3D=3D=3D=3D
>>>>>> mon_subscribe({monmap=3D0+,osdmap=3D0}) v2 =3D=3D=3D=3D 42+0+0 (=
982583713 0 0)
>>>>>> 0x1617a80 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.804578 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617380 con 0x161=
5a00
>>>>>> 2012-02-02 17:58:19.804656 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v=
1 --
>>>>>> ?+0 0x1619600
>>>>>> 2012-02-02 17:58:19.804744 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v=
1 --
>>>>>> ?+0 0x163d900
>>>>>> 2012-02-02 17:58:19.804778 7ff4bbfb1710 -- 10.68.119.191:6789/0<=
=3D=3D
>>>>>> client.4112 10.68.119.191:0/1002580 6 =3D=3D=3D=3D
>>>>>> mon_subscribe({monmap=3D0+,osdmap=3D0}) v2 =3D=3D=3D=3D 42+0+0 (=
982583713 0 0)
>>>>>> 0x16178c0 con 0x1615a00
>>>>>> 2012-02-02 17:58:19.804811 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617a80 con 0x161=
5a00
>>>>>> 2012-02-02 17:58:19.804855 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v=
1 --
>>>>>> ?+0 0x1619400
>>>>>> 2012-02-02 17:58:19.804884 7ff4bbfb1710 -- 10.68.119.191:6789/0 =
-->
>>>>>> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v=
1 --
>>>>>> ?+0 0x161d300
>>>>>> -----
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> No problems there.
>>>>>
>>>>>
>>>>>>
>>>>>> BTW, I could execute "rados lspools".
>>>>>>
>>>>>> root@ceph01:~# rados lspools
>>>>>> data
>>>>>> metadata
>>>>>> rbd
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> This might mean the rbd image list object can't be read for some
>>>>> reason, or the rbd tool is doing something weird that the rados t=
ool
>>>>> isn't. Can you share the output of 'ceph -s' and
>>>>> 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20 --debug-=
monc
>>>>> 20
>>>>> --debug-auth 20'?
>>>>>
>>>>> You can run 'rados lspools' with those options as well and compar=
e.
>>>>>
>>>>>
>>>>>> I would like to use rbd volume and attach it as virtual device f=
or VM
>>>>>> guest on KVM.
>>>>>>
>>>>>> Could you advice to me ?
>>>>>>
>>>>>>
>>>>>> My environment is below.
>>>>>>
>>>>>> *ceph cluster is configured on single server.
>>>>>> *server is ubuntu 10.10 maverick.
>>>>>> *ceph, librados2 and librbd1 packages are installed.
>>>>>> =A0(version: 0.38-1maverick)
>>>>>> *apparmor is disable.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> apparmor shouldn't matter if you have libvirt 0.9.9 or newer.
>>>>>
>>>>>
>>>>>> *root@ceph01:/# ls -l /etc/ceph
>>>>>> total 16
>>>>>> -rw-r--r-- 1 root root 340 2012-02-02 17:28 ceph.conf
>>>>>> -rw------- 1 root root =A092 2012-02-02 17:28 client.admin.keyri=
ng
>>>>>> -rw------- 1 root root =A085 2012-02-02 17:28 mds.0.keyring
>>>>>> -rw------- 1 root root =A085 2012-02-02 17:28 osd.0.keyring
>>>>>> */var/lib/ceph/tmp is exists.
>>>>>> root@ceph01:/var/log# ls -l /var/lib/ceph/
>>>>>> total 4
>>>>>> drwxrwxrwx 2 root root 4096 2011-11-11 09:28 tmp
>>>>>>
>>>>>> */etc/ceph/ceph.conf
>>>>>> [global]
>>>>>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>>>>>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/$name.keyring
>>>>>> [mon]
>>>>>> =A0 =A0 =A0 =A0 mon data =3D /data/data/mon$id
>>>>>> =A0 =A0 =A0 =A0 debug ms =3D 1
>>>>>> [mon.0]
>>>>>> =A0 =A0 =A0 =A0 host =3D ceph01
>>>>>> =A0 =A0 =A0 =A0 mon addr =3D 10.68.119.191:6789
>>>>>> [mds]
>>>>>>
>>>>>> [mds.0]
>>>>>> =A0 =A0 =A0 =A0 host =3D ceph01
>>>>>> [osd]
>>>>>> =A0 =A0 =A0 =A0 osd data =3D /data/osd$id
>>>>>> =A0 =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
>>>>>> =A0 =A0 =A0 =A0 osd journal size =3D 512
>>>>>> =A0 =A0 =A0 =A0 osd class tmp =3D /var/lib/ceph/tmp
>>>>>> [osd.0]
>>>>>> =A0 =A0 =A0 =A0 host =3D ceph01
>>>>>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sdb1
>>>>>>
>>>>>>
>>>>>> Waiting for your reply,
>>>>>>
>>>>>> Tomoya.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
