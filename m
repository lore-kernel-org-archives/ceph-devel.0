From: Gregory Farnum <greg@inktank.com>
Subject: Re: poor performance
Date: Sun, 4 Nov 2012 13:15:26 +0100
Message-ID: <CAPYLRzjEFkKQm6N3wAQLOU8u39xy=VLGf1-mFdX3CKUixtO1WQ@mail.gmail.com>
References: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
	<CAPYLRzipAsNdEO6BKrSofPjmWp9F0dL_iH18VaC054TeA=9EBg@mail.gmail.com>
	<CAFjNkqRNv73+n4hUedBjmEmX4OvXHxhbvm51xDx8qJauoQPQ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49427 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2KDMP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 07:15:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6803496iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 04:15:26 -0800 (PST)
In-Reply-To: <CAFjNkqRNv73+n4hUedBjmEmX4OvXHxhbvm51xDx8qJauoQPQ=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Samarin <nrg3tik@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Ryan <mike.ryan@inktank.com>

On Sun, Nov 4, 2012 at 1:04 PM, Aleksey Samarin <nrg3tik@gmail.com> wrote:
> Hi!
> This command? ceph tell osd \* bench
> Output:  tell target 'osd' not a valid entity name
>
> Well, i did pool by command ceph osd pool create bench2 120
> This output of rados -p bench2 bench 30 write --no-cleanup
>
> rados -p bench2 bench 30 write --no-cleanup
>
>  Maintaining 16 concurrent writes of 4194304 bytes for at least 30 seconds.
>  Object prefix: benchmark_data_host01_5827
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       0         0         0         0         0         -         0
>      1      16        29        13   51.9885        52  0.489268  0.186749
>      2      16        52        36   71.9866        92   1.87226  0.711888
>      3      16        57        41    54.657        20  0.089697  0.697821
>      4      16        60        44   43.9923        12   1.61868  0.765361
>      5      16        60        44   35.1941         0         -  0.765361
>      6      16        60        44   29.3285         0         -  0.765361
>      7      16        60        44   25.1388         0         -  0.765361
>      8      16        61        45   22.4964         1   5.89643  0.879384
>      9      16        62        46   20.4412         4    6.0234  0.991211
>     10      16        62        46   18.3971         0         -  0.991211
>     11      16        63        47   17.0883         2   8.79749    1.1573
>     12      16        63        47   15.6643         0         -    1.1573
>     13      16        63        47   14.4593         0         -    1.1573
>     14      16        63        47   13.4266         0         -    1.1573
>     15      16        63        47   12.5315         0         -    1.1573
>     16      16        63        47   11.7483         0         -    1.1573
>     17      16        63        47   11.0572         0         -    1.1573
>     18      16        63        47   10.4429         0         -    1.1573
>     19      16        63        47   9.89331         0         -    1.1573
> 2012-11-04 15:58:15.473733min lat: 0.036475 max lat: 8.79749 avg lat: 1.1573
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>     20      16        63        47   9.39865         0         -    1.1573
>     21      16        63        47   8.95105         0         -    1.1573
>     22      16        63        47   8.54419         0         -    1.1573
>     23      16        63        47   8.17271         0         -    1.1573
>     24      16        63        47   7.83218         0         -    1.1573
>     25      16        63        47    7.5189         0         -    1.1573
>     26      16        63        47   7.22972         0         -    1.1573
>     27      16        81        65   9.62824       4.5  0.076456    4.9428
>     28      16       118       102   14.5693       148  0.427273   4.34095
>     29      16       119       103   14.2049         4   1.57897   4.31414
>     30      16       132       116   15.4645        52   2.25424   4.01492
>     31      16       133       117   15.0946         4  0.974652   3.98893
>     32      16       133       117   14.6229         0         -   3.98893
>  Total time run:         32.575351
> Total writes made:      133
> Write size:             4194304
> Bandwidth (MB/sec):     16.331
>
> Stddev Bandwidth:       31.8794
> Max bandwidth (MB/sec): 148
> Min bandwidth (MB/sec): 0
> Average Latency:        3.91583
> Stddev Latency:         7.42821
> Max latency:            25.24
> Min latency:            0.036475
>
> Im think problem not in pg. This output of ceph pg dump  >
> http://pastebin.com/BqLsyMBC
>
> I have still no idea.
>
> All the best. Alex
>
>
>
> 2012/11/4 Gregory Farnum <greg@inktank.com>:
>> On Sun, Nov 4, 2012 at 10:58 AM, Aleksey Samarin <nrg3tik@gmail.com> wrote:
>>> Hi all
>>>
>>> Im planning use ceph for cloud storage.
>>> My test setup is 2 servers connected via infiniband 40Gb, 6x2Tb disks per node.
>>> Centos 6.2
>>> Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
>>> This is my config http://pastebin.com/Pzxafnsm
>>> journal on tmpfs
>>> well, im create bench pool and test it:
>>> ceph osd pool create bench
>>> rados -p bench bench 30 write
>>>
>>>  Total time run:         43.258228
>>>  Total writes made:      151
>>>  Write size:             4194304
>>>  Bandwidth (MB/sec):     13.963
>>>  Stddev Bandwidth:       26.307
>>>  Max bandwidth (MB/sec): 128
>>>  Min bandwidth (MB/sec): 0
>>>  Average Latency:        4.48605
>>>  Stddev Latency:         8.17709
>>>  Max latency:            29.7957
>>>  Min latency:            0.039435
>>>
>>> when i do rados -p bench bench 30 seq
>>>  Total time run:        20.626935
>>>  Total reads made:     275
>>>  Read size:            4194304
>>>  Bandwidth (MB/sec):    53.328
>>>  Average Latency:       1.19754
>>>  Max latency:           7.0215
>>>  Min latency:           0.011647
>>>
>>> I tested the single drive via dd if=/dev/zero of=/mnt/hdd2/testfile
>>> bs=1024k count=20000
>>> result:  158 MB/sec
>>>
>>> Anyone can tell me why such a weak performance? Maybe I missed something?
>>
>> Can you run "ceph tell osd \* bench" and report the results? (It'll go
>> to the "central log" which you can keep an eye on if you run "ceph -w"
>> in another terminal.)
>> I think you also didn't create your bench pool correctly; it probably
>> only has 8 PGs which is not going to perform very well with your disk
>> count. Try "ceph pool create bench2 120" and run the benchmark against
>> that pool. The extra number at the end tells it to create 120
>> placement groups.
>> -Greg
