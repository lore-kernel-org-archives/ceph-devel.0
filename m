From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Regarding newstore performance
Date: Wed, 15 Apr 2015 20:23:22 +0800
Message-ID: <CACJqLybLO=ut70O7Mf_RCnJwzBPAH45OBnGLdHesdnRziCUUiQ@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD79CFB@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36604 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbDOMXX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 08:23:23 -0400
Received: by pabsx10 with SMTP id sx10so49297760pab.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2015 05:23:23 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD79CFB@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 15, 2015 at 2:01 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Sage/Mark,
> I did some WA experiment with newstore with the similar settings I mentioned yesterday.
>
> Test:
> -------
>
> 64K Random write with 64 QD and writing total of 1 TB of data.
>
>
> Newstore:
> ------------
>
> Fio output at the end of 1 TB write.
> -------------------------------------------
>
> rbd_iodepth32: (g=0): rw=randwrite, bs=64K-64K/64K-64K/64K-64K, ioengine=rbd, iodepth=64
> fio-2.1.11-20-g9a44
> Starting 1 process
> rbd engine: RBD version: 0.1.9
> Jobs: 1 (f=1): [w(1)] [100.0% done] [0KB/49600KB/0KB /s] [0/775/0 iops] [eta 00m:00s]
> rbd_iodepth32: (groupid=0, jobs=1): err= 0: pid=42907: Tue Apr 14 00:34:23 2015
>   write: io=1000.0GB, bw=48950KB/s, iops=764, runt=21421419msec
>     slat (usec): min=43, max=9480, avg=116.45, stdev=10.99
>     clat (msec): min=13, max=1331, avg=83.55, stdev=52.97
>      lat (msec): min=14, max=1331, avg=83.67, stdev=52.97
>     clat percentiles (msec):
>      |  1.00th=[   60],  5.00th=[   68], 10.00th=[   71], 20.00th=[   74],
>      | 30.00th=[   76], 40.00th=[   78], 50.00th=[   81], 60.00th=[   83],
>      | 70.00th=[   86], 80.00th=[   90], 90.00th=[   94], 95.00th=[   98],
>      | 99.00th=[  109], 99.50th=[  114], 99.90th=[ 1188], 99.95th=[ 1221],
>      | 99.99th=[ 1270]
>     bw (KB  /s): min=   62, max=101888, per=100.00%, avg=49760.84, stdev=7320.03
>     lat (msec) : 20=0.01%, 50=0.38%, 100=96.00%, 250=3.34%, 500=0.03%
>     lat (msec) : 750=0.02%, 1000=0.03%, 2000=0.20%
>   cpu          : usr=10.85%, sys=1.76%, ctx=123504191, majf=0, minf=603964
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=2.1%, >=64=97.9%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.1%, 32=0.0%, 64=0.1%, >=64=0.0%
>      issued    : total=r=0/w=16384000/d=0, short=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=64
>
> Run status group 0 (all jobs):
>   WRITE: io=1000.0GB, aggrb=48949KB/s, minb=48949KB/s, maxb=48949KB/s, mint=21421419msec, maxt=21421419msec
>
>
> So, iops getting is ~764.
> 99th percentile latency should be 100ms.
>
> Write amplification at disk level:
> --------------------------------------
>
> SanDisk SSDs have some disk level counters that can measure number of host writes with flash logical page size and number of actual flash writes with the same flash logical page size. The difference between these two is the actual WA causing to disk.
>
> Please find the data in the following xls.
>
> https://docs.google.com/spreadsheets/d/1vIT6PHRbLdk_IqFDc2iM_teMolDUlxcX5TLMRzdXyJE/edit?usp=sharing
>
> Total host writes in this period = 923896266
>
> Total flash writes in this period = 1465339040
>
>
> FileStore:
> -------------
>
> Fio output at the end of 1 TB write.
> -------------------------------------------
>
> rbd_iodepth32: (g=0): rw=randwrite, bs=64K-64K/64K-64K/64K-64K, ioengine=rbd, iodepth=64
> fio-2.1.11-20-g9a44
> Starting 1 process
> rbd engine: RBD version: 0.1.9
> Jobs: 1 (f=1): [w(1)] [100.0% done] [0KB/164.7MB/0KB /s] [0/2625/0 iops] [eta 00m:01s]
> rbd_iodepth32: (groupid=0, jobs=1): err= 0: pid=44703: Tue Apr 14 18:44:00 2015
>   write: io=1000.0GB, bw=98586KB/s, iops=1540, runt=10636117msec
>     slat (usec): min=42, max=7144, avg=120.45, stdev=45.80
>     clat (usec): min=942, max=3954.6K, avg=40776.42, stdev=81231.25
>      lat (msec): min=1, max=3954, avg=40.90, stdev=81.23
>     clat percentiles (msec):
>      |  1.00th=[    7],  5.00th=[   11], 10.00th=[   13], 20.00th=[   16],
>      | 30.00th=[   18], 40.00th=[   20], 50.00th=[   22], 60.00th=[   25],
>      | 70.00th=[   30], 80.00th=[   40], 90.00th=[   67], 95.00th=[  114],
>      | 99.00th=[  433], 99.50th=[  570], 99.90th=[  914], 99.95th=[ 1090],
>      | 99.99th=[ 1647]
>     bw (KB  /s): min=   32, max=243072, per=100.00%, avg=103148.37, stdev=63090.00
>     lat (usec) : 1000=0.01%
>     lat (msec) : 2=0.01%, 4=0.14%, 10=4.50%, 20=38.34%, 50=42.42%
>     lat (msec) : 100=8.81%, 250=3.48%, 500=1.58%, 750=0.50%, 1000=0.14%
>     lat (msec) : 2000=0.06%, >=2000=0.01%
>   cpu          : usr=18.46%, sys=2.64%, ctx=63096633, majf=0, minf=923370
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.6%, 32=80.4%, >=64=19.1%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=94.3%, 8=2.9%, 16=1.9%, 32=0.9%, 64=0.1%, >=64=0.0%
>      issued    : total=r=0/w=16384000/d=0, short=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=64
>
> Run status group 0 (all jobs):
>   WRITE: io=1000.0GB, aggrb=98586KB/s, minb=98586KB/s, maxb=98586KB/s, mint=10636117msec, maxt=10636117msec
>
> Disk stats (read/write):
>   sda: ios=0/251, merge=0/149, ticks=0/0, in_queue=0, util=0.00%
>
> So, iops here is ~1500.
> 99th percentile latency should be within 50ms
>
>
> Write amplification at disk level:
> --------------------------------------
>
> Total host writes in this period = 643611346
>
> Total flash writes in this period = 1157304512
>
>
>
> https://docs.google.com/spreadsheets/d/1gbIATBerS8COzSsJRMbkFXCSbLjn61Fz49CLH8WPh7Q/edit?pli=1#gid=95373000
>
>
>
>
>
> Summary:
> ------------
>
> 1.  The performance is doubled in case of filestore and latency is almost half.
>
> 2. Total number of flash writes is impacted by by both application write pattern + FTL logic etc. etc. So, I am not going into that.  Things to note the significant increase of host writes with newstore and that's definitely causing extra WA compare to  filestore.
>

