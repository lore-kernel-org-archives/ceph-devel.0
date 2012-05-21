From: Wido den Hollander <wido@widodh.nl>
Subject: Re: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 16:47:57 +0200
Message-ID: <4FBA559D.7040902@widodh.nl>
References: <4FBA54E2.3000703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:36227 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab2EUOr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 10:47:59 -0400
In-Reply-To: <4FBA54E2.3000703@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 05/21/2012 04:44 PM, Stefan Priebe - Profihost AG wrote:
> Hi List,
>
> i'm testing the ceph / rbd block device with qemu and KVM. The creation
> of a new disk went fine and i can also access the disk from the KVM client.
>
> But after a short time while installing debian squeeze the osd seems to
> crash and i see /core files on my machines.

What do you mean the OSD crashes? I assume you have multiple OSD's in 
your cluster and one of them crashes? Or do ALL of them do go down?

>
> What's next / wrong?

Could you fetch the last 100 line from the log file and also tell us 
which version you are running?

Also, the output of "ceph -s" might be useful.

Wido

>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

