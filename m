From: Aleksey Samarin <nrg3tik@gmail.com>
Subject: Re: poor performance
Date: Sun, 4 Nov 2012 16:52:43 +0400
Message-ID: <CAFjNkqSAAVo0LCjtdg=OenQND-V+R0v--_ys6bp7RjMCKFK8vQ@mail.gmail.com>
References: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
	<CAPYLRzipAsNdEO6BKrSofPjmWp9F0dL_iH18VaC054TeA=9EBg@mail.gmail.com>
	<CAFjNkqRNv73+n4hUedBjmEmX4OvXHxhbvm51xDx8qJauoQPQ=w@mail.gmail.com>
	<CAPYLRzihkyz+nURHNjKnVBfq10bghWQUpKVVq6cih8ZAqxKi2g@mail.gmail.com>
	<CAFjNkqSjaNUyRdPJhgTKxtTF3UPNRtBVmLPKd+Odu0_zQLOaiA@mail.gmail.com>
	<CAPYLRziTowYWiromOKMc9z0vzv7sf_W3QrHfL3UMV5rzrCYy9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33448 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2KDMwn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 07:52:43 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6820539iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 04:52:43 -0800 (PST)
In-Reply-To: <CAPYLRziTowYWiromOKMc9z0vzv7sf_W3QrHfL3UMV5rzrCYy9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Ryan <mike.ryan@inktank.com>

Ok!
Well, I'll take these tests and write about the results.

btw,
disks are the same, as some may be faster than others?

