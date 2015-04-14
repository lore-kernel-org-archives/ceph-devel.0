From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Regarding newstore performance
Date: Mon, 13 Apr 2015 19:06:50 -0500
Message-ID: <552C5A1A.4030201@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD78CA3@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54380 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbbDNAGx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 20:06:53 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD78CA3@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,  I'm running similar tests right now looking at newstore 
with 8m and no overlay on spinning disk, spinning disk + SSD WAL, and 
SSD.  Should have results in the next hour or two.

Mark

On 04/13/2015 06:53 PM, Somnath Roy wrote:
> Sage,
> I was doing some preliminary performance testing of newstore on a single OSD (SSD) , single replication setup. Here is my findings so far.
>
> Test:
> -----
>
>          64K random writes with QD= 64 using fio_rbd.
>
> Results :
> ----------
>
>          1. With all default settings, I am seeing very spiky performance. FIO is reporting between 0-~1K random write IOPS with many times IO stops at 0s...Tried with bigger overlay max size value but results are similar...
>
>          2. Next I set the newstore_overlay_max = 0 and I got pretty stable performance ~800-900 IOPS (write duration is short though).
>
>          3. I tried to tweak all the settings one by one but not much benefit anywhere.
>
>          4. One interesting observation here, in my setup if I set newstore_sync_queue_transaction = true , I am getting iops ~600-700..Which is ~100 less.
>               This is quite contrary to my keyvaluestore experiment where I got ~3X improvement by doing sync  writes !
>
>          5. Filestore performance in the similar setup is ~1.6K after 1 TB of data write.
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
>
