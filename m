From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:31:22 +0100
Message-ID: <4EEA20DA.3030006@tuxadero.com>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48566 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758988Ab1LOQbd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 11:31:33 -0500
In-Reply-To: <3807778.ycpoZxnZL4@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hi Guido,
I am running ceph version 0.39-37-g54758ab 
(commit:54758abccf429122c1bc3bce6d01bc33f1cfe238) on my cluster and I do 
not see this problem. Do you use the qemu rbd block driver or the kernel 
mount?
How did you install ceph, via the packages?

-martin


Am 15.12.2011 16:45, schrieb Guido Winkelmann:
> Am Donnerstag, 15. Dezember 2011, 17:32:25 schrieben Sie:
>> On 12/15/2011 05:07 PM, Guido Winkelmann wrote:
>>> Hi,
>>>
>>> I've got a small ceph cluster with one mon, one mds and two osds (all on
>>> the same machine, for now), that I want to use as a block- and file
>>> storage backend for qemu machine virtualisation.
>>>
>>> I found that read access to some of the rbd images, or parts of some of
>>> them sometimes blocks indefinitely, usually after the image has been
>>> sitting around untouched for a while, for example over night. This has
>>> the effect that virtual machines that try to access their disks as well
>>> as rbd commands like "rbd cp" will just hang indefinitely.
>>>
>>>   I found that these blocks can usually be "fixed" by restarting one of
>>>   the>
>>> osds.
>>>
>>> The last time this happened, ceph -s reported one of the osds to be in
>>> state "active+clean+scrubbing". (I'm afraid I don't have the complete
>>> output from ceph -s anymore.)
>>>
>>> Does anybody have any idea what could be going wrong here?
>>
>> I think it's fixed in v0.39
>
> I'm already using 0.39, so, no. (Should have mentioned that to start with...)
>
>          Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