2012/11/4 Gregory Farnum <greg@inktank.com>:
> That's only nine =97 where are the other three? If you have three slo=
w
> disks that could definitely cause the troubles you're seeing.
>
> Also, what Mark said about sync versus syncfs.
>
> On Sun, Nov 4, 2012 at 1:26 PM, Aleksey Samarin <nrg3tik@gmail.com> w=
rote:
>> It`s ok!
>>
>> Output:
>>
>> 2012-11-04 16:19:23.195891 osd.0 [INF] bench: wrote 1024 MB in block=
s
>> of 4096 KB in 11.441035 sec at 91650 KB/sec
>> 2012-11-04 16:19:24.981631 osd.1 [INF] bench: wrote 1024 MB in block=
s
>> of 4096 KB in 13.225048 sec at 79287 KB/sec
>> 2012-11-04 16:19:25.672896 osd.2 [INF] bench: wrote 1024 MB in block=
s
>> of 4096 KB in 13.917157 sec at 75344 KB/sec
>> 2012-11-04 16:19:28.058517 osd.21 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 16.453375 sec at 63730 KB/sec
>> 2012-11-04 16:19:28.715552 osd.22 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 17.108887 sec at 61288 KB/sec
>> 2012-11-04 16:19:23.440054 osd.23 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 11.834639 sec at 88602 KB/sec
>> 2012-11-04 16:19:24.023650 osd.24 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 12.418276 sec at 84438 KB/sec
>> 2012-11-04 16:19:24.617514 osd.25 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 13.011955 sec at 80585 KB/sec
>> 2012-11-04 16:19:25.148613 osd.26 [INF] bench: wrote 1024 MB in bloc=
ks
>> of 4096 KB in 13.541710 sec at 77433 KB/sec
>>
>> All the best.
>>
>> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>>> [Sorry for the blank email; I missed!]
>>> On Sun, Nov 4, 2012 at 1:04 PM, Aleksey Samarin <nrg3tik@gmail.com>=
 wrote:
>>>> Hi!
>>>> This command? ceph tell osd \* bench
>>>> Output:  tell target 'osd' not a valid entity name
>>>
>>> I guess it's "ceph osd tell \* bench". Try that one. :)
>>>
>>>> Well, i did pool by command ceph osd pool create bench2 120
>>>> This output of rados -p bench2 bench 30 write --no-cleanup
>>>>
>>>> rados -p bench2 bench 30 write --no-cleanup
>>>>
>>>>  Maintaining 16 concurrent writes of 4194304 bytes for at least 30=
 seconds.
>>>>  Object prefix: benchmark_data_host01_5827
>>>>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat  =
 avg lat
>>>>      0       0         0         0         0         0         -  =
       0
>>>>      1      16        29        13   51.9885        52  0.489268  =
0.186749
>>>>      2      16        52        36   71.9866        92   1.87226  =
0.711888
>>>>      3      16        57        41    54.657        20  0.089697  =
0.697821
>>>>      4      16        60        44   43.9923        12   1.61868  =
0.765361
>>>>      5      16        60        44   35.1941         0         -  =
0.765361
>>>>      6      16        60        44   29.3285         0         -  =
0.765361
>>>>      7      16        60        44   25.1388         0         -  =
0.765361
>>>>      8      16        61        45   22.4964         1   5.89643  =
0.879384
>>>>      9      16        62        46   20.4412         4    6.0234  =
0.991211
>>>>     10      16        62        46   18.3971         0         -  =
0.991211
>>>>     11      16        63        47   17.0883         2   8.79749  =
  1.1573
>>>>     12      16        63        47   15.6643         0         -  =
  1.1573
>>>>     13      16        63        47   14.4593         0         -  =
  1.1573
>>>>     14      16        63        47   13.4266         0         -  =
  1.1573
>>>>     15      16        63        47   12.5315         0         -  =
  1.1573
>>>>     16      16        63        47   11.7483         0         -  =
  1.1573
>>>>     17      16        63        47   11.0572         0         -  =
  1.1573
>>>>     18      16        63        47   10.4429         0         -  =
  1.1573
>>>>     19      16        63        47   9.89331         0         -  =
  1.1573
>>>> 2012-11-04 15:58:15.473733min lat: 0.036475 max lat: 8.79749 avg l=
at: 1.1573
>>>>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat  =
 avg lat
>>>>     20      16        63        47   9.39865         0         -  =
  1.1573
>>>>     21      16        63        47   8.95105         0         -  =
  1.1573
>>>>     22      16        63        47   8.54419         0         -  =
  1.1573
>>>>     23      16        63        47   8.17271         0         -  =
  1.1573
>>>>     24      16        63        47   7.83218         0         -  =
  1.1573
>>>>     25      16        63        47    7.5189         0         -  =
  1.1573
>>>>     26      16        63        47   7.22972         0         -  =
  1.1573
>>>>     27      16        81        65   9.62824       4.5  0.076456  =
  4.9428
>>>>     28      16       118       102   14.5693       148  0.427273  =
 4.34095
>>>>     29      16       119       103   14.2049         4   1.57897  =
 4.31414
>>>>     30      16       132       116   15.4645        52   2.25424  =
 4.01492
>>>>     31      16       133       117   15.0946         4  0.974652  =
 3.98893
>>>>     32      16       133       117   14.6229         0         -  =
 3.98893
>>>>  Total time run:         32.575351
>>>> Total writes made:      133
>>>> Write size:             4194304
>>>> Bandwidth (MB/sec):     16.331
>>>>
>>>> Stddev Bandwidth:       31.8794
>>>> Max bandwidth (MB/sec): 148
>>>> Min bandwidth (MB/sec): 0
>>>> Average Latency:        3.91583
>>>> Stddev Latency:         7.42821
>>>> Max latency:            25.24
>>>> Min latency:            0.036475
>>>>
>>>> Im think problem not in pg. This output of ceph pg dump  >
>>>> http://pastebin.com/BqLsyMBC
>>>
>>> Well, that did improve it a bit; but yes, I think there's something
>>> else going on. Just wanted to verify. :)
>>>
>>>>
>>>> I have still no idea.
>>>>
>>>> All the best. Alex
>>>>
>>>>
>>>>
>>>> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>>>>> On Sun, Nov 4, 2012 at 10:58 AM, Aleksey Samarin <nrg3tik@gmail.c=
om> wrote:
>>>>>> Hi all
>>>>>>
>>>>>> Im planning use ceph for cloud storage.
>>>>>> My test setup is 2 servers connected via infiniband 40Gb, 6x2Tb =
disks per node.
>>>>>> Centos 6.2
>>>>>> Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
>>>>>> This is my config http://pastebin.com/Pzxafnsm
>>>>>> journal on tmpfs
>>>>>> well, im create bench pool and test it:
>>>>>> ceph osd pool create bench
>>>>>> rados -p bench bench 30 write
>>>>>>
>>>>>>  Total time run:         43.258228
>>>>>>  Total writes made:      151
>>>>>>  Write size:             4194304
>>>>>>  Bandwidth (MB/sec):     13.963
>>>>>>  Stddev Bandwidth:       26.307
>>>>>>  Max bandwidth (MB/sec): 128
>>>>>>  Min bandwidth (MB/sec): 0
>>>>>>  Average Latency:        4.48605
>>>>>>  Stddev Latency:         8.17709
>>>>>>  Max latency:            29.7957
>>>>>>  Min latency:            0.039435
>>>>>>
>>>>>> when i do rados -p bench bench 30 seq
>>>>>>  Total time run:        20.626935
>>>>>>  Total reads made:     275
>>>>>>  Read size:            4194304
>>>>>>  Bandwidth (MB/sec):    53.328
>>>>>>  Average Latency:       1.19754
>>>>>>  Max latency:           7.0215
>>>>>>  Min latency:           0.011647
>>>>>>
>>>>>> I tested the single drive via dd if=3D/dev/zero of=3D/mnt/hdd2/t=
estfile
>>>>>> bs=3D1024k count=3D20000
>>>>>> result:  158 MB/sec
>>>>>>
>>>>>> Anyone can tell me why such a weak performance? Maybe I missed s=
omething?
>>>>>
>>>>> Can you run "ceph tell osd \* bench" and report the results? (It'=
ll go
>>>>> to the "central log" which you can keep an eye on if you run "cep=
h -w"
>>>>> in another terminal.)
>>>>> I think you also didn't create your bench pool correctly; it prob=
ably
>>>>> only has 8 PGs which is not going to perform very well with your =
disk
>>>>> count. Try "ceph pool create bench2 120" and run the benchmark ag=
ainst
>>>>> that pool. The extra number at the end tells it to create 120
>>>>> placement groups.
>>>>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
