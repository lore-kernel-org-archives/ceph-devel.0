From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Mysteriously poor write performance
Date: Fri, 23 Mar 2012 10:53:26 -0700
Message-ID: <CACLRD_1VTMtfdwHrX5nR+G-Qrnyc9jB95Dt_f9Oa63K0Ye2PzA@mail.gmail.com>
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
	<CACLRD_0CxGWdMerehzAd4yko3COeufZFhGPE-v7QOmMs7fSvYg@mail.gmail.com>
	<CABYiri-j3DAraN37FDZSEuKi127rTz8WvbTDizkZ+BwfXeVSmQ@mail.gmail.com>
	<CABYiri9SYaTFgb7GMPi_VPT1vDWV+O=Q_P-xibsBb-xjRU1E=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43179 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab2CWRx2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 13:53:28 -0400
Received: by wejx9 with SMTP id x9so2840251wej.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Mar 2012 10:53:26 -0700 (PDT)
In-Reply-To: <CABYiri9SYaTFgb7GMPi_VPT1vDWV+O=Q_P-xibsBb-xjRU1E=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

(CCing the list)

Actually, can you could re-do the rados bench run with 'debug journal
=3D 20' along with the other debugging?  That should give us better
information.

-Sam

On Fri, Mar 23, 2012 at 5:25 AM, Andrey Korolyov <andrey@xdel.ru> wrote=
:
> Hi Sam,
>
> Can you please suggest on where to start profiling osd? If the
> bottleneck has related to such non-complex things as directio speed,
> I`m sure that I was able to catch it long ago, even crossing around b=
y
> results of other types of benchmarks at host system. I`ve just tried
> tmpfs under both journals, it has a small boost effect, as expected
> because of near-zero i/o delay. May be chunk distribution mechanism
> does not work well on such small amount of nodes but right now I don`=
t
> have necessary amount of hardware nodes to prove or disprove that.
>
> On Thu, Mar 22, 2012 at 10:40 PM, Andrey Korolyov <andrey@xdel.ru> wr=
ote:
>> random-rw: (g=3D0): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3Dsync, i=
odepth=3D2
>> Starting 1 process
>> Jobs: 1 (f=3D1): [W] [100.0% done] [0K/35737K /s] [0/8725 iops] [eta=
 00m:00s]
>> random-rw: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D9647
>> =C2=A0write: io=3D163840KB, bw=3D37760KB/s, iops=3D9439, runt=3D =C2=
=A04339msec
>> =C2=A0 =C2=A0clat (usec): min=3D70, max=3D39801, avg=3D104.19, stdev=
=3D324.29
>> =C2=A0 =C2=A0bw (KB/s) : min=3D30480, max=3D43312, per=3D98.83%, avg=
=3D37317.00, stdev=3D5770.28
>> =C2=A0cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D1.84%, sys=3D13.=
00%, ctx=3D40961, majf=3D0, minf=3D26
>> =C2=A0IO depths =C2=A0 =C2=A0: 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0=
=2E0%, 16=3D0.0%, 32=3D0.0%, >=3D64=3D0.0%
>> =C2=A0 =C2=A0 submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, =
16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
>> =C2=A0 =C2=A0 complete =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D=
0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
>> =C2=A0 =C2=A0 issued r/w: total=3D0/40960, short=3D0/0
>> =C2=A0 =C2=A0 lat (usec): 100=3D79.69%, 250=3D19.89%, 500=3D0.12%, 7=
50=3D0.12%, 1000=3D0.11%
>> =C2=A0 =C2=A0 lat (msec): 2=3D0.01%, 4=3D0.01%, 10=3D0.03%, 20=3D0.0=
1%, 50=3D0.01%
>>
>>
>> On Thu, Mar 22, 2012 at 9:26 PM, Samuel Just <sam.just@dreamhost.com=
> wrote:
>>> Our journal writes are actually sequential. =C2=A0Could you send FI=
O
>>> results for sequential 4k writes osd.0's journal and osd.1's journa=
l?
>>> -Sam
>>>
>>> On Thu, Mar 22, 2012 at 5:21 AM, Andrey Korolyov <andrey@xdel.ru> w=
rote:
>>>> FIO output for journal partition, directio enabled, seems good(sam=
e
>>>> results for ext4 on other single sata disks).
>>>>
>>>> random-rw: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Ds=
ync, iodepth=3D2
>>>> Starting 1 process
>>>> Jobs: 1 (f=3D1): [w] [100.0% done] [0K/3219K /s] [0/786 iops] [eta=
 00m:00s]
>>>> random-rw: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D21926
>>>> =C2=A0write: io=3D163840KB, bw=3D2327KB/s, iops=3D581, runt=3D 704=
03msec
>>>> =C2=A0 =C2=A0clat (usec): min=3D122, max=3D441551, avg=3D1714.52, =
stdev=3D7565.04
>>>> =C2=A0 =C2=A0bw (KB/s) : min=3D =C2=A0552, max=3D 3880, per=3D100.=
61%, avg=3D2341.23, stdev=3D480.05
>>>> =C2=A0cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D0.42%, sys=3D1=
=2E34%, ctx=3D40976, majf=3D0, minf=3D42
>>>> =C2=A0IO depths =C2=A0 =C2=A0: 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D=
0.0%, 16=3D0.0%, 32=3D0.0%, >=3D64=3D0.0%
>>>> =C2=A0 =C2=A0 submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%=
, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
>>>> =C2=A0 =C2=A0 complete =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D=
0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0%
>>>> =C2=A0 =C2=A0 issued r/w: total=3D0/40960, short=3D0/0
>>>> =C2=A0 =C2=A0 lat (usec): 250=3D31.70%, 500=3D0.68%, 750=3D0.10%, =
1000=3D0.63%
>>>> =C2=A0 =C2=A0 lat (msec): 2=3D41.31%, 4=3D20.91%, 10=3D4.40%, 20=3D=
0.17%, 50=3D0.07%
>>>> =C2=A0 =C2=A0 lat (msec): 500=3D0.04%
>>>>
>>>>
>>>>
>>>> On Thu, Mar 22, 2012 at 1:20 AM, Samuel Just <sam.just@dreamhost.c=
om> wrote:
>>>>> (CCing the list)
>>>>>
>>>>> So, the problem isn't the bandwidth. =C2=A0Before we respond to t=
he client,
>>>>> we write the operation to the journal. =C2=A0In this case, that o=
peration
>>>>> is taking >1s per operation on osd.1. =C2=A0Both rbd and rados be=
nch will
>>>>> only allow a limited number of ops in flight at a time, so this
>>>>> latency is killing your throughput. =C2=A0For comparison, the lat=
ency for
>>>>> writing to the journal on osd.0 is < .3s. =C2=A0Can you measure d=
irect io
>>>>> latency for writes to your osd.1 journal file?
>>>>> -Sam
>>>>>
>>>>> On Wed, Mar 21, 2012 at 1:56 PM, Andrey Korolyov <andrey@xdel.ru>=
 wrote:
>>>>>> Oh, you may confuse with Zabbix metrics - y-axis means Megabytes=
/s,
>>>>>> not Megabits.
>>>>>>
>>>>>> On Thu, Mar 22, 2012 at 12:53 AM, Andrey Korolyov <andrey@xdel.r=
u> wrote:
>>>>>>> [global]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 log dir =3D /ceph/out
>>>>>>> =C2=A0 =C2=A0 =C2=A0 log_file =3D ""
>>>>>>> =C2=A0 =C2=A0 =C2=A0 logger dir =3D /ceph/log
>>>>>>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$type$id.pid
>>>>>>> [mds]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 pid file =3D /ceph/out/$name.pid
>>>>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 mds log max segments =3D 2
>>>>>>> [osd]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 filestore_xattr_use_omap =3D 1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 osd data =3D /ceph/dev/osd$id
>>>>>>> =C2=A0 =C2=A0 =C2=A0 osd journal =3D /ceph/meta/journal
>>>>>>> =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 100
>>>>>>> [mon]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 lockdep =3D 1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 mon data =3D /ceph/dev/mon$id
>>>>>>> [mon.0]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.32:6789
>>>>>>> [mon.1]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>>>>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.33:6789
>>>>>>> [mon.2]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.35
>>>>>>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 172.20.1.35:6789
>>>>>>> [osd.0]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>>>>> [osd.1]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.33
>>>>>>> [mds.a]
>>>>>>> =C2=A0 =C2=A0 =C2=A0 host =3D 172.20.1.32
>>>>>>>
>>>>>>> /dev/sda1 on /ceph type ext4 (rw,barrier=3D0,user_xattr)
>>>>>>> /dev/mapper/system-cephmeta on /ceph/meta type ext4 (rw,barrier=
=3D0,user_xattr)
>>>>>>> Simple performance tests on those fs shows ~133Mb/s for /ceph a=
nd
>>>>>>> metadata/. Also both machines do not hold anything else which m=
ay
>>>>>>> impact osd.
>>>>>>>
>>>>>>> Also please note of following:
>>>>>>>
>>>>>>> http://i.imgur.com/ZgFdO.png
>>>>>>>
>>>>>>> First two peaks are related to running rados bench, then goes c=
luster
>>>>>>> recreation, automated debian install and final peaks are dd tes=
t.
>>>>>>> Surely I can have more precise graphs, but current one probably=
 enough
>>>>>>> to state a situation - rbd utilizing about a quarter of possibl=
e
>>>>>>> bandwidth(if we can count rados bench as 100%).
>>>>>>>
>>>>>>> On Thu, Mar 22, 2012 at 12:39 AM, Samuel Just <sam.just@dreamho=
st.com> wrote:
>>>>>>>> Hmm, there seem to be writes taking as long as 1.5s to hit jou=
rnal on
>>>>>>>> osd.1... =C2=A0Could you post your ceph.conf? =C2=A0Might ther=
e be a problem
>>>>>>>> with the osd.1 journal disk?
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Wed, Mar 21, 2012 at 1:25 PM, Andrey Korolyov <andrey@xdel.=
ru> wrote:
>>>>>>>>> Oh, sorry - they probably inherited rights from log files, fi=
xed.
>>>>>>>>>
>>>>>>>>> On Thu, Mar 22, 2012 at 12:17 AM, Samuel Just <sam.just@dream=
host.com> wrote:
>>>>>>>>>> I get 403 Forbidden when I try to download any of the files.
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Wed, Mar 21, 2012 at 11:51 AM, Andrey Korolyov <andrey@xd=
el.ru> wrote:
>>>>>>>>>>> http://xdel.ru/downloads/ceph-logs/
>>>>>>>>>>>
>>>>>>>>>>> 1/ contains logs related to bench initiated at the osd0 mac=
hine and 2/
>>>>>>>>>>> - at osd1.
>>>>>>>>>>>
>>>>>>>>>>> On Wed, Mar 21, 2012 at 8:54 PM, Samuel Just <sam.just@drea=
mhost.com> wrote:
>>>>>>>>>>>> Hmm, I'm seeing some very high latency on ops sent to osd.=
1. =C2=A0Can you
>>>>>>>>>>>> post osd.1's logs?
>>>>>>>>>>>> -Sam
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Mar 21, 2012 at 3:51 AM, Andrey Korolyov <andrey@x=
del.ru> wrote:
>>>>>>>>>>>>> Here, please: http://xdel.ru/downloads/ceph.log.gz
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sometimes 'cur MB/s ' shows zero during rados bench, even=
 if any debug
>>>>>>>>>>>>> output disabled and log_file set to the empty value, hope=
 it`s okay.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Wed, Mar 21, 2012 at 2:36 AM, Samuel Just <sam.just@dr=
