From: "Handzik, Joe" <joseph.t.handzik@hpe.com>
Subject: Re: Very slow recovery/peering with latest master
Date: Wed, 23 Sep 2015 23:42:33 +0000
Message-ID: <33032584-0996-4506-B07E-66F1DD650A0D@hpe.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAJ4mKGa1vr6Zp9ZUaT8rrHDgRFJgdkO2c8LZqMQuwxwYt7TJ+A@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE536F2@SACMBXIP01.sdcorp.global.sandisk.com>,<CAN=+7FWL8c2EO8CU0DS_bMpEXXZS4tpWnkgvjg9p7+D3ztLQhg@mail.gmail.com>
 <2B48BC83-794A-4C76-A50D-86C9349B73BE@hpe.com>,<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE53886@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:16256 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001AbbIWXnu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 19:43:50 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE53886@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "Sage Weil (sage@newdream.net)" <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Ok. When configuring with ceph-disk, it does something nifty and actually gives the OSD the uuid of the disk's partition as its fsid. I bootstrap off that to get an argument to pass into the function you have identified as the bottleneck. I ran it by sage and we both realized there would be cases where it wouldn't work...I'm sure neither of us realized the failure would take three minutes though. 

In the short term, it makes sense to create an option to disable or short-circuit the blkid code. I would prefer that the default be left with the code enabled, but I'm open to default disabled if others think this will be a widespread problem. You could also make sure your OSD fsids are set to match your disk partition uuids for now too, if that's a faster workaround for you (it'll get rid of the failure).

Joe

> On Sep 23, 2015, at 6:26 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> 
> <<inline
> 
> -----Original Message-----
> From: Handzik, Joe [mailto:joseph.t.handzik@hpe.com] 
> Sent: Wednesday, September 23, 2015 4:20 PM
> To: Samuel Just
> Cc: Somnath Roy; Samuel Just (sam.just@inktank.com); Sage Weil (sage@newdream.net); ceph-devel
> Subject: Re: Very slow recovery/peering with latest master
> 
> I added that, there is code up the stack in calamari that consumes the path provided, which is intended in the future to facilitate disk monitoring and management.
> 
> [Somnath] Ok
> 
> Somnath, what does your disk configuration look like (filesystem, SSD/HDD, anything else you think could be relevant)? Did you configure your disks with ceph-disk, or by hand? I never saw this while testing my code, has anyone else heard of this behavior on master? The code has been in master for 2-3 months now I believe.
> [Somnath] All SSD , I use mkcephfs to create cluster , I partitioned the disk with fdisk beforehand. I am using XFS. Are you trying with Ubuntu 3.16.* kernel ? It could be Linux distribution/kernel specific.
> 
> It would be nice to not need to disable this, but if this behavior exists and can't be explained by a misconfiguration or something else I'll need to figure out a different implementation.
> 
> Joe
> 
>> On Sep 23, 2015, at 6:07 PM, Samuel Just <sjust@redhat.com> wrote:
>> 
>> Wow.  Why would that take so long?  I think you are correct that it's 
>> only used for metadata, we could just add a config value to disable 
>> it.
>> -Sam
>> 
>>> On Wed, Sep 23, 2015 at 3:48 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>>> Sam/Sage,
>>> I debugged it down and found out that the get_device_by_uuid->blkid_find_dev_with_tag() call within FileStore::collect_metadata() is hanging for ~3 mins before returning a EINVAL. I saw this portion is newly added after hammer.
>>> Commenting it out resolves the issue. BTW, I saw this value is stored as metadata but not used anywhere , am I missing anything ?
>>> Here is my Linux details..
>>> 
>>> root@emsnode5:~/wip-write-path-optimization/src# uname -a Linux 
>>> emsnode5 3.16.0-38-generic #52~14.04.1-Ubuntu SMP Fri May 8 09:43:57 
>>> UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>> 
>>> 
>>> root@emsnode5:~/wip-write-path-optimization/src# lsb_release -a No 
>>> LSB modules are available.
>>> Distributor ID: Ubuntu
>>> Description:    Ubuntu 14.04.2 LTS
>>> Release:        14.04
>>> Codename:       trusty
>>> 
>>> Thanks & Regards
>>> Somnath
>>> 
>>> -----Original Message-----
>>> From: Somnath Roy
>>> Sent: Wednesday, September 16, 2015 2:20 PM
>>> To: 'Gregory Farnum'
>>> Cc: 'ceph-devel'
>>> Subject: RE: Very slow recovery/peering with latest master
>>> 
>>> 
>>> Sage/Greg,
>>> 
>>> Yeah, as we expected, it is not happening probably because of recovery settings. I reverted it back in my ceph.conf , but, still seeing this problem.
>>> 
>>> Some observation :
>>> ----------------------
>>> 
>>> 1. First of all, I don't think it is something related to my environment. I recreated the cluster with Hammer and this problem is not there.
>>> 
>>> 2. I have enabled the messenger/monclient log (Couldn't attach here) in one of the OSDs and found monitor is taking long time to detect the up OSDs. If you see the log, I have started OSD at 2015-09-16 16:13:07.042463 , but, there is no communication (only getting KEEP_ALIVE) till 2015-09-16 16:16:07.180482 , so, 3 mins !!
>>> 
>>> 3. During this period, I saw monclient trying to communicate with monitor but not able to probably. It is sending osd_boot at 2015-09-16 16:16:07.180482 only..
>>> 
>>> 2015-09-16 16:16:07.180450 7f65377fe700 10 monclient: 
>>> _send_mon_message to mon.a at 10.60.194.10:6789/0
>>> 2015-09-16 16:16:07.180482 7f65377fe700  1 -- 10.60.194.10:6820/20102 
>>> --> 10.60.194.10:6789/0 -- osd_boot(osd.10 booted 0 features 
>>> 72057594037927935 v45) v6 -- ?+0 0x7f6523c19100 con 0x7f6542045680
>>> 2015-09-16 16:16:07.180496 7f65377fe700 20 -- 10.60.194.10:6820/20102 submit_message osd_boot(osd.10 booted 0 features 72057594037927935 v45) v6 remote, 10.60.194.10:6789/0, have pipe.
>>> 
>>> 4. BTW, the osd down scenario is detected very quickly (ceph -w output) , problem is during coming up I guess.
>>> 
>>> 
>>> So, something related to mon communication getting slower ?
>>> Let me know if more verbose logging is required and how should I share the log..
>>> 
>>> Thanks & Regards
>>> Somnath
>>> 
>>> -----Original Message-----
>>> From: Gregory Farnum [mailto:gfarnum@redhat.com]
>>> Sent: Wednesday, September 16, 2015 11:35 AM
>>> To: Somnath Roy
>>> Cc: ceph-devel
>>> Subject: Re: Very slow recovery/peering with latest master
>>> 
>>>> On Tue, Sep 15, 2015 at 8:04 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>>>> Hi,
>>>> I am seeing very slow recovery when I am adding OSDs with the latest master.
>>>> Also, If I just restart all the OSDs (no IO is going on in the cluster) , cluster is taking a significant amount of time to reach in active+clean state (and even detecting all the up OSDs).
>>>> 
>>>> I saw the recovery/backfill default parameters are now changed (to lower value) , this probably explains the recovery scenario , but, will it affect the peering time during OSD startup as well ?
>>> 
>>> I don't think these values should impact peering time, but you could configure them back to the old defaults and see if it changes.
>>> -Greg
>>> 
>>> ________________________________
>>> 
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
