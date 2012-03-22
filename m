From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Mysteriously poor write performance
Date: Thu, 22 Mar 2012 10:26:01 -0700
Message-ID: <CACLRD_0CxGWdMerehzAd4yko3COeufZFhGPE-v7QOmMs7fSvYg@mail.gmail.com>
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
	<CACLRD_2fcSnVOq4JSQ6m5OCRKKZQH3QVpYT6hM6JHDVMxH0NsQ@mail.gmail.com>
	<CABYiri8qHCv6=dFUc-8tFo9bxEtUTQhV1cE9K=CK8hbhW3u10A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43755 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab2CVR0D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 13:26:03 -0400
Received: by wibhj6 with SMTP id hj6so1092277wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 10:26:01 -0700 (PDT)
In-Reply-To: <CABYiri8qHCv6=dFUc-8tFo9bxEtUTQhV1cE9K=CK8hbhW3u10A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Our journal writes are actually sequential.  Could you send FIO
results for sequential 4k writes osd.0's journal and osd.1's journal?
-Sam

On Thu, Mar 22, 2012 at 5:21 AM, Andrey Korolyov <andrey@xdel.ru> wrote=
:
> FIO output for journal partition, directio enabled, seems good(same
> results for ext4 on other single sata disks).
>
> random-rw: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dsync=
, iodepth=3D2
> Starting 1 process
> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/3219K /s] [0/786 iops] [eta 00=
m:00s]
> random-rw: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D21926
> =C2=A0write: io=3D163840KB, bw=3D2327KB/s, iops=3D581, runt=3D 70403m=
sec
> =C2=A0 =C2=A0clat (usec): min=3D122, max=3D441551, avg=3D1714.52, std=
ev=3D7565.04
> =C2=A0 =C2=A0bw (KB/s) : min=3D =C2=A0552, max=3D 3880, per=3D100.61%=
, avg=3D2341.23, stdev=3D480.05
> =C2=A0cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D0.42%, sys=3D1.34=
%, ctx=3D40976, majf=3D0, minf=3D42
> =C2=A0IO depths =C2=A0 =C2=A0: 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.=
0%, 16=3D0.0%, 32=3D0.0%, >=3D64=3D0.0%
> =C2=A0 =C2=A0 submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 1=
6=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
> =C2=A0 =C2=A0 complete =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0=
=2E0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
> =C2=A0 =C2=A0 issued r/w: total=3D0/40960, short=3D0/0
> =C2=A0 =C2=A0 lat (usec): 250=3D31.70%, 500=3D0.68%, 750=3D0.10%, 100=
0=3D0.63%
> =C2=A0 =C2=A0 lat (msec): 2=3D41.31%, 4=3D20.91%, 10=3D4.40%, 20=3D0.=
17%, 50=3D0.07%
> =C2=A0 =C2=A0 lat (msec): 500=3D0.04%
>
>
>
> On Thu, Mar 22, 2012 at 1:20 AM, Samuel Just <sam.just@dreamhost.com>=
 wrote:
>> (CCing the list)
>>
>> So, the problem isn't the bandwidth. =C2=A0Before we respond to the =
client,
>> we write the operation to the journal. =C2=A0In this case, that oper=
ation
>> is taking >1s per operation on osd.1. =C2=A0Both rbd and rados bench=
 will
