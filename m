From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 01 Aug 2013 14:54:11 -0400
Message-ID: <51FAAED3.3010509@cloudapt.com>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:39770 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716Ab3HASyL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:54:11 -0400
Received: by mail-ve0-f169.google.com with SMTP id db10so2798134veb.0
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 11:54:10 -0700 (PDT)
In-Reply-To: <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am also seeing recovery issues with 0.61.7. Here's the process:

- ceph osd set noout

- Reboot one of the nodes hosting OSDs
     - VMs mounted from RBD volumes work properly

- I see the OSD's boot messages as they re-join the cluster

- Start seeing active+recovery_wait, peering, and active+recovering
     - VMs mounted from RBD volumes become unresponsive.

- Recovery completes
     - VMs mounted from RBD volumes regain responsiveness

- ceph osd unset noout

Would joshd's async patch for qemu help here, or is there something else 
going on?

Output of ceph -w at: http://pastebin.com/raw.php?i=JLcZYFzY

Thanks,

Mike Dawson
Co-Founder & Director of Cloud Architecture
Cloudapt LLC
6330 East 75th Street, Suite 170
Indianapolis, IN 46250

On 8/1/2013 2:34 PM, Samuel Just wrote:
> Can you reproduce and attach the ceph.log from before you stop the osd
> until after you have started the osd and it has recovered?
> -Sam
>
> On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi,
>>
>> i still have recovery issues with cuttlefish. After the OSD comes back
>> it seem to hang for around 2-4 minutes and then recovery seems to start
>> (pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
>> get a lot of slow request messages an hanging VMs.
>>
>> What i noticed today is that if i leave the OSD off as long as ceph
>> starts to backfill - the recovery and "re" backfilling wents absolutely
>> smooth without any issues and no slow request messages at all.
>>
>> Does anybody have an idea why?
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