eamhost.com> wrote:
>>>>>>>>>>>>>> Can you set osd and filestore debugging to 20, restart t=
he osds, run
>>>>>>>>>>>>>> rados bench as before, and post the logs?
>>>>>>>>>>>>>> -Sam Just
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Mar 20, 2012 at 1:37 PM, Andrey Korolyov <andrey=
@xdel.ru> wrote:
>>>>>>>>>>>>>>> rados bench 60 write -p data
>>>>>>>>>>>>>>> <skip>
>>>>>>>>>>>>>>> Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A061.217676
>>>>>>>>>>>>>>> Total writes made: =C2=A0 =C2=A0 989
>>>>>>>>>>>>>>> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A041=
94304
>>>>>>>>>>>>>>> Bandwidth (MB/sec): =C2=A0 =C2=A064.622
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Average Latency: =C2=A0 =C2=A0 =C2=A0 0.989608
>>>>>>>>>>>>>>> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.21701
>>>>>>>>>>>>>>> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.25531=
5
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Here a snip from osd log, seems write size is okay.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 2012-03-21 00:00:39.397066 7fdda86a7700 osd.0 10 pg[0.5=
8( v 10'83
>>>>>>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 =
lpr=3D8 mlcod 10'82
>>>>>>>>>>>>>>> active+clean] =C2=A0removing repgather(0x31b5360 applyi=
ng 10'83 rep_tid=3D597
>>>>>>>>>>>>>>> wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2533 rb.0.=
2.000000000040 [write
>>>>>>>>>>>>>>> 1220608~4096] 0.17eb9fd8) v4)
>>>>>>>>>>>>>>> 2012-03-21 00:00:39.397086 7fdda86a7700 osd.0 10 pg[0.5=
8( v 10'83
>>>>>>>>>>>>>>> (0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 =
lpr=3D8 mlcod 10'82
>>>>>>>>>>>>>>> active+clean] =C2=A0 =C2=A0q front is repgather(0x31b53=
60 applying 10'83
>>>>>>>>>>>>>>> rep_tid=3D597 wfack=3D wfdisk=3D op=3Dosd_op(client.459=
9.0:2533
>>>>>>>>>>>>>>> rb.0.2.000000000040 [write 1220608~4096] 0.17eb9fd8) v4=
)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Sorry for my previous question about rbd chunks, it was=
 really stupid :)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Mon, Mar 19, 2012 at 10:40 PM, Josh Durgin <josh.dur=
gin@dreamhost.com> wrote:
>>>>>>>>>>>>>>>> On 03/19/2012 11:13 AM, Andrey Korolyov wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Nope, I`m using KVM for rbd guests. Surely I`ve been =
noticed that Sage
>>>>>>>>>>>>>>>>> mentioned too small value and I`ve changed it to 64M =
before posting
>>>>>>>>>>>>>>>>> previous message with no success - both 8M and this v=
alue cause a
>>>>>>>>>>>>>>>>> performance drop. When I tried to wrote small amount =
of data that can
>>>>>>>>>>>>>>>>> be compared to writeback cache size(both on raw devic=
e and ext3 with
>>>>>>>>>>>>>>>>> sync option), following results were made:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I just want to clarify that the writeback window isn't=
 a full writeback
>>>>>>>>>>>>>>>> cache - it doesn't affect reads, and does not help wit=
h request merging etc.
>>>>>>>>>>>>>>>> It simply allows a bunch of writes to be in flight whi=
le acking the write to
>>>>>>>>>>>>>>>> the guest immediately. We're working on a full-fledged=
 writeback cache that
>>>>>>>>>>>>>>>> to replace the writeback window.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D10=
 oflag=3Ddirect (almost
>>>>>>>>>>>>>>>>> same without oflag there and in the following samples=
)
>>>>>>>>>>>>>>>>> 10+0 records in
>>>>>>>>>>>>>>>>> 10+0 records out
>>>>>>>>>>>>>>>>> 104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
>>>>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D20=
 oflag=3Ddirect
>>>>>>>>>>>>>>>>> 20+0 records in
>>>>>>>>>>>>>>>>> 20+0 records out
>>>>>>>>>>>>>>>>> 209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
>>>>>>>>>>>>>>>>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D30=
 oflag=3Ddirect
>>>>>>>>>>>>>>>>> 30+0 records in
>>>>>>>>>>>>>>>>> 30+0 records out
>>>>>>>>>>>>>>>>> 314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> and so on. Reference test with bs=3D1M and count=3D20=
00 has slightly worse
>>>>>>>>>>>>>>>>> results _with_ writeback cache than without, as I`ve =
mentioned before.
>>>>>>>>>>>>>>>>> =C2=A0Here the bench results, they`re almost equal on=
 both nodes:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> bench: wrote 1024 MB in blocks of 4096 KB in 9.037468=
 sec at 113 MB/sec
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> One thing to check is the size of the writes that are =
actually being sent by
>>>>>>>>>>>>>>>> rbd. The guest is probably splitting them into relativ=
ely small (128 or
>>>>>>>>>>>>>>>> 256k) writes. Ideally it would be sending 4k writes, a=
nd this should be a
>>>>>>>>>>>>>>>> lot faster.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> You can see the writes being sent by adding debug_ms=3D=
1 to the client or osd.
>>>>>>>>>>>>>>>> The format is osd_op(.*[write OFFSET~LENGTH]).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Also, because I`ve not mentioned it before, network p=
erformance is
>>>>>>>>>>>>>>>>> enough to hold fair gigabit connectivity with MTU 150=
0. Seems that it
>>>>>>>>>>>>>>>>> is not interrupt problem or something like it - even =
if ceph-osd,
>>>>>>>>>>>>>>>>> ethernet card queues and kvm instance pinned to diffe=
rent sets of
>>>>>>>>>>>>>>>>> cores, nothing changes.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
>>>>>>>>>>>>>>>>> <gregory.farnum@dreamhost.com> =C2=A0wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> It sounds like maybe you're using Xen? The "rbd writ=
eback window" option
>>>>>>>>>>>>>>>>>> only works for userspace rbd implementations (eg, KV=
M).
>>>>>>>>>>>>>>>>>> If you are using KVM, you probably want 81920000 (~8=
0MB) rather than
>>>>>>>>>>>>>>>>>> 8192000 (~8MB).
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> What options are you running dd with? If you run a r=
ados bench from both
>>>>>>>>>>>>>>>>>> machines, what do the results look like?
>>>>>>>>>>>>>>>>>> Also, can you do the ceph osd bench on each of your =
OSDs, please?
>>>>>>>>>>>>>>>>>> (http://ceph.newdream.net/wiki/Troubleshooting#OSD_p=
erformance)
>>>>>>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyo=
v wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> More strangely, writing speed drops down by fifteen=
 percent when this
>>>>>>>>>>>>>>>>>>> option was set in vm` config(instead of result from
>>>>>>>>>>>>>>>>>>> http://www.mail-archive.com/ceph-devel@vger.kernel.=
org/msg03685.html).
>>>>>>>>>>>>>>>>>>> As I mentioned, I`m using 0.43, but due to crashed =
osds, ceph has been
>>>>>>>>>>>>>>>>>>> recompiled with e43546dee9246773ffd6877b4f9495f1ec6=
1cd55 and
>>>>>>>>>>>>>>>>>>> 1468d95101adfad44247016a1399aab6b86708d2 - both cas=
es caused crashes
>>>>>>>>>>>>>>>>>>> under heavy load.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil<sage@ne=
wdream.net
>>>>>>>>>>>>>>>>>>> (mailto:sage@newdream.net)> =C2=A0wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I`ve did some performance tests at the following =
configuration:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> mon0, osd0 and mon1, osd1 - two twelve-core r410 =
with 32G ram, mon2 -
>>>>>>>>>>>>>>>>>>>>> dom0 with three dedicated cores and 1.5G, mostly =
idle. First three
>>>>>>>>>>>>>>>>>>>>> disks on each r410 arranged into raid0 and holds =
osd data when fourth
>>>>>>>>>>>>>>>>>>>>> holds os and osd` journal partition, all ceph-rel=
ated stuff mounted on
>>>>>>>>>>>>>>>>>>>>> the ext4 without barriers.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Firstly, I`ve noticed about a difference of bench=
mark performance and
>>>>>>>>>>>>>>>>>>>>> write speed through rbd from small kvm instance r=
unning on one of
>>>>>>>>>>>>>>>>>>>>> first two machines - when bench gave me about 110=
Mb/s, writing zeros
>>>>>>>>>>>>>>>>>>>>> to raw block device inside vm with dd was at top =
speed about 45 mb/s,
>>>>>>>>>>>>>>>>>>>>> for vm`fs (ext4 with default options) performance=
 drops to ~23Mb/s.
>>>>>>>>>>>>>>>>>>>>> Things get worse, when I`ve started second vm at =
second host and tried
>>>>>>>>>>>>>>>>>>>>> to continue same dd tests simultaneously - perfor=
mance fairly divided
>>>>>>>>>>>>>>>>>>>>> by half for each instance :). Enabling jumbo fram=
es, playing with cpu
>>>>>>>>>>>>>>>>>>>>> affinity for ceph and vm instances and trying dif=
ferent TCP congestion
>>>>>>>>>>>>>>>>>>>>> protocols gave no effect at all - with DCTCP I ha=
ve slightly smoother
>>>>>>>>>>>>>>>>>>>>> network load graph and that`s all.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Can ml please suggest anything to try to improve =
performance?
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Can you try setting
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> rbd writeback window =3D 8192000
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> or similar, and see what kind of effect that has? =
I suspect it'll speed
>>>>>>>>>>>>>>>>>>>> up dd; I'm less sure about ext3.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>>>>> sage
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>>>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "uns=
ubscribe ceph-devel"
>>>>>>>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.or=
g
>>>>>>>>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/maj=
ordomo-info.html
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsub=
scribe ceph-devel" in
>>>>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>>>>>>>>>>>>>>> More majordomo info at http://vger.kernel.org/major=
domo-info.html
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubsc=
ribe ceph-devel" in
>>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/m=
ajordomo-info.html
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscri=
be ceph-devel" in
>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/maj=
ordomo-info.html
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in
>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majo=
rdomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
