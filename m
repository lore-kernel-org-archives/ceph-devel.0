From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Mysteriously poor write performance
Date: Wed, 21 Mar 2012 14:20:22 -0700
Message-ID: <CACLRD_2fcSnVOq4JSQ6m5OCRKKZQH3QVpYT6hM6JHDVMxH0NsQ@mail.gmail.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
	<Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
	<CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
	<4825A243C5604C48A3E022008ED974D0@dreamhost.com>
	<CABYiri9omWz_vSZxL_McYg5bMoW20x6TBCsXHTHwgZ0hqUxofA@mail.gmail.com>
	<4F677D95.8040208@dreamhost.com>
	<CABYiri-AV6WK-H7K9oSwSnMSAgB6ZAHLDn2Ar6omdS=8EAjtfA@mail.gmail.com>
	<CACLRD_2+zKBfmOm-+1GT1+zMtTQ5B0e21_J3C7Qfw+YCH5+o=w@mail.gmail.com>
	<CABYiri9An0sYP6pP1xU_Xjz7yhXdv1eF-4q-DqtqygYH76rMHw@mail.gmail.com>
	<CACLRD_0BK0WVX6=-n3doF680efibNVjq_qB_DwxF73MXNWQ_LA@mail.gmail.com>
	<CABYiri--y7zyS_+GvNqCayQd6PXyU8R0GEiBC0BD885DK6w7Rw@mail.gmail.com>
	<CACLRD_1Ndcoz3+aOzn4O-7DLL-ePV8ujeGyaN9AeHXTxsO2AeA@mail.gmail.com>
	<CABYiri-J-+SsqXOq=ircP-v80rfiXjoFX20wLa0Pfc7KvyA0SQ@mail.gmail.com>
	<CACLRD_1PWntwwyWTWij1OuC+LaSU=jz5gittQ5vwqGSXQnyzeQ@mail.gmail.com>
	<CABYiri_bjt9Equj4JcoVsN5AEMxxX_qaNNBYZzCfi2rirsTCkA@mail.gmail.com>
	<CABYiri8TfJXC7j3L5QXXFO2nmtwiyoP=YSGCZse0VrsY+_zbLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57240 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760138Ab2CUVUZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 17:20:25 -0400
Received: by wejx9 with SMTP id x9so1303732wej.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 14:20:23 -0700 (PDT)
In-Reply-To: <CABYiri8TfJXC7j3L5QXXFO2nmtwiyoP=YSGCZse0VrsY+_zbLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

(CCing the list)

So, the problem isn't the bandwidth.  Before we respond to the client,
we write the operation to the journal.  In this case, that operation
is taking >1s per operation on osd.1.  Both rbd and rados bench will
only allow a limited number of ops in flight at a time, so this
latency is killing your throughput.  For comparison, the latency for
writing to the journal on osd.0 is < .3s.  Can you measure direct io
latency for writes to your osd.1 journal file?
-Sam