Yeah, it seemed that xfs plays well when writing back.

> 3. Considering flash page size = 4K, the total writes in case of filestore = 2455 GB with a 1000 GB fio write vs 3524 GB with newstore. So, WA of filestore is ~2.4 vs ~3.5 in case of newstore. Considering inherent 2X WA for filestore, it is doing pretty good here.
>      Now, in case of newstore , it is not supposed to write WAL in case of new writes. It will be interesting to see % of new writes coming..Will analyze that..
>

I think it should result from kvdb. Maybe we can separate newstore's
data dir and kvdb dir. So we can measure the difference with different
disk counter.

> 4. If you can open my xls and graphs above, you can see initially host writes and flash writes are very similar in case of newstore and then it jumps high. Not sure why though. I will rerun the tests to confirm similar phenomenon.
>
> 5. The cumulative flash write  and cumulative host write graph is the actual WA (host + FW) caused by the write.
>

I'm interested in the flash write and disk write counter, is it a
internal tool to inspect or it's a opensource tool?

> What's next:
> ---------------
>
> 1. Need to understand why 3.5 WA for newstore.
>
> 2. Try with different  Rocksdb tuning and record the impact.
>
>
> Any feedback/suggestion is much appreciated.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Monday, April 13, 2015 4:54 PM
> To: ceph-devel
> Subject: Regarding newstore performance
>
> Sage,
> I was doing some preliminary performance testing of newstore on a single OSD (SSD) , single replication setup. Here is my findings so far.
>
> Test:
> -----
>
>         64K random writes with QD= 64 using fio_rbd.
>
> Results :
> ----------
>
>         1. With all default settings, I am seeing very spiky performance. FIO is reporting between 0-~1K random write IOPS with many times IO stops at 0s...Tried with bigger overlay max size value but results are similar...
>
>         2. Next I set the newstore_overlay_max = 0 and I got pretty stable performance ~800-900 IOPS (write duration is short though).
>
>         3. I tried to tweak all the settings one by one but not much benefit anywhere.
>
>         4. One interesting observation here, in my setup if I set newstore_sync_queue_transaction = true , I am getting iops ~600-700..Which is ~100 less.
>              This is quite contrary to my keyvaluestore experiment where I got ~3X improvement by doing sync  writes !
>
>         5. Filestore performance in the similar setup is ~1.6K after 1 TB of data write.
>
> I am trying to figure out from the code what exactly this overlay writes does. Any insight/explanation would be helpful here.
>
> I am planning to do some more experiment with newstore including WA comparison between filestore vs newstore. Will publish the result soon.
>
> Thanks & Regards
> Somnath
>
>
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