>> only allow a limited number of ops in flight at a time, so this
>> latency is killing your throughput. =C2=A0For comparison, the latenc=
y for
>> writing to the journal on osd.0 is < .3s. =C2=A0Can you measure dire=
ct io
>> latency for writes to your osd.1 journal file?
>> -Sam
>>
>> On Wed, Mar 21, 2012 at 1:56 PM, Andrey Korolyov <andrey@xdel.ru> wr=
ote:
>>> Oh, you may confuse with Zabbix metrics - y-axis means Megabytes/s,
>>> not Megabits.
>>>
>>> On Thu, Mar 22, 2012 at 12:53 AM, Andrey Korolyov <andrey@xdel.ru> =
wrote:
>>>> [global]
>>>> =C2=A0 =C2=A0 =C2=A0 log dir =3D /ceph/out
>>>> =C2=A0 =C2=A0 =C2=A0 log_file =3D ""
>>>> =C2=A0 =C2=A0 =C2=A0 logger dir =3D /ceph/log
>>>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$type$id.pid
>>>> [mds]
>>>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$name.pid
>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>> =C2=A0 =C2=A0 =C2=A0 mds log max segments =3D 2
>>>> [osd]
>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>> =C2=A0 =C2=A0 =C2=A0 filestore_xattr_use_omap =3D 1
>>>> =C2=A0 =C2=A0 =C2=A0 osd data =3D /ceph/dev/osd$id
>>>> =C2=A0 =C2=A0 =C2=A0 osd journal =3D /ceph/meta/journal
>>>> =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 100
>>>> [mon]
>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>> =C2=A0 =C2=A0 =C2=A0 mon data =3D /ceph/dev/mon$id
>>>> [mon.0]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.32:6789
>>>> [mon.1]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.33:6789
>>>> [mon.2]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.35
>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.35:6789
>>>> [osd.0]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>> [osd.1]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>>>> [mds.a]
>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>>
>>>> /dev/sda1 on /ceph type ext4 (rw,barrier=3D0,user_xattr)
>>>> /dev/mapper/system-cephmeta on /ceph/meta type ext4 (rw,barrier=3D=
0,user_xattr)
>>>> Simple performance tests on those fs shows ~133Mb/s for /ceph and
>>>> metadata/. Also both machines do not hold anything else which may
>>>> impact osd.
>>>>
>>>> Also please note of following:
>>>>
>>>> http://i.imgur.com/ZgFdO.png
>>>>
>>>> First two peaks are related to running rados bench, then goes clus=
ter
>>>> recreation, automated debian install and final peaks are dd test.
>>>> Surely I can have more precise graphs, but current one probably en=
ough
>>>> to state a situation - rbd utilizing about a quarter of possible
>>>> bandwidth(if we can count rados bench as 100%).
>>>>
>>>> On Thu, Mar 22, 2012 at 12:39 AM, Samuel Just <sam.just@dreamhost.=
com> wrote:
>>>>> Hmm, there seem to be writes taking as long as 1.5s to hit journa=
l on
>>>>> osd.1... =C2=A0Could you post your ceph.conf? =C2=A0Might there b=
e a problem
>>>>> with the osd.1 journal disk?
>>>>> -Sam
>>>>>
>>>>> On Wed, Mar 21, 2012 at 1:25 PM, Andrey Korolyov <andrey@xdel.ru>=
 wrote:
>>>>>> Oh, sorry - they probably inherited rights from log files, fixed=
=2E
>>>>>>
>>>>>> On Thu, Mar 22, 2012 at 12:17 AM, Samuel Just <sam.just@dreamhos=
t.com> wrote:
>>>>>>> I get 403 Forbidden when I try to download any of the files.
>>>>>>> -Sam
>>>>>>>
>>>>>>> On Wed, Mar 21, 2012 at 11:51 AM, Andrey Korolyov <andrey@xdel.=
ru> wrote:
>>>>>>>> http://xdel.ru/downloads/ceph-logs/
>>>>>>>>
>>>>>>>> 1/ contains logs related to bench initiated at the osd0 machin=
e and 2/
>>>>>>>> - at osd1.
>>>>>>>>
>>>>>>>> On Wed, Mar 21, 2012 at 8:54 PM, Samuel Just <sam.just@dreamho=
st.com> wrote:
>>>>>>>>> Hmm, I'm seeing some very high latency on ops sent to osd.1. =
=C2=A0Can you
>>>>>>>>> post osd.1's logs?
>>>>>>>>> -Sam
>>>>>>>>>
>>>>>>>>> On Wed, Mar 21, 2012 at 3:51 AM, Andrey Korolyov <andrey@xdel=
=2Eru> wrote:
>>>>>>>>>> Here, please: http://xdel.ru/downloads/ceph.log.gz
>>>>>>>>>>
>>>>>>>>>> Sometimes 'cur MB/s ' shows zero during rados bench, even if=
 any debug