On Wed, Mar 21, 2012 at 1:56 PM, Andrey Korolyov <andrey@xdel.ru> wrote=
:
> Oh, you may confuse with Zabbix metrics - y-axis means Megabytes/s,
> not Megabits.
>
> On Thu, Mar 22, 2012 at 12:53 AM, Andrey Korolyov <andrey@xdel.ru> wr=
ote:
>> [global]
>> =C2=A0 =C2=A0 =C2=A0 log dir =3D /ceph/out
>> =C2=A0 =C2=A0 =C2=A0 log_file =3D ""
>> =C2=A0 =C2=A0 =C2=A0 logger dir =3D /ceph/log
>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$type$id.pid
>> [mds]
>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$name.pid
>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>> =C2=A0 =C2=A0 =C2=A0 mds log max segments =3D 2
>> [osd]
>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>> =C2=A0 =C2=A0 =C2=A0 filestore_xattr_use_omap =3D 1
>> =C2=A0 =C2=A0 =C2=A0 osd data =3D /ceph/dev/osd$id
>> =C2=A0 =C2=A0 =C2=A0 osd journal =3D /ceph/meta/journal
>> =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 100
>> [mon]
>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>> =C2=A0 =C2=A0 =C2=A0 mon data =3D /ceph/dev/mon$id
>> [mon.0]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.32:6789
>> [mon.1]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.33:6789
>> [mon.2]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.35
>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.35:6789
>> [osd.0]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>> [osd.1]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>> [mds.a]
>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>
>> /dev/sda1 on /ceph type ext4 (rw,barrier=3D0,user_xattr)
>> /dev/mapper/system-cephmeta on /ceph/meta type ext4 (rw,barrier=3D0,=
user_xattr)
>> Simple performance tests on those fs shows ~133Mb/s for /ceph and
>> metadata/. Also both machines do not hold anything else which may
>> impact osd.
>>
>> Also please note of following:
>>
>> http://i.imgur.com/ZgFdO.png
>>
>> First two peaks are related to running rados bench, then goes cluste=
r
>> recreation, automated debian install and final peaks are dd test.
>> Surely I can have more precise graphs, but current one probably enou=
gh
>> to state a situation - rbd utilizing about a quarter of possible
>> bandwidth(if we can count rados bench as 100%).
>>
>> On Thu, Mar 22, 2012 at 12:39 AM, Samuel Just <sam.just@dreamhost.co=
m> wrote:
>>> Hmm, there seem to be writes taking as long as 1.5s to hit journal =
on
>>> osd.1... =C2=A0Could you post your ceph.conf? =C2=A0Might there be =
a problem
>>> with the osd.1 journal disk?
>>> -Sam
>>>
>>> On Wed, Mar 21, 2012 at 1:25 PM, Andrey Korolyov <andrey@xdel.ru> w=
rote:
>>>> Oh, sorry - they probably inherited rights from log files, fixed.
>>>>
>>>> On Thu, Mar 22, 2012 at 12:17 AM, Samuel Just <sam.just@dreamhost.=
com> wrote:
>>>>> I get 403 Forbidden when I try to download any of the files.
>>>>> -Sam
>>>>>
>>>>> On Wed, Mar 21, 2012 at 11:51 AM, Andrey Korolyov <andrey@xdel.ru=
> wrote:
>>>>>> http://xdel.ru/downloads/ceph-logs/
>>>>>>
>>>>>> 1/ contains logs related to bench initiated at the osd0 machine =
and 2/
>>>>>> - at osd1.
>>>>>>
>>>>>> On Wed, Mar 21, 2012 at 8:54 PM, Samuel Just <sam.just@dreamhost=
=2Ecom> wrote:
>>>>>>> Hmm, I'm seeing some very high latency on ops sent to osd.1. =C2=
=A0Can you
>>>>>>> post osd.1's logs?
>>>>>>> -Sam
>>>>>>>
>>>>>>> On Wed, Mar 21, 2012 at 3:51 AM, Andrey Korolyov <andrey@xdel.r=
u> wrote:
>>>>>>>> Here, please: http://xdel.ru/downloads/ceph.log.gz
>>>>>>>>
>>>>>>>> Sometimes 'cur MB/s ' shows zero during rados bench, even if a=
ny debug
>>>>>>>> output disabled and log_file set to the empty value, hope it`s=
 okay.
>>>>>>>>
>>>>>>>> On Wed, Mar 21, 2012 at 2:36 AM, Samuel Just <sam.just@dreamho=
st.com> wrote:
>>>>>>>>> Can you set osd and filestore debugging to 20, restart the os=
ds, run
>>>>>>>>> rados bench as before, and post the logs?
>>>>>>>>> -Sam Just
>>>>>>>>>
>>>>>>>>> On Tue, Mar 20, 2012 at 1:37 PM, Andrey Korolyov <andrey@xdel=
=2Eru> wrote:
>>>>>>>>>> rados bench 60 write -p data
>>>>>>>>>> <skip>
>>>>>>>>>> Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A061.217676
>>>>>>>>>> Total writes made: =C2=A0 =C2=A0 989
>>>>>>>>>> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04194304
>>>>>>>>>> Bandwidth (MB/sec): =C2=A0 =C2=A064.622
>>>>>>>>>>
>>>>>>>>>> Average Latency: =C2=A0 =C2=A0 =C2=A0 0.989608
>>>>>>>>>> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.21701
>>>>>>>>>> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.255315
>>>>>>>>>>
>>>>>>>>>> Here a snip from osd log, seems write size is okay.
>>>>>>>>>>
>>>>>>>>>> 2012-03-21 00:00:39.397066 7fdda86a7700 osd.0 10 pg[0.58( v =
10'83
>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=3D=
8 mlcod 10'82
>>>>>>>>>> active+clean] =C2=A0removing repgather(0x31b5360 applying 10=
'83 rep_tid=3D597
>>>>>>>>>> wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2533 rb.0.2.000=
000000040 [write
>>>>>>>>>> 1220608~4096] 0.17eb9fd8) v4)
>>>>>>>>>> 2012-03-21 00:00:39.397086 7fdda86a7700 osd.0 10 pg[0.58( v =
10'83
>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=3D=
8 mlcod 10'82
>>>>>>>>>> active+clean] =C2=A0 =C2=A0q front is repgather(0x31b5360 ap=
plying 10'83
>>>>>>>>>> rep_tid=3D597 wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2=
533
>>>>>>>>>> rb.0.2.000000000040 [write 1220608~4096] 0.17eb9fd8) v4)
>>>>>>>>>>
>>>>>>>>>> Sorry for my previous question about rbd chunks, it was real=
ly stupid :)
>>>>>>>>>>
>>>>>>>>>> On Mon, Mar 19, 2012 at 10:40 PM, Josh Durgin <josh.durgin@d=
reamhost.com> wrote:
>>>>>>>>>>> On 03/19/2012 11:13 AM, Andrey Korolyov wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Nope, I`m using KVM for rbd guests. Surely I`ve been notic=
ed that Sage
>>>>>>>>>>>> mentioned too small value and I`ve changed it to 64M befor=
e posting
>>>>>>>>>>>> previous message with no success - both 8M and this value =
cause a
>>>>>>>>>>>> performance drop. When I tried to wrote small amount of da=
ta that can
>>>>>>>>>>>> be compared to writeback cache size(both on raw device and=
 ext3 with
>>>>>>>>>>>> sync option), following results were made:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I just want to clarify that the writeback window isn't a fu=
ll writeback
>>>>>>>>>>> cache - it doesn't affect reads, and does not help with req=
uest merging etc.
>>>>>>>>>>> It simply allows a bunch of writes to be in flight while ac=
king the write to
>>>>>>>>>>> the guest immediately. We're working on a full-fledged writ=
eback cache that
>>>>>>>>>>> to replace the writeback window.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D10 ofla=
g=3Ddirect (almost
>>>>>>>>>>>> same without oflag there and in the following samples)
>>>>>>>>>>>> 10+0 records in
>>>>>>>>>>>> 10+0 records out
>>>>>>>>>>>> 104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D20 ofla=
g=3Ddirect
>>>>>>>>>>>> 20+0 records in
>>>>>>>>>>>> 20+0 records out
>>>>>>>>>>>> 209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D30 ofla=
g=3Ddirect
>>>>>>>>>>>> 30+0 records in
>>>>>>>>>>>> 30+0 records out
>>>>>>>>>>>> 314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s
>>>>>>>>>>>>
>>>>>>>>>>>> and so on. Reference test with bs=3D1M and count=3D2000 ha=
s slightly worse
>>>>>>>>>>>> results _with_ writeback cache than without, as I`ve menti=
oned before.
>>>>>>>>>>>> =C2=A0Here the bench results, they`re almost equal on both=
 nodes:
