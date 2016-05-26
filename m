From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: Re: SMR Benchmarking Results
Date: Thu, 26 May 2016 13:17:37 -0400
Message-ID: <CAPLK-i9+AEjn7SdnpGgqKf28r=A3O22w7Saw5Wi5-pkhvYJYXQ@mail.gmail.com>
References: <CAPLK-i8DKcHtNuv5T1jua=5sp3Fxxb+LwdTdUSpvxqRNj7AMhA@mail.gmail.com>
	<BLUPR0201MB1524D83DDA25FD1F836C62D4E8410@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33416 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbcEZRRi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 13:17:38 -0400
Received: by mail-yw0-f177.google.com with SMTP id h19so83001065ywc.0
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 10:17:38 -0700 (PDT)
In-Reply-To: <BLUPR0201MB1524D83DDA25FD1F836C62D4E8410@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Allen,

I ran the SMR zone_open and zone_close commands to see what the
overhead was. zone_open and zone_close only take up 3% of the total
time, The rest of the time is consumed while zone_write is taking
place.

                    (open-close)  (open-write-close)
40 zones  -  11.8 secs        6 min 41 secs
400 zones - 1min 52 secs            NA

I looked at zbc_write command, it takes a chunk of file into a
temporary buffer (whose size is 1MB for my experiment) and writes it
to disk. I assume dd also works this way, taking block size (bs
parameter) number of bytes in memory at a time and writing to disk. I
think with this information we can infer that most of the time
consumed is in writing to disk.

I observed a difference in the way zone was being opened while doing
"dd write" and "SMR aware zbc_write". for dd write, the zone is
"implicitly opened", and data is written to it. for zbc writes, when
we issue a zone_open command, the zone is "explicitly opened",
followed by a write, followed by zone_close.

looking at documentation of SMR support for ext4 here:
https://github.com/Seagate/SMR_FS-EXT4 , it seems Implicit open zones
are those zones that the drive can close on its own. explicit zones
cannot be closed on their own - and needs to be closed by explicit
commands like zbc_close.

From initial experiments it seems that implicitly opened zones perform
better that explicitly opened zones. Probably we will see a difference
in performance when the drive hits the maximum number of implicitly
open zones, when it will internally start closing zones - in that case
we will need smarter zone management - where I feel explicit zone
open/close commands will help.

Thanks,
Shehbaz

On Thu, May 26, 2016 at 1:20 AM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
> Sounds like the zone open and/or close commands are triggering I/O operations.
>
> Just as an experiment, how long does it take to open and close a bunch of zones with NO data being written to them?
>
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: Shehbaz Jaffer [mailto:shehbazjaffer007@gmail.com]
>> Sent: Wednesday, May 25, 2016 9:44 PM
>> To: Sage Weil <sweil@redhat.com>
>> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-
>> devel@vger.kernel.org
>> Subject: SMR Benchmarking Results
>>
>> Hi Sage,
>>
>> I have been working on benchmarking SMR Drives using libzbc. It appears
>> that issuing ZBC commands for zone aware host is more inefficient as
>> compared to normal copy operations using 'dd' command.
>>
>> I created a 256 MB file and placed it in memory (so that we do not have data
>> fetch overheads). I copy this file repeatedly on a Host Aware SMR drive in 2
>> scenarios :
>>
>> a) dd - I use dumb dd that takes 1MB chunks of file and keeps copying the file
>> to SMR drive for <writeSize> bytes. Note that dd does not take the zones
>> into consideration.
>>
>> b) SMR_aware_copy - This copy takes file chunks 1MB in size, but issues ZBC
>> commands to open each zone, write 256 MB data to the zone, close the
>> zone, and then move to another zone till <writeSize> bytes have been
>> written.
>>
>> performance results for 1GB, 10GB write sizes are 5x slower with "zone
>> aware" writing, as compared to normal dd writing:
>>
>> writeSize (in GB)     dd time (in min:sec)     smr_aware_copy (in min:sec)
>> 1 GB                              0:7                                0:34
>> 10 GB                            1:11                              6:41
>> 50 GB                            5:51                               NA
>> 100 GB                          11:42                             NA
>>
>> (all writes were followed by sync command)
>>
>> I was trying to see if there is an internal cache of some sort in the Host Aware
>> SMR drive, which probably serializes all writes up to certain extent for dd
>> command, but the time for writes using the dd command for up to 100GB
>> follow a linear pattern. I will try to see if we hit a bottleneck with dd for larger
>> file sizes or unaligned writes.
>>
>> Followup questions:
>> --------------------------
>>
>> a) I think we should have some workload traces or patterns so that we can
>> benchmark SMR drives and make allocator more SMR friendly. In particular -
>> i) size of files,
>> ii) alignment of files
>> iii) % read / write/ delete workloads
>> iv) degree of parallelism in writing.
>>
>> b) SMR Drive has a notion of parallel writes - i.e. multiple zones can be kept
>> open and written to simultaneously. I do not think there are multiple heads
>> involved but internally there is some form of "efficient parallel write to zone"
>> mechanism in SMR. I am thinking about this because when we query SMR
>> drive information, it shows that most effieicnt number of zones can be
>> parallelly kept open = 128 .
>> Maybe this is something that we can take advantage of?
>>
>> Thanks and Regards,
>> Shehbaz



-- 
Shehbaz Jaffer
First Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineering
University of Toronto
