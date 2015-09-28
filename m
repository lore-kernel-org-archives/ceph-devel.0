From: "Handzik, Joe" <joseph.t.handzik@hpe.com>
Subject: Re: Very slow recovery/peering with latest master
Date: Mon, 28 Sep 2015 12:21:24 +0000
Message-ID: <C6E3C59E-81CA-48AA-9070-D7B4582BEE33@hpe.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
 <CAJ4mKGa1vr6Zp9ZUaT8rrHDgRFJgdkO2c8LZqMQuwxwYt7TJ+A@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE536F2@SACMBXIP01.sdcorp.global.sandisk.com>,
 <CAN=+7FWL8c2EO8CU0DS_bMpEXXZS4tpWnkgvjg9p7+D3ztLQhg@mail.gmail.com>
 <2B48BC83-794A-4C76-A50D-86C9349B73BE@hpe.com>,
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE53886@SACMBXIP01.sdcorp.global.sandisk.com>
 <33032584-0996-4506-B07E-66F1DD650A0D@hpe.com>
 <alpine.DEB.2.00.1509231830520.11876@cobra.newdream.net>
 <6BAAF46BC7E1924A827AF6223BED64D7939C7143B3@ABGEX73E.FSC.NET>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE54809@SACMBXIP01.sdcorp.global.sandisk.com>
 <6F3FA899187F0043BA1827A69DA2F7CC03625C79@shsmsx102.ccr.corp.intel.com>,<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE59173@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:39321 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbbI1MVj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 08:21:39 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE59173@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "Podoski, Igor" <Igor.Podoski@ts.fujitsu.com>, Samuel Just <sjust@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

That's really good info, thanks for tracking that down. Do you expect this to be a common configuration going forward in Ceph deployments? 

Joe

