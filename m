From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 16:13:14 +0100
Message-ID: <4EEA0E8A.1000401@widodh.nl>
References: <1404301.on6okQVZ04@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:36458 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1LOPNO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 10:13:14 -0500
In-Reply-To: <1404301.on6okQVZ04@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 12/15/2011 04:07 PM, Guido Winkelmann wrote:
> Hi,
>
> I've got a small ceph cluster with one mon, one mds and two osds (all on the
> same machine, for now), that I want to use as a block- and file storage backend
> for qemu machine virtualisation.
>
> I found that read access to some of the rbd images, or parts of some of them
> sometimes blocks indefinitely, usually after the image has been sitting around
> untouched for a while, for example over night. This has the effect that virtual
> machines that try to access their disks as well as rbd commands like "rbd cp"
> will just hang indefinitely.
>
>   I found that these blocks can usually be "fixed" by restarting one of the
> osds.
>
> The last time this happened, ceph -s reported one of the osds to be in state
> "active+clean+scrubbing". (I'm afraid I don't have the complete output from
> ceph -s anymore.)

I've been seeing the exact same behaviour, but I wasn't able yet to get 
into it a bit deeper.

As far as I know, when a PG gets scrubbed it become unavailable for a 
short period, but since this scrub blocks/loops the PG will never become 
available again, thus blocking the virtual machine.

I saw this behaviour with v0.37 and 0.38, upgrading to 0.39 to see if it 
still exists.

Wido

>
> Does anybody have any idea what could be going wrong here?
>
> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

