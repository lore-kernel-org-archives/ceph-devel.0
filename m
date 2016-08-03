From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: CephFs performance data
Date: Wed, 3 Aug 2016 16:27:41 -0600
Message-ID: <CA+9C14bNnr0jcZWEdgpjjf4Ty=Ge0gHSEoGDGLBwQysZvAYXtw@mail.gmail.com>
References: <BL2PR02MB211528CE823D5728C3A474ACF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
 <906232803.11790446.1470252831523.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34301 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcHCW31 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 18:29:27 -0400
Received: by mail-vk0-f48.google.com with SMTP id s189so156816519vkh.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2016 15:27:42 -0700 (PDT)
In-Reply-To: <906232803.11790446.1470252831523.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben England <bengland@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ben,

That was a great presentation you gave this morning and thank you for
sending out the slides.  I was wondering if you could provide the
ceph.conf file you used for the tests?  I think you stated during the
presentation that you increased the buffer size on the FUSE mounted
clients.  If this is true, how did you do it and what setting did you
use.

Thanks,
Eric

On Wed, Aug 3, 2016 at 1:33 PM, Ben England <bengland@redhat.com> wrote:
> Thanks Somnath, here are the Cephfs slides from this morning.
>
> https://s3.amazonaws.com/ben.england/Cephfs+performance+results+June+2016.pdf
>
> Let me know if you have trouble reading them.
>
> As for sequential 4-KB I/O performance, I believe kernel Cephfs client is aggregating reads and writes - otherwise you are quite right that the IOPS level could not be sustained.  This is common practice in other distributed filesystems as well, such as NFS and Gluster.  For RANDOM I/O, coalescing of I/O requests is far less likely.   I have some performance data on these runs that should be useful in confirming the result, will try to look that up for you.
>
> I'm looking forward to hearing other people's results with Cephfs as well.
>
> -ben
>
>
> ----- Original Message -----
>> From: "Somnath Roy" <Somnath.Roy@sandisk.com>
>> To: "Ben England (bengland@redhat.com)" <bengland@redhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, August 3, 2016 12:23:21 PM
>> Subject: CephFs performance data
>>
>> Ben,
>> Thanks for the first cut data on CephFS , it was really helpful.
>> Do you mind to send out the slides ?
>> Also, continuing the discussion on 4K SW throughput is ~1GB/S , if you are
>> running test with direct IO, client Linux system can't coalesce the writes
>> and I didn't see much coalescing at the OSD servers as well. Unless CephFS
>> has some coalescing logic it will be good if we can find out how we are
>> getting this bigger throughput for 4K. Let me know if I am missing
>> something..
>>
>> Thanks & Regards
>> Somnath
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