> On Sep 28, 2015, at 3:43 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> 
> Xiaoxi,
> Thanks for giving me some pointers.
> Now, with the help of strace I am able to figure out why it is taking so long in my setup to complete blkid* calls.
> In my case, the partitions are showing properly even if it is connected to JBOD controller.
> 
> root@emsnode10:~/wip-write-path-optimization/src/os# strace -t -o /root/strace_blkid.txt blkid
> /dev/sda1: UUID="d2060642-1af4-424f-9957-6a8dc77ff301" TYPE="ext4"
> /dev/sda5: UUID="2a987cc0-e3cd-43d4-99cd-b8d8e58617e7" TYPE="swap"
> /dev/sdy2: UUID="0ebd1631-52e7-4dc2-8bff-07102b877bfc" TYPE="xfs"
> /dev/sdw2: UUID="29f1203b-6f44-45e3-8f6a-8ad1d392a208" TYPE="xfs"
> /dev/sdt2: UUID="94f6bb55-ac61-499c-8552-600581e13dfa" TYPE="xfs"
> /dev/sdr2: UUID="b629710e-915d-4c56-b6a5-4782e6d6215d" TYPE="xfs"
> /dev/sdv2: UUID="69623b7f-9036-4a35-8298-dc7f5cecdb21" TYPE="xfs"
> /dev/sds2: UUID="75d941c5-a85c-4c37-b409-02de34483314" TYPE="xfs"
> /dev/sdx: UUID="cc84bc66-208b-4387-8470-071ec71532f2" TYPE="xfs"
> /dev/sdu2: UUID="c9817831-8362-48a9-9a6c-920e0f04d029" TYPE="xfs"
> 
> But, it is taking time on the drives those are not reserved for this host. Basically, I am using 2 heads in front of a JBOF and I am using sg_persist to reserve the drives between 2 hosts.
> Here is the strace output of blkid.
> 
> http://pastebin.com/qz2Z7Phj
> 
> You can see lot of input/output errors on accessing the drives which are not reserved for this host.
> 
> This is an inefficiency part of blkid* calls (?) since calls like fdisk/lsscsi are not taking time.
> 
> Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Chen, Xiaoxi [mailto:xiaoxi.chen@intel.com]
> Sent: Monday, September 28, 2015 1:02 AM
> To: Somnath Roy; Podoski, Igor
> Cc: Samuel Just; Samuel Just (sam.just@inktank.com); ceph-devel; Sage Weil; Handzik, Joe
> Subject: RE: Very slow recovery/peering with latest master
> 
> FWIW, blkid works well in both GPT(created by parted) and MSDOS(created by fdisk) in my environment.
> 
> But blkid doesn't show the information of disk in external bay (which is connected by a JBOD controller) in my setup.
> 
> See below, SDB and SDH are SSDs attached to the front panel but the rest osd disks(0-9) are from an external bay.
> 
> /dev/sdc       976285652 294887592 681398060  31% /var/lib/ceph/mnt/osd-device-0-data
> /dev/sdd       976285652 269840116 706445536  28% /var/lib/ceph/mnt/osd-device-1-data
> /dev/sde       976285652 257610832 718674820  27% /var/lib/ceph/mnt/osd-device-2-data
> /dev/sdf       976285652 293460620 682825032  31% /var/lib/ceph/mnt/osd-device-3-data
> /dev/sdg       976285652 294444100 681841552  31% /var/lib/ceph/mnt/osd-device-4-data
> /dev/sdi       976285652 288416840 687868812  30% /var/lib/ceph/mnt/osd-device-5-data
> /dev/sdj       976285652 273090960 703194692  28% /var/lib/ceph/mnt/osd-device-6-data
> /dev/sdk       976285652 302720828 673564824  32% /var/lib/ceph/mnt/osd-device-7-data
> /dev/sdl       976285652 268207968 708077684  28% /var/lib/ceph/mnt/osd-device-8-data
> /dev/sdm       976285652 293316752 682968900  31% /var/lib/ceph/mnt/osd-device-9-data
> /dev/sdb1      292824376  10629024 282195352   4% /var/lib/ceph/mnt/osd-device-40-data
> /dev/sdh1      292824376  11413956 281410420   4% /var/lib/ceph/mnt/osd-device-41-data
> 
> 
> 
> root@osd1:~# blkid
> /dev/sdb1: UUID="907806fe-1d29-4ef7-ad11-5a933a11601e" TYPE="xfs"
> /dev/sdh1: UUID="9dfe68ac-f297-4a02-8d21-50c194af4ff2" TYPE="xfs"
> /dev/sda1: UUID="cdf945ce-a345-4766-b89e-cecc33689016" TYPE="ext4"
> /dev/sda2: UUID="7a565029-deb9-4e68-835c-f097c2b1514e" TYPE="ext4"
> /dev/sda5: UUID="e61bfc35-932d-442f-a5ca-795897f62744" TYPE="swap"
> 
> 
> 
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Friday, September 25, 2015 12:09 AM
>> To: Podoski, Igor
>> Cc: Samuel Just; Samuel Just (sam.just@inktank.com); ceph-devel; Sage
>> Weil; Handzik, Joe
>> Subject: RE: Very slow recovery/peering with latest master
>> 
>> Yeah , Igor may be..
>> Meanwhile, I am able to get gdb trace of the hang..
>> 
>> (gdb) bt
>> #0  0x00007f6f6bf043bd in read () at
>> ../sysdeps/unix/syscall-template.S:81
>> #1  0x00007f6f6af3b066 in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #2  0x00007f6f6af43ae2 in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #3  0x00007f6f6af42788 in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #4  0x00007f6f6af42a53 in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #5  0x00007f6f6af3c17b in blkid_do_safeprobe () from
>> /lib/x86_64-linux-
>> gnu/libblkid.so.1
>> #6  0x00007f6f6af3e0c4 in blkid_verify () from /lib/x86_64-linux-
>> gnu/libblkid.so.1
>> #7  0x00007f6f6af387fb in blkid_get_dev () from /lib/x86_64-linux-
>> gnu/libblkid.so.1
>> #8  0x00007f6f6af38acb in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #9  0x00007f6f6af3946d in ?? () from
>> /lib/x86_64-linux-gnu/libblkid.so.1
>> #10 0x00007f6f6af39892 in blkid_probe_all_new () from
>> /lib/x86_64-linux-
>> gnu/libblkid.so.1
>> #11 0x00007f6f6af3dc10 in blkid_find_dev_with_tag () from /lib/x86_64-
>> linux-gnu/libblkid.so.1
>> #12 0x00007f6f6d3bf923 in get_device_by_uuid (dev_uuid=...,
>> label=label@entry=0x7f6f6d535fe5 "PARTUUID",
>> partition=partition@entry=0x7f6f347eb5a0 "",
>> device=device@entry=0x7f6f347ec5a0 "")
>>    at common/blkdev.cc:193
>> #13 0x00007f6f6d147de5 in FileStore::collect_metadata
>> (this=0x7f6f68893000,
>> pm=0x7f6f21419598) at os/FileStore.cc:660
>> #14 0x00007f6f6cebfa9a in OSD::_collect_metadata
>> (this=this@entry=0x7f6f6894f000, pm=pm@entry=0x7f6f21419598) at
>> osd/OSD.cc:4586
>> #15 0x00007f6f6cec0614 in OSD::_send_boot
>> (this=this@entry=0x7f6f6894f000) at osd/OSD.cc:4568
>> #16 0x00007f6f6cec203a in OSD::_maybe_boot (this=0x7f6f6894f000,
>> oldest=1, newest=100) at osd/OSD.cc:4463
>> #17 0x00007f6f6cefc5e1 in Context::complete (this=0x7f6f3d3864e0,
>> r=<optimized out>) at ./include/Context.h:64
>> #18 0x00007f6f6d2eed08 in Finisher::finisher_thread_entry
>> (this=0x7ffee7272d70) at common/Finisher.cc:65
>> #19 0x00007f6f6befd182 in start_thread (arg=0x7f6f347ee700) at
>> pthread_create.c:312
>> #20 0x00007f6f6a24347d in clone ()
>> at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>> 
>> 
>> Strace was not helpful much since other threads are not block and keep
>> printing the futex traces..
>> 
>> Thanks & Regards
>> Somnath
>> 
>> -----Original Message-----
>> From: Podoski, Igor [mailto:Igor.Podoski@ts.fujitsu.com]
>> Sent: Wednesday, September 23, 2015 11:33 PM
>> To: Somnath Roy
>> Cc: Samuel Just; Samuel Just (sam.just@inktank.com); ceph-devel; Sage
>> Weil; Handzik, Joe
>> Subject: RE: Very slow recovery/peering with latest master
>> 
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Thursday, September 24, 2015 3:32 AM
>>> To: Handzik, Joe
>>> Cc: Somnath Roy; Samuel Just; Samuel Just (sam.just@inktank.com);
>>> ceph- devel
>>> Subject: Re: Very slow recovery/peering with latest master
>>> 
>>>> On Wed, 23 Sep 2015, Handzik, Joe wrote:
>>>> Ok. When configuring with ceph-disk, it does something nifty and
>>>> actually gives the OSD the uuid of the disk's partition as its fsid.
>>>> I bootstrap off that to get an argument to pass into the function
>>>> you have identified as the bottleneck. I ran it by sage and we
>>>> both realized there would be cases where it wouldn't work...I'm
>>>> sure neither of us realized the failure would take three minutes though.
>>>> 
>>>> In the short term, it makes sense to create an option to disable
>>>> or short-circuit the blkid code. I would prefer that the default
>>>> be left with the code enabled, but I'm open to default disabled if
>>>> others think this will be a widespread problem. You could also
>>>> make sure your OSD fsids are set to match your disk partition
>>>> uuids for now too, if that's a faster workaround for you (it'll get rid of the failure).
>>> 
>>> I think we should try to figure out where it is hanging.  Can you
>>> strace the blkid process to see what it is up to?
>>> 
>>> I opened http://tracker.ceph.com/issues/13219
>>> 
>>> I think as long as it behaves reliably with ceph-disk OSDs then we
>>> can have it on by default.
>>> 
>>> sage
>>> 
>>> 
>>>> 
>>>> Joe
>>>> 
>>>>> On Sep 23, 2015, at 6:26 PM, Somnath Roy
>>>>> <Somnath.Roy@sandisk.com>
>>> wrote:
>>>>> 
>>>>> <<inline
>>>>> 
>>>>> -----Original Message-----
>>>>> From: Handzik, Joe [mailto:joseph.t.handzik@hpe.com]
>>>>> Sent: Wednesday, September 23, 2015 4:20 PM
>>>>> To: Samuel Just
>>>>> Cc: Somnath Roy; Samuel Just (sam.just@inktank.com); Sage Weil
>>>>> (sage@newdream.net); ceph-devel
>>>>> Subject: Re: Very slow recovery/peering with latest master
>>>>> 
>>>>> I added that, there is code up the stack in calamari that
>>>>> consumes the
>>> path provided, which is intended in the future to facilitate disk
>>> monitoring and management.
>>>>> 
>>>>> [Somnath] Ok
>>>>> 
>>>>> Somnath, what does your disk configuration look like
>>>>> (filesystem,
>>> SSD/HDD, anything else you think could be relevant)? Did you
>>> configure your disks with ceph-disk, or by hand? I never saw this
>>> while testing my code, has anyone else heard of this behavior on
>>> master? The code has been in master for 2-3 months now I believe.
>>>>> [Somnath] All SSD , I use mkcephfs to create cluster , I
>>>>> partitioned the
>>> disk with fdisk beforehand. I am using XFS. Are you trying with
>>> Ubuntu
>>> 3.16.* kernel ? It could be Linux distribution/kernel specific.
>> 
>> Somnath, maybe it is GPT related, what partition table do you have? I
>> think parted and gdisk can create GPT partitions, but not fdisk
>> (definitely not in version that I use).
>> 
>> You could backup and clear blkid cache /etc/blkid/blkid.tab, maybe
>> there is a mess.
>> 
>> Regards,
>> Igor.
>> 
>> 
>>>>> 
>>>>> It would be nice to not need to disable this, but if this
>>>>> behavior exists and
>>> can't be explained by a misconfiguration or something else I'll need
>>> to figure out a different implementation.
>>>>> 
>>>>> Joe
>>>>> 
>>>>>> On Sep 23, 2015, at 6:07 PM, Samuel Just <sjust@redhat.com> wrote:
>>>>>> 
>>>>>> Wow.  Why would that take so long?  I think you are correct
>>>>>> that it's only used for metadata, we could just add a config
>>>>>> value to disable it.
>>>>>> -Sam
>>>>>> 
>>>>>>> On Wed, Sep 23, 2015 at 3:48 PM, Somnath Roy
>>> <Somnath.Roy@sandisk.com> wrote:
>>>>>>> Sam/Sage,
>>>>>>> I debugged it down and found out that the get_device_by_uuid-
>>>> blkid_find_dev_with_tag() call within FileStore::collect_metadata()
>>>> is
>>> hanging for ~3 mins before returning a EINVAL. I saw this portion is
>>> newly added after hammer.
>>>>>>> Commenting it out resolves the issue. BTW, I saw this value is
>>>>>>> stored as
>>> metadata but not used anywhere , am I missing anything ?
>>>>>>> Here is my Linux details..
>>>>>>> 
>>>>>>> root@emsnode5:~/wip-write-path-optimization/src# uname -a
>> Linux
>>>>>>> emsnode5 3.16.0-38-generic #52~14.04.1-Ubuntu SMP Fri May 8
>>>>>>> 09:43:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>> 
>>>>>>> 
>>>>>>> root@emsnode5:~/wip-write-path-optimization/src# lsb_release
>>>>>>> -a
>>> No
>>>>>>> LSB modules are available.
>>>>>>> Distributor ID: Ubuntu
>>>>>>> Description:    Ubuntu 14.04.2 LTS
>>>>>>> Release:        14.04
>>>>>>> Codename:       trusty
>>>>>>> 
>>>>>>> Thanks & Regards
>>>>>>> Somnath
>>>>>>> 
>>>>>>> -----Original Message-----
>>>>>>> From: Somnath Roy
>>>>>>> Sent: Wednesday, September 16, 2015 2:20 PM
>>>>>>> To: 'Gregory Farnum'
>>>>>>> Cc: 'ceph-devel'
>>>>>>> Subject: RE: Very slow recovery/peering with latest master
>>>>>>> 
>>>>>>> 
>>>>>>> Sage/Greg,
>>>>>>> 
>>>>>>> Yeah, as we expected, it is not happening probably because of
>>> recovery settings. I reverted it back in my ceph.conf , but, still
>>> seeing this problem.
>>>>>>> 
>>>>>>> Some observation :
>>>>>>> ----------------------
>>>>>>> 
>>>>>>> 1. First of all, I don't think it is something related to my
>>>>>>> environment. I
>>> recreated the cluster with Hammer and this problem is not there.
>>>>>>> 
>>>>>>> 2. I have enabled the messenger/monclient log (Couldn't attach
>>>>>>> here)
>>> in one of the OSDs and found monitor is taking long time to detect
>>> the up OSDs. If you see the log, I have started OSD at 2015-09-16
>>> 16:13:07.042463 , but, there is no communication (only getting
>>> KEEP_ALIVE) till 2015-09-16
>>> 16:16:07.180482 , so, 3 mins !!
>>>>>>> 
>>>>>>> 3. During this period, I saw monclient trying to communicate
>>>>>>> with
>>> monitor but not able to probably. It is sending osd_boot at
>>> 2015-09-16
>>> 16:16:07.180482 only..
>>>>>>> 
>>>>>>> 2015-09-16 16:16:07.180450 7f65377fe700 10 monclient:
>>>>>>> _send_mon_message to mon.a at 10.60.194.10:6789/0
>>>>>>> 2015-09-16 16:16:07.180482 7f65377fe700  1 --
>>>>>>> 10.60.194.10:6820/20102
>>>>>>> --> 10.60.194.10:6789/0 -- osd_boot(osd.10 booted 0 features
>>>>>>> 72057594037927935 v45) v6 -- ?+0 0x7f6523c19100 con
>>>>>>> 0x7f6542045680
>>>>>>> 2015-09-16 16:16:07.180496 7f65377fe700 20 --
>>>>>>> 10.60.194.10:6820/20102
>>> submit_message osd_boot(osd.10 booted 0 features 72057594037927935
>>> v45) v6 remote, 10.60.194.10:6789/0, have pipe.
>>>>>>> 
>>>>>>> 4. BTW, the osd down scenario is detected very quickly (ceph
>>>>>>> -w
>>> output) , problem is during coming up I guess.
>>>>>>> 
>>>>>>> 
>>>>>>> So, something related to mon communication getting slower ?
>>>>>>> Let me know if more verbose logging is required and how should
>>>>>>> I
>>> share the log..
>>>>>>> 
>>>>>>> Thanks & Regards
>>>>>>> Somnath
>>>>>>> 
>>>>>>> -----Original Message-----
>>>>>>> From: Gregory Farnum [mailto:gfarnum@redhat.com]
>>>>>>> Sent: Wednesday, September 16, 2015 11:35 AM
>>>>>>> To: Somnath Roy
>>>>>>> Cc: ceph-devel
>>>>>>> Subject: Re: Very slow recovery/peering with latest master
>>>>>>> 
>>>>>>>> On Tue, Sep 15, 2015 at 8:04 PM, Somnath Roy
>>> <Somnath.Roy@sandisk.com> wrote:
>>>>>>>> Hi,
>>>>>>>> I am seeing very slow recovery when I am adding OSDs with the
>>>>>>>> latest
>>> master.
>>>>>>>> Also, If I just restart all the OSDs (no IO is going on in
>>>>>>>> the
>>>>>>>> cluster) ,
>>> cluster is taking a significant amount of time to reach in
>>> active+clean state (and even detecting all the up OSDs).
>>>>>>>> 
>>>>>>>> I saw the recovery/backfill default parameters are now
>>>>>>>> changed (to
>>> lower value) , this probably explains the recovery scenario , but,
>>> will it affect the peering time during OSD startup as well ?
>>>>>>> 
>>>>>>> I don't think these values should impact peering time, but you
>>>>>>> could
>>> configure them back to the old defaults and see if it changes.
>>>>>>> -Greg
>>>>>>> 
>>>>>>> ________________________________
>>>>>>> 
>>>>>>> PLEASE NOTE: The information contained in this electronic mail
>>> message is intended only for the use of the designated recipient(s)
>>> named above. If the reader of this message is not the intended
>>> recipient, you are hereby notified that you have received this
>>> message in error and that any review, dissemination, distribution,
>>> or copying of this message is strictly prohibited. If you have
>>> received this communication in error, please notify the sender by
>>> telephone or e-mail (as shown above) immediately and destroy any and
>>> all copies of this message in your possession (whether hard copies
>>> or electronically
>> stored copies).
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>>> info at http://vger.kernel.org/majordomo-info.html
>> 
>> ________________________________
>> 
>> PLEASE NOTE: The information contained in this electronic mail message
>> is intended only for the use of the designated recipient(s) named
>> above. If the reader of this message is not the intended recipient,
>> you are hereby notified that you have received this message in error
>> and that any review, dissemination, distribution, or copying of this
>> message is strictly prohibited. If you have received this
>> communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies of
>> this message in your possession (whether hard copies or electronically stored copies).
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