>>>>>>>>>> output disabled and log_file set to the empty value, hope it=
`s okay.
>>>>>>>>>>
>>>>>>>>>> On Wed, Mar 21, 2012 at 2:36 AM, Samuel Just <sam.just@dream=
host.com> wrote:
>>>>>>>>>>> Can you set osd and filestore debugging to 20, restart the =
osds, run
>>>>>>>>>>> rados bench as before, and post the logs?
>>>>>>>>>>> -Sam Just
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Mar 20, 2012 at 1:37 PM, Andrey Korolyov <andrey@xd=
el.ru> wrote:
>>>>>>>>>>>> rados bench 60 write -p data
>>>>>>>>>>>> <skip>
>>>>>>>>>>>> Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A061.217676
>>>>>>>>>>>> Total writes made: =C2=A0 =C2=A0 989
>>>>>>>>>>>> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A041943=
04
>>>>>>>>>>>> Bandwidth (MB/sec): =C2=A0 =C2=A064.622
>>>>>>>>>>>>
>>>>>>>>>>>> Average Latency: =C2=A0 =C2=A0 =C2=A0 0.989608
>>>>>>>>>>>> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.21701
>>>>>>>>>>>> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.255315
>>>>>>>>>>>>
>>>>>>>>>>>> Here a snip from osd log, seems write size is okay.
>>>>>>>>>>>>
>>>>>>>>>>>> 2012-03-21 00:00:39.397066 7fdda86a7700 osd.0 10 pg[0.58( =
v 10'83
>>>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=
=3D8 mlcod 10'82
>>>>>>>>>>>> active+clean] =C2=A0removing repgather(0x31b5360 applying =
10'83 rep_tid=3D597
>>>>>>>>>>>> wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2533 rb.0.2.0=
00000000040 [write
>>>>>>>>>>>> 1220608~4096] 0.17eb9fd8) v4)
>>>>>>>>>>>> 2012-03-21 00:00:39.397086 7fdda86a7700 osd.0 10 pg[0.58( =
v 10'83
>>>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=
=3D8 mlcod 10'82
>>>>>>>>>>>> active+clean] =C2=A0 =C2=A0q front is repgather(0x31b5360 =
applying 10'83
>>>>>>>>>>>> rep_tid=3D597 wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0=
:2533
>>>>>>>>>>>> rb.0.2.000000000040 [write 1220608~4096] 0.17eb9fd8) v4)
>>>>>>>>>>>>
>>>>>>>>>>>> Sorry for my previous question about rbd chunks, it was re=
ally stupid :)
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Mar 19, 2012 at 10:40 PM, Josh Durgin <josh.durgin=
@dreamhost.com> wrote:
>>>>>>>>>>>>> On 03/19/2012 11:13 AM, Andrey Korolyov wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Nope, I`m using KVM for rbd guests. Surely I`ve been not=
iced that Sage
>>>>>>>>>>>>>> mentioned too small value and I`ve changed it to 64M bef=
ore posting
>>>>>>>>>>>>>> previous message with no success - both 8M and this valu=
e cause a
>>>>>>>>>>>>>> performance drop. When I tried to wrote small amount of =
data that can
>>>>>>>>>>>>>> be compared to writeback cache size(both on raw device a=
nd ext3 with
>>>>>>>>>>>>>> sync option), following results were made:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I just want to clarify that the writeback window isn't a =
full writeback
>>>>>>>>>>>>> cache - it doesn't affect reads, and does not help with r=
equest merging etc.
>>>>>>>>>>>>> It simply allows a bunch of writes to be in flight while =
acking the write to
>>>>>>>>>>>>> the guest immediately. We're working on a full-fledged wr=
iteback cache that
>>>>>>>>>>>>> to replace the writeback window.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D10 of=
lag=3Ddirect (almost
>>>>>>>>>>>>>> same without oflag there and in the following samples)
>>>>>>>>>>>>>> 10+0 records in
>>>>>>>>>>>>>> 10+0 records out
>>>>>>>>>>>>>> 104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D20 of=
lag=3Ddirect
>>>>>>>>>>>>>> 20+0 records in
>>>>>>>>>>>>>> 20+0 records out
>>>>>>>>>>>>>> 209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D30 of=
lag=3Ddirect
>>>>>>>>>>>>>> 30+0 records in
>>>>>>>>>>>>>> 30+0 records out
>>>>>>>>>>>>>> 314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> and so on. Reference test with bs=3D1M and count=3D2000 =
has slightly worse
>>>>>>>>>>>>>> results _with_ writeback cache than without, as I`ve men=
tioned before.
>>>>>>>>>>>>>> =C2=A0Here the bench results, they`re almost equal on bo=
th nodes:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> bench: wrote 1024 MB in blocks of 4096 KB in 9.037468 se=
c at 113 MB/sec
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> One thing to check is the size of the writes that are act=
ually being sent by
>>>>>>>>>>>>> rbd. The guest is probably splitting them into relatively=
 small (128 or
>>>>>>>>>>>>> 256k) writes. Ideally it would be sending 4k writes, and =
this should be a
>>>>>>>>>>>>> lot faster.
>>>>>>>>>>>>>
>>>>>>>>>>>>> You can see the writes being sent by adding debug_ms=3D1 =
to the client or osd.
>>>>>>>>>>>>> The format is osd_op(.*[write OFFSET~LENGTH]).
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Also, because I`ve not mentioned it before, network perf=
ormance is
>>>>>>>>>>>>>> enough to hold fair gigabit connectivity with MTU 1500. =
Seems that it
>>>>>>>>>>>>>> is not interrupt problem or something like it - even if =
ceph-osd,
>>>>>>>>>>>>>> ethernet card queues and kvm instance pinned to differen=
t sets of
>>>>>>>>>>>>>> cores, nothing changes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
>>>>>>>>>>>>>> <gregory.farnum@dreamhost.com> =C2=A0wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It sounds like maybe you're using Xen? The "rbd writeba=
ck window" option
>>>>>>>>>>>>>>> only works for userspace rbd implementations (eg, KVM).
>>>>>>>>>>>>>>> If you are using KVM, you probably want 81920000 (~80MB=
) rather than
>>>>>>>>>>>>>>> 8192000 (~8MB).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> What options are you running dd with? If you run a rado=
s bench from both
>>>>>>>>>>>>>>> machines, what do the results look like?
>>>>>>>>>>>>>>> Also, can you do the ceph osd bench on each of your OSD=
s, please?
>>>>>>>>>>>>>>> (http://ceph.newdream.net/wiki/Troubleshooting#OSD_perf=
ormance)
>>>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov w=
rote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> More strangely, writing speed drops down by fifteen pe=
rcent when this
>>>>>>>>>>>>>>>> option was set in vm` config(instead of result from
>>>>>>>>>>>>>>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org=
/msg03685.html).
>>>>>>>>>>>>>>>> As I mentioned, I`m using 0.43, but due to crashed osd=
s, ceph has been
>>>>>>>>>>>>>>>> recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd=
55 and
>>>>>>>>>>>>>>>> 1468d95101adfad44247016a1399aab6b86708d2 - both cases =
caused crashes
>>>>>>>>>>>>>>>> under heavy load.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil<sage@newdr=
eam.net
>>>>>>>>>>>>>>>> (mailto:sage@newdream.net)> =C2=A0wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I`ve did some performance tests at the following con=
figuration:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> mon0, osd0 and mon1, osd1 - two twelve-core r410 wit=
h 32G ram, mon2 -
>>>>>>>>>>>>>>>>>> dom0 with three dedicated cores and 1.5G, mostly idl=
e. First three
>>>>>>>>>>>>>>>>>> disks on each r410 arranged into raid0 and holds osd=
 data when fourth
