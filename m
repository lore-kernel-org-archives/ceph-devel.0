From: Gregory Farnum <greg@inktank.com>
Subject: Re: poor performance
Date: Thu, 15 Nov 2012 13:16:32 -0800
Message-ID: <CAPYLRzgOWhtKv-VWx-j9_tnraNHC+xevmJYMQGSRAMpzmQrKzA@mail.gmail.com>
References: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
	<CAPYLRzipAsNdEO6BKrSofPjmWp9F0dL_iH18VaC054TeA=9EBg@mail.gmail.com>
	<CAFjNkqRNv73+n4hUedBjmEmX4OvXHxhbvm51xDx8qJauoQPQ=w@mail.gmail.com>
	<CAPYLRzihkyz+nURHNjKnVBfq10bghWQUpKVVq6cih8ZAqxKi2g@mail.gmail.com>
	<CAFjNkqSjaNUyRdPJhgTKxtTF3UPNRtBVmLPKd+Odu0_zQLOaiA@mail.gmail.com>
	<CAPYLRziTowYWiromOKMc9z0vzv7sf_W3QrHfL3UMV5rzrCYy9g@mail.gmail.com>
	<CAFjNkqSAAVo0LCjtdg=OenQND-V+R0v--_ys6bp7RjMCKFK8vQ@mail.gmail.com>
	<CAFjNkqR+cttZRhc5zmff5p+=42hMzMOvp_YXxBtUkWs-hdG32g@mail.gmail.com>
	<5096730C.5050507@inktank.com>
	<CAFjNkqRAnmgR7NWssyaa3ezdkHZha+Z4Ys95bRLgrUs1siiKjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63767 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2KOVYd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 16:24:33 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2662320iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 13:24:33 -0800 (PST)
In-Reply-To: <CAFjNkqRAnmgR7NWssyaa3ezdkHZha+Z4Ys95bRLgrUs1siiKjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Samarin <nrg3tik@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Ryan <mike.ryan@inktank.com>

On Sun, Nov 4, 2012 at 7:13 AM, Aleksey Samarin <nrg3tik@gmail.com> wro=
te:
> What may be possible solutions?
> Update centos to 6.3?

=46rom what I've heard the RHEL libc doesn't support the syncfs syscall
(even though the kernel does have it). :( So you'd need to make sure
the kernel supports it and then build a custom glibc, and then make
sure your Ceph software is built to use it.


> About issue with writes to lots of disk, i think parallel dd command
> will be good as test! :)

Yes =97 it really looks like maybe some of your disks are much slower
than the others. Try benchmarking each individually one-at-a-time, and
then in groups. I suspect you'll see a problem below the Ceph layers.

>
> 2012/11/4 Mark Nelson <mark.nelson@inktank.com>:
>> On 11/04/2012 07:18 AM, Aleksey Samarin wrote:
>>>
>>> Well, i create ceph cluster with 2 osd ( 1 osd per node),  2 mon, 2=
 mds.
>>> here is what I did:
>>>   ceph osd pool create bench
>>>   ceph osd tell \* bench
>>>   rados -p bench bench 30 write --no-cleanup
>>> output:
>>>
>>>   Maintaining 16 concurrent writes of 4194304 bytes for at least 30
>>> seconds.
>>>   Object prefix: benchmark_data_host01_11635
>>>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat  =
 avg
>>> lat
>>>       0       0         0         0         0         0         -
>>> 0
>>>       1      16        16         0         0         0         -
>>> 0
>>>       2      16        37        21   41.9911        42  0.139005
>>> 1.08941
>>>       3      16        53        37   49.3243        64  0.754114
>>> 1.09392
>>>       4      16        75        59   58.9893        88  0.284647
>>> 0.914221
>>>       5      16        89        73   58.3896        56  0.072228
>>> 0.881008
>>>       6      16        95        79   52.6575        24   1.56959
>>> 0.961477
>>>       7      16       111        95   54.2764        64  0.046105
>>> 1.08791
>>>       8      16       128       112   55.9906        68  0.035714
>>> 1.04594
>>>       9      16       150       134   59.5457        88  0.046298
>>> 1.04415
>>>      10      16       166       150   59.9901        64  0.048635
>>> 0.986384
>>>      11      16       176       160   58.1723        40  0.727784
>>> 0.988408
>>>      12      16       206       190   63.3231       120   0.28869
>>> 0.946624
>>>      13      16       225       209   64.2976        76   1.34472
>>> 0.919464
>>>      14      16       263       247   70.5605       152  0.070926
>>> 0.90046
>>>      15      16       295       279   74.3887       128  0.041517
>>> 0.830466
>>>      16      16       315       299   74.7388        80  0.296037
>>> 0.841527
>>>      17      16       333       317   74.5772        72  0.286097
>>> 0.849558
>>>      18      16       340       324   71.9891        28  0.295084
>>> 0.83922
>>>      19      16       343       327   68.8317        12   1.46948
>>> 0.845797
>>> 2012-11-04 17:14:52.090941min lat: 0.035714 max lat: 2.64841 avg la=
t:
>>> 0.861539
>>>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat  =
 avg
