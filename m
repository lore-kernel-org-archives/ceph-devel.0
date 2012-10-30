From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph performance
Date: Tue, 30 Oct 2012 11:14:57 +0100
Message-ID: <CAPYLRzhvhFqpw3WfhwQy7bALVT8rLLQnu7HPdUh10wzCAaGkrg@mail.gmail.com>
References: <508E8C1C.4020605@gmail.com>
	<508ED184.50203@inktank.com>
	<508F8F8D.7010107@gmail.com>
	<CAPYLRzhfv08vS0CNEHP2d6+M1FpwNDgtU28DTYn9vjFmLnP9XA@mail.gmail.com>
	<508FA648.1060401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57291 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab2J3KO6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 06:14:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so94409iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 03:14:57 -0700 (PDT)
In-Reply-To: <508FA648.1060401@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Sam Lang <sam.lang@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Oct 30, 2012 at 11:04 AM, Roman Alekseev <rs.alekseev@gmail.com=
> wrote:
> On 30.10.2012 13:10, Gregory Farnum wrote:
>>
>> On Tue, Oct 30, 2012 at 9:27 AM, Roman Alekseev <rs.alekseev@gmail.c=
om>
>> wrote:
>>>
>>> On 29.10.2012 22:57, Sam Lang wrote:
>>>>
>>>>
>>>> Hi Roman,
>>>>
>>>> Is this with the ceph fuse client or the ceph kernel module?
>>>>
>>>> Its not surprising that the local file system (/home) is so much f=
aster
>>>> than a mounted ceph volume, especially the first time the director=
y tree
>>>> is
>>>> traversed (metadata results are cached at the client to improve
>>>> performance).  Try running the same find command on the ceph volum=
e and
>>>> see
>>>> if the cached results at the client improve performance at all.
>>>>
>>>> In order to understand what the performance of ceph should be capa=
ble of
>>>> doing with your deployment for this specific workload, you should =
run
>>>> iperf
>>>> between two nodes to get an idea of your latency limits.
>>>>
>>>> Also, I noticed that the real timings you listed for ceph and /hom=
e are
>>>> offset by exactly 17 minutes (user and sys are identical).  Was th=
at a
>>>> copy/paste error, by chance?
>>>>
>>>> -sam
>>>>
>>>> On 10/29/2012 09:01 AM, Roman Alekseev wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Kindly guide me how to improve performance on the cluster which c=
onsist
>>>>> of 5 dedicated servers:
>>>>>
>>>>> - ceph.conf: http://pastebin.com/hT3qEhUF
>>>>> - file system on all drives is ext4
>>>>> - mount options "user_xattr"
>>>>> - each server has :
>>>>> CPU:Intel=AE Xeon=AE Processor E5335(8M Cache, 2.00 GHz, 1333 MHz=
 FSB) x2
>>>>> MEM: 4Gb DDR2
>>>>> - 1Gb network
>>>>>
>>>>> Simple test:
>>>>>
>>>>> mounted as ceph
>>>>> root@client1:/mnt/mycephfs# time find . | wc -l
>>>>> 83932
>>>>>
>>>>> real    17m55.399s
>>>>> user    0m0.152s
>>>>> sys    0m1.528s
>>>>>
>>>>> on 1 HDD:
>>>>>
>>>>> root@client1:/home# time find . | wc -l
>>>>> 83932
>>>>>
>>>>> real    0m55.399s
>>>>> user    0m0.152s
>>>>> sys    0m1.528s
>>>>>
>>>>> Please help me to find out the issue. Thanks.
>>>>>
>>> Hi Sam,
>>>
>>>      I use the Ceph fs only as kernel module, because we need to ge=
t its
>>> powerful performance but as I can see it is slower then distributed=
 file