>>>>>>>>>>>>
>>>>>>>>>>>> bench: wrote 1024 MB in blocks of 4096 KB in 9.037468 sec =
at 113 MB/sec
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> One thing to check is the size of the writes that are actua=
lly being sent by
>>>>>>>>>>> rbd. The guest is probably splitting them into relatively s=
mall (128 or
>>>>>>>>>>> 256k) writes. Ideally it would be sending 4k writes, and th=
is should be a
>>>>>>>>>>> lot faster.
>>>>>>>>>>>
>>>>>>>>>>> You can see the writes being sent by adding debug_ms=3D1 to=
 the client or osd.
>>>>>>>>>>> The format is osd_op(.*[write OFFSET~LENGTH]).
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Also, because I`ve not mentioned it before, network perfor=
mance is
>>>>>>>>>>>> enough to hold fair gigabit connectivity with MTU 1500. Se=
ems that it
>>>>>>>>>>>> is not interrupt problem or something like it - even if ce=
ph-osd,
>>>>>>>>>>>> ethernet card queues and kvm instance pinned to different =
sets of
>>>>>>>>>>>> cores, nothing changes.
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
>>>>>>>>>>>> <gregory.farnum@dreamhost.com> =C2=A0wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> It sounds like maybe you're using Xen? The "rbd writeback=
 window" option
>>>>>>>>>>>>> only works for userspace rbd implementations (eg, KVM).
>>>>>>>>>>>>> If you are using KVM, you probably want 81920000 (~80MB) =
rather than
>>>>>>>>>>>>> 8192000 (~8MB).
>>>>>>>>>>>>>
>>>>>>>>>>>>> What options are you running dd with? If you run a rados =
bench from both
>>>>>>>>>>>>> machines, what do the results look like?
>>>>>>>>>>>>> Also, can you do the ceph osd bench on each of your OSDs,=
 please?
>>>>>>>>>>>>> (http://ceph.newdream.net/wiki/Troubleshooting#OSD_perfor=
mance)
>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov wro=
te:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> More strangely, writing speed drops down by fifteen perc=
ent when this
>>>>>>>>>>>>>> option was set in vm` config(instead of result from
>>>>>>>>>>>>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/m=
sg03685.html).
>>>>>>>>>>>>>> As I mentioned, I`m using 0.43, but due to crashed osds,=
 ceph has been
>>>>>>>>>>>>>> recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55=
 and
>>>>>>>>>>>>>> 1468d95101adfad44247016a1399aab6b86708d2 - both cases ca=
used crashes
>>>>>>>>>>>>>> under heavy load.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil<sage@newdrea=
m.net
>>>>>>>>>>>>>> (mailto:sage@newdream.net)> =C2=A0wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I`ve did some performance tests at the following confi=
guration:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> mon0, osd0 and mon1, osd1 - two twelve-core r410 with =
32G ram, mon2 -
>>>>>>>>>>>>>>>> dom0 with three dedicated cores and 1.5G, mostly idle.=
 First three