>>> lat
>>>      20      16       378       362    72.389       140  0.566232
>>> 0.861539
>>>      21      16       400       384   73.1313        88  0.038835
>>> 0.857785
>>>      22      16       404       388   70.5344        16  0.801216
>>> 0.857002
>>>      23      16       413       397   69.0327        36  0.062256
>>> 0.86376
>>>      24      16       428       412   68.6543        60  0.042583
>>> 0.89389
>>>      25      16       450       434   69.4277        88  0.383877
>>> 0.905833
>>>      26      16       472       456   70.1415        88  0.269878
>>> 0.898023
>>>      27      16       472       456   67.5437         0         -
>>> 0.898023
>>>      28      16       512       496   70.8448        80  0.056798
>>> 0.891163
>>>      29      16       530       514   70.8843        72   1.20653
>>> 0.898112
>>>      30      16       542       526   70.1212        48  0.744383
>>> 0.890733
>>>   Total time run:         30.174151
>>> Total writes made:      543
>>> Write size:             4194304
>>> Bandwidth (MB/sec):     71.982
>>>
>>> Stddev Bandwidth:       38.318
>>> Max bandwidth (MB/sec): 152
>>> Min bandwidth (MB/sec): 0
>>> Average Latency:        0.889026
>>> Stddev Latency:         0.677425
>>> Max latency:            2.94467
>>> Min latency:            0.035714
>>>
>>
>> Much better for 1 disk per node!  I suspect that lack of syncfs is h=
urting
>> you, or perhaps some other issue with writes to lots of disks at the=
 same
>> time.
>>
>>
>>>
>>> 2012/11/4 Aleksey Samarin <nrg3tik@gmail.com>:
>>>>
>>>> Ok!
>>>> Well, I'll take these tests and write about the results.
>>>>
>>>> btw,
>>>> disks are the same, as some may be faster than others?
>>>>
>>>> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>>>>>
>>>>> That's only nine =97 where are the other three? If you have three=
 slow
