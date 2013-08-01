From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 01 Aug 2013 21:07:59 +0200
Message-ID: <51FAB20F.3030707@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com> <51FAAED3.3010509@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:59628 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3HATIC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 15:08:02 -0400
In-Reply-To: <51FAAED3.3010509@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mike we already have the async patch running. Yes it helps but only 
helps it does not solve. It just hides the issue ...
Am 01.08.2013 20:54, schrieb Mike Dawson:
> I am also seeing recovery issues with 0.61.7. Here's the process:
>
> - ceph osd set noout
>
> - Reboot one of the nodes hosting OSDs
>      - VMs mounted from RBD volumes work properly
>
> - I see the OSD's boot messages as they re-join the cluster
>
> - Start seeing active+recovery_wait, peering, and active+recovering
>      - VMs mounted from RBD volumes become unresponsive.
>
> - Recovery completes
>      - VMs mounted from RBD volumes regain responsiveness
>
> - ceph osd unset noout
>
> Would joshd's async patch for qemu help here, or is there something else
> going on?
>
> Output of ceph -w at: http://pastebin.com/raw.php?i=JLcZYFzY
>
> Thanks,
>
> Mike Dawson
> Co-Founder & Director of Cloud Architecture
> Cloudapt LLC
> 6330 East 75th Street, Suite 170
> Indianapolis, IN 46250
>
> On 8/1/2013 2:34 PM, Samuel Just wrote:
>> Can you reproduce and attach the ceph.log from before you stop the osd
>> until after you have started the osd and it has recovered?
>> -Sam
>>
>> On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> Hi,
>>>
>>> i still have recovery issues with cuttlefish. After the OSD comes back
>>> it seem to hang for around 2-4 minutes and then recovery seems to start
>>> (pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
>>> get a lot of slow request messages an hanging VMs.
>>>
>>> What i noticed today is that if i leave the OSD off as long as ceph
>>> starts to backfill - the recovery and "re" backfilling wents absolutely
>>> smooth without any issues and no slow request messages at all.
>>>
>>> Does anybody have an idea why?
>>>
>>> Greets,
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