>>>>>>>>>>>>>>>> disks on each r410 arranged into raid0 and holds osd d=
ata when fourth
>>>>>>>>>>>>>>>> holds os and osd` journal partition, all ceph-related =
stuff mounted on
>>>>>>>>>>>>>>>> the ext4 without barriers.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Firstly, I`ve noticed about a difference of benchmark =
performance and
>>>>>>>>>>>>>>>> write speed through rbd from small kvm instance runnin=
g on one of
>>>>>>>>>>>>>>>> first two machines - when bench gave me about 110Mb/s,=
 writing zeros
>>>>>>>>>>>>>>>> to raw block device inside vm with dd was at top speed=
 about 45 mb/s,
>>>>>>>>>>>>>>>> for vm`fs (ext4 with default options) performance drop=
s to ~23Mb/s.
>>>>>>>>>>>>>>>> Things get worse, when I`ve started second vm at secon=
d host and tried
>>>>>>>>>>>>>>>> to continue same dd tests simultaneously - performance=
 fairly divided
>>>>>>>>>>>>>>>> by half for each instance :). Enabling jumbo frames, p=
laying with cpu
>>>>>>>>>>>>>>>> affinity for ceph and vm instances and trying differen=
t TCP congestion
>>>>>>>>>>>>>>>> protocols gave no effect at all - with DCTCP I have sl=
ightly smoother
>>>>>>>>>>>>>>>> network load graph and that`s all.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Can ml please suggest anything to try to improve perfo=
rmance?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Can you try setting
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> rbd writeback window =3D 8192000
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> or similar, and see what kind of effect that has? I sus=
pect it'll speed
>>>>>>>>>>>>>>> up dd; I'm less sure about ext3.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>> sage
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscr=
ibe ceph-devel"
>>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/majordom=
o-info.html
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in
>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/majordomo-=
info.html
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majord=
omo-info.html
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ce=
ph-devel" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordom=
o-info.html
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo=
-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
