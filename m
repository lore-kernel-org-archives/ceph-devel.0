From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 09:01:06 -0600
Message-ID: <50CB3F32.2070106@inktank.com>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42275 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNPBG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:01:06 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3195721iay.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 07:01:06 -0800 (PST)
In-Reply-To: <50CB3D33.7070800@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/14/2012 08:52 AM, Dennis Jacobfeuerborn wrote:
> On 12/14/2012 10:14 AM, Stefan Priebe wrote:
>> One more IMPORTANT note. This might happen due to the fact that a disk was
>> missing (disk failure) afte the reboot.
>>
>> fstab and mountpoint are working with UUIDs so they match but the journal
>> block device:
>> osd journal  = /dev/sde1
>>
>> didn't match anymore - as the numbers got renumber due to the failed disk.
>> Is there a way to use some kind of UUIDs here too for journal?
>
> You should be able to use /dev/disk/by-uuid/* instead. That should give you
> a stable view of the filesystems.

I often map partitions to something in /dev/disk/by-partlabel and use 
those in my ceph.conf files.  that way disks can be remapped behind the 
scenes and the ceph configuration doesn't have to change even if disks 
get replaced.

>
> Regards,
>    Dennis
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