>>> system based on fuse, for example, MooseFS performed the same test =
for 3
>>> min.
>>> Here is the result iperf test beetwen client and osd server:
>>> root@asrv151:~# iperf -c client -i 1
>>> ------------------------------------------------------------
>>> Client connecting to clientIP, TCP port 5001
>>> TCP window size: 96.1 KByte (default)
>>> ------------------------------------------------------------
>>> [  3] local osd_server port 50106 connected with clientIP port 5001
>>> [ ID] Interval       Transfer     Bandwidth
>>> [  3]  0.0- 1.0 sec    112 MBytes    941 Mbits/sec
>>> [  3]  1.0- 2.0 sec    110 MBytes    924 Mbits/sec
>>> [  3]  2.0- 3.0 sec    108 MBytes    905 Mbits/sec
>>> [  3]  3.0- 4.0 sec    109 MBytes    917 Mbits/sec
>>> [  3]  4.0- 5.0 sec    110 MBytes    926 Mbits/sec
>>> [  3]  5.0- 6.0 sec    109 MBytes    915 Mbits/sec
>>> [  3]  6.0- 7.0 sec    110 MBytes    926 Mbits/sec
>>> [  3]  7.0- 8.0 sec    108 MBytes    908 Mbits/sec
>>> [  3]  8.0- 9.0 sec    107 MBytes    897 Mbits/sec
>>> [  3]  9.0-10.0 sec    106 MBytes    886 Mbits/sec
>>> [  3]  0.0-10.0 sec  1.06 GBytes    914 Mbits/sec
>>>
>>> ceph -w results:
>>>
>>>   health HEALTH_OK
>>>     monmap e3: 3 mons at {a=3Dmon.a:6789/0,b=3Dmon.b:6789/0,c=3Dmon=
=2Ec:6789/0},
>>> election epoch 10, quorum 0,1,2 a,b,c
>>>     osdmap e132: 5 osds: 5 up, 5 in
>>>      pgmap v11720: 384 pgs: 384 active+clean; 1880 MB data, 10679 M=
B
>>> used,
>>> 5185 GB / 5473 GB avail
>>>     mdsmap e4: 1/1/1 up {0=3Da=3Dup:active}
>>>
>>> 2012-10-30 12:23:09.830677 osd.2 [WRN] slow request 30.135787 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:39.694780: osd_op(mds.0.1:309216
>>> 10000017163.00000000 [setxattr path (69),setxattr parent (196),tmap=
put
>>> 0~596] 1.724c80f7) v4 currently waiting for sub ops
>>> 2012-10-30 12:23:10.109637 mon.0 [INF] pgmap v11720: 384 pgs: 384
>>> active+clean; 1880 MB data, 10679 MB used, 5185 GB / 5473 GB avail
>>> 2012-10-30 12:23:12.918038 mon.0 [INF] pgmap v11721: 384 pgs: 384
>>> active+clean; 1880 MB data, 10680 MB used, 5185 GB / 5473 GB avail
>>> 2012-10-30 12:23:13.977044 mon.0 [INF] pgmap v11722: 384 pgs: 384
>>> active+clean; 1880 MB data, 10681 MB used, 5185 GB / 5473 GB avail
>>> 2012-10-30 12:23:10.587391 osd.3 [WRN] 6 slow requests, 6 included =
below;
>>> oldest blocked for > 30.808352 secs
>>> 2012-10-30 12:23:10.587398 osd.3 [WRN] slow request 30.808352 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:39.778971: osd_op(mds.0.1:308701
>>> 200.000002e5
>>> [write 976010~5402] 1.adbeb1a) v4 currently waiting for sub ops
>>> 2012-10-30 12:23:10.587403 osd.3 [WRN] slow request 30.796417 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:39.790906: osd_op(mds.0.1:308702
>>> 200.000002e5
>>> [write 981412~6019] 1.adbeb1a) v4 currently waiting for sub ops
>>> 2012-10-30 12:23:10.587408 osd.3 [WRN] slow request 30.796347 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:39.790976: osd_op(mds.0.1:308703
>>> 200.000002e5
>>> [write 987431~61892] 1.adbeb1a) v4 currently waiting for sub ops
>>> 2012-10-30 12:23:10.587413 osd.3 [WRN] slow request 30.530228 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:40.057095: osd_op(mds.0.1:308704
>>> 200.000002e5
>>> [write 1049323~6630] 1.adbeb1a) v4 currently waiting for sub ops
>>> 2012-10-30 12:23:10.587417 osd.3 [WRN] slow request 30.530027 secon=
ds
>>> old,
>>> received at 2012-10-30 12:22:40.057296: osd_op(mds.0.1:308705
>>> 200.000002e5
>>> [write 1055953~20679] 1.adbeb1a) v4 currently waiting for sub ops
>>>
>>>
>>> At the same time I'm copy data to ceph mounted storage.
>>>
>>> I dunno what can I do to resolve this problem :(
>>> Any advices will be greatly appreciated.
>>
>> Is it the same client copying data into cephfs or a different one?
>> I see here that you have several slow requests; it looks like maybe
>> you're overloading your disks. That could impact metadata lookups if
>> the MDS doesn't have everything cached; have you tried running this
>> test without data ingest? (Obviously we'd like it to be faster even
>> so, but if it's disk contention there's not a lot we can do.)
>> -Greg
>
> Dear Greg,
>
> Yes, this was the same client. Sorry, could you please explain me wit=
h more
> details how can I "test without data ingest"?

You said you were copying data into the cluster while doing this test.
It really shouldn't matter, but if you had enough activity going
on...it might. :/

> Also I can rebuild my cluster from scratch and make all tests again.
>
> I have 5 dedicated servers and I think if I create ceph cluster from =
them it
> shouldn't be slower then the same cluster based on fuse technology. A=
m I
> right?
Well, the cluster isn't really based on FUSE technology, that's just
the client. You're certainly seeing slower performance than I expect,
but Ceph is doing two copies of every write and I think MooseFS
defaults to one, for instance.
I'm concerned in particular about those "slow write" warnings, which
tend to indicate your data disks are overloaded. Can you share your
ceph.conf and your hardware configuration?
When you're done copying data into the cluster, can you also run
"rados -p data bench 60 write" and report the results back?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