>>>>> disks that could definitely cause the troubles you're seeing.
>>>>>
>>>>> Also, what Mark said about sync versus syncfs.
>>>>>
>>>>> On Sun, Nov 4, 2012 at 1:26 PM, Aleksey Samarin <nrg3tik@gmail.co=
m>
>>>>> wrote:
>>>>>>
>>>>>> It`s ok!
>>>>>>
>>>>>> Output:
>>>>>>
>>>>>> 2012-11-04 16:19:23.195891 osd.0 [INF] bench: wrote 1024 MB in b=
locks
>>>>>> of 4096 KB in 11.441035 sec at 91650 KB/sec
>>>>>> 2012-11-04 16:19:24.981631 osd.1 [INF] bench: wrote 1024 MB in b=
locks
>>>>>> of 4096 KB in 13.225048 sec at 79287 KB/sec
>>>>>> 2012-11-04 16:19:25.672896 osd.2 [INF] bench: wrote 1024 MB in b=
locks
>>>>>> of 4096 KB in 13.917157 sec at 75344 KB/sec
>>>>>> 2012-11-04 16:19:28.058517 osd.21 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 16.453375 sec at 63730 KB/sec
>>>>>> 2012-11-04 16:19:28.715552 osd.22 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 17.108887 sec at 61288 KB/sec
>>>>>> 2012-11-04 16:19:23.440054 osd.23 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 11.834639 sec at 88602 KB/sec
>>>>>> 2012-11-04 16:19:24.023650 osd.24 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 12.418276 sec at 84438 KB/sec
>>>>>> 2012-11-04 16:19:24.617514 osd.25 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 13.011955 sec at 80585 KB/sec
>>>>>> 2012-11-04 16:19:25.148613 osd.26 [INF] bench: wrote 1024 MB in =
blocks
>>>>>> of 4096 KB in 13.541710 sec at 77433 KB/sec
>>>>>>
>>>>>> All the best.
>>>>>>
>>>>>> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>>>>>>>
>>>>>>> [Sorry for the blank email; I missed!]
>>>>>>> On Sun, Nov 4, 2012 at 1:04 PM, Aleksey Samarin <nrg3tik@gmail.=
com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hi!
>>>>>>>> This command? ceph tell osd \* bench
>>>>>>>> Output:  tell target 'osd' not a valid entity name
>>>>>>>
>>>>>>>
>>>>>>> I guess it's "ceph osd tell \* bench". Try that one. :)
>>>>>>>
>>>>>>>> Well, i did pool by command ceph osd pool create bench2 120
>>>>>>>> This output of rados -p bench2 bench 30 write --no-cleanup
>>>>>>>>
>>>>>>>> rados -p bench2 bench 30 write --no-cleanup
>>>>>>>>
>>>>>>>>   Maintaining 16 concurrent writes of 4194304 bytes for at lea=
st 30
>>>>>>>> seconds.
>>>>>>>>   Object prefix: benchmark_data_host01_5827
>>>>>>>>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last =
lat
>>>>>>>> avg lat
>>>>>>>>       0       0         0         0         0         0       =
  -
>>>>>>>> 0
>>>>>>>>       1      16        29        13   51.9885        52  0.489=
268
>>>>>>>> 0.186749
>>>>>>>>       2      16        52        36   71.9866        92   1.87=
226
>>>>>>>> 0.711888
>>>>>>>>       3      16        57        41    54.657        20  0.089=
697
>>>>>>>> 0.697821
>>>>>>>>       4      16        60        44   43.9923        12   1.61=
868
>>>>>>>> 0.765361
>>>>>>>>       5      16        60        44   35.1941         0       =
  -
>>>>>>>> 0.765361
>>>>>>>>       6      16        60        44   29.3285         0       =
  -
>>>>>>>> 0.765361
>>>>>>>>       7      16        60        44   25.1388         0       =
  -
>>>>>>>> 0.765361
>>>>>>>>       8      16        61        45   22.4964         1   5.89=
643
>>>>>>>> 0.879384
>>>>>>>>       9      16        62        46   20.4412         4    6.0=
234
>>>>>>>> 0.991211
>>>>>>>>      10      16        62        46   18.3971         0       =
  -
>>>>>>>> 0.991211
>>>>>>>>      11      16        63        47   17.0883         2   8.79=
749
>>>>>>>> 1.1573
>>>>>>>>      12      16        63        47   15.6643         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      13      16        63        47   14.4593         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      14      16        63        47   13.4266         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      15      16        63        47   12.5315         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      16      16        63        47   11.7483         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      17      16        63        47   11.0572         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      18      16        63        47   10.4429         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      19      16        63        47   9.89331         0       =
  -
>>>>>>>> 1.1573
>>>>>>>> 2012-11-04 15:58:15.473733min lat: 0.036475 max lat: 8.79749 a=
vg lat:
>>>>>>>> 1.1573
>>>>>>>>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last =
lat
>>>>>>>> avg lat
>>>>>>>>      20      16        63        47   9.39865         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      21      16        63        47   8.95105         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      22      16        63        47   8.54419         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      23      16        63        47   8.17271         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      24      16        63        47   7.83218         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      25      16        63        47    7.5189         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      26      16        63        47   7.22972         0       =
  -
>>>>>>>> 1.1573
>>>>>>>>      27      16        81        65   9.62824       4.5  0.076=
456
>>>>>>>> 4.9428
>>>>>>>>      28      16       118       102   14.5693       148  0.427=
273
>>>>>>>> 4.34095
>>>>>>>>      29      16       119       103   14.2049         4   1.57=
897
>>>>>>>> 4.31414
>>>>>>>>      30      16       132       116   15.4645        52   2.25=
424
>>>>>>>> 4.01492
>>>>>>>>      31      16       133       117   15.0946         4  0.974=
652
>>>>>>>> 3.98893
>>>>>>>>      32      16       133       117   14.6229         0       =
  -
>>>>>>>> 3.98893
>>>>>>>>   Total time run:         32.575351
>>>>>>>> Total writes made:      133
>>>>>>>> Write size:             4194304
>>>>>>>> Bandwidth (MB/sec):     16.331
>>>>>>>>
>>>>>>>> Stddev Bandwidth:       31.8794
>>>>>>>> Max bandwidth (MB/sec): 148
>>>>>>>> Min bandwidth (MB/sec): 0
>>>>>>>> Average Latency:        3.91583
>>>>>>>> Stddev Latency:         7.42821
>>>>>>>> Max latency:            25.24
>>>>>>>> Min latency:            0.036475
>>>>>>>>
>>>>>>>> Im think problem not in pg. This output of ceph pg dump  >
>>>>>>>> http://pastebin.com/BqLsyMBC
>>>>>>>
>>>>>>>
>>>>>>> Well, that did improve it a bit; but yes, I think there's somet=
hing
>>>>>>> else going on. Just wanted to verify. :)
>>>>>>>
>>>>>>>>
>>>>>>>> I have still no idea.
>>>>>>>>
>>>>>>>> All the best. Alex
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>>>>>>>>>
>>>>>>>>> On Sun, Nov 4, 2012 at 10:58 AM, Aleksey Samarin <nrg3tik@gma=
il.com>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi all
>>>>>>>>>>
>>>>>>>>>> Im planning use ceph for cloud storage.
>>>>>>>>>> My test setup is 2 servers connected via infiniband 40Gb, 6x=
2Tb
>>>>>>>>>> disks per node.
>>>>>>>>>> Centos 6.2
>>>>>>>>>> Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
>>>>>>>>>> This is my config http://pastebin.com/Pzxafnsm
>>>>>>>>>> journal on tmpfs
>>>>>>>>>> well, im create bench pool and test it:
>>>>>>>>>> ceph osd pool create bench
>>>>>>>>>> rados -p bench bench 30 write
>>>>>>>>>>
>>>>>>>>>>   Total time run:         43.258228
>>>>>>>>>>   Total writes made:      151
>>>>>>>>>>   Write size:             4194304
>>>>>>>>>>   Bandwidth (MB/sec):     13.963
>>>>>>>>>>   Stddev Bandwidth:       26.307
>>>>>>>>>>   Max bandwidth (MB/sec): 128
>>>>>>>>>>   Min bandwidth (MB/sec): 0
>>>>>>>>>>   Average Latency:        4.48605
>>>>>>>>>>   Stddev Latency:         8.17709
>>>>>>>>>>   Max latency:            29.7957
>>>>>>>>>>   Min latency:            0.039435
>>>>>>>>>>
>>>>>>>>>> when i do rados -p bench bench 30 seq
>>>>>>>>>>   Total time run:        20.626935
>>>>>>>>>>   Total reads made:     275
>>>>>>>>>>   Read size:            4194304
>>>>>>>>>>   Bandwidth (MB/sec):    53.328
>>>>>>>>>>   Average Latency:       1.19754
>>>>>>>>>>   Max latency:           7.0215
>>>>>>>>>>   Min latency:           0.011647
>>>>>>>>>>
>>>>>>>>>> I tested the single drive via dd if=3D/dev/zero of=3D/mnt/hd=
d2/testfile
>>>>>>>>>> bs=3D1024k count=3D20000
>>>>>>>>>> result:  158 MB/sec
>>>>>>>>>>
>>>>>>>>>> Anyone can tell me why such a weak performance? Maybe I miss=
ed
>>>>>>>>>> something?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you run "ceph tell osd \* bench" and report the results? =
(It'll
>>>>>>>>> go
>>>>>>>>> to the "central log" which you can keep an eye on if you run =
"ceph
>>>>>>>>> -w"
>>>>>>>>> in another terminal.)
>>>>>>>>> I think you also didn't create your bench pool correctly; it
>>>>>>>>> probably
>>>>>>>>> only has 8 PGs which is not going to perform very well with y=
our
>>>>>>>>> disk
>>>>>>>>> count. Try "ceph pool create bench2 120" and run the benchmar=
k
>>>>>>>>> against
>>>>>>>>> that pool. The extra number at the end tells it to create 120
>>>>>>>>> placement groups.
>>>>>>>>> -Greg
>>>
>>> --
>>>
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