>>>>>>>>>>>>>>>>>> holds os and osd` journal partition, all ceph-relate=
d stuff mounted on
>>>>>>>>>>>>>>>>>> the ext4 without barriers.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Firstly, I`ve noticed about a difference of benchmar=
k performance and
>>>>>>>>>>>>>>>>>> write speed through rbd from small kvm instance runn=
ing on one of
>>>>>>>>>>>>>>>>>> first two machines - when bench gave me about 110Mb/=
s, writing zeros
>>>>>>>>>>>>>>>>>> to raw block device inside vm with dd was at top spe=
ed about 45 mb/s,
>>>>>>>>>>>>>>>>>> for vm`fs (ext4 with default options) performance dr=
ops to ~23Mb/s.
>>>>>>>>>>>>>>>>>> Things get worse, when I`ve started second vm at sec=
ond host and tried
>>>>>>>>>>>>>>>>>> to continue same dd tests simultaneously - performan=
ce fairly divided
>>>>>>>>>>>>>>>>>> by half for each instance :). Enabling jumbo frames,=
 playing with cpu
>>>>>>>>>>>>>>>>>> affinity for ceph and vm instances and trying differ=
ent TCP congestion
>>>>>>>>>>>>>>>>>> protocols gave no effect at all - with DCTCP I have =
slightly smoother
>>>>>>>>>>>>>>>>>> network load graph and that`s all.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Can ml please suggest anything to try to improve per=
formance?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Can you try setting
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> rbd writeback window =3D 8192000
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> or similar, and see what kind of effect that has? I s=
uspect it'll speed
>>>>>>>>>>>>>>>>> up dd; I'm less sure about ext3.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>> sage
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubs=
cribe ceph-devel"
>>>>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/majord=
omo-info.html
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscr=
ibe ceph-devel" in
>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/majordom=
o-info.html
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in
>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majo=
rdomo-info.html
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majord=
omo-info.html
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe c=
eph-devel" in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordo=
mo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
