From: Wido den Hollander <wido@widodh.nl>
Subject: Re: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 16:59:27 +0200
Message-ID: <4FBA584F.7070406@widodh.nl>
References: <4FBA54E2.3000703@profihost.ag> <4FBA559D.7040902@widodh.nl> <4FBA5647.40101@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38522 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173Ab2EUPAk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 11:00:40 -0400
In-Reply-To: <4FBA5647.40101@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/21/2012 04:50 PM, Stefan Priebe - Profihost AG wrote:
> Am 21.05.2012 16:47, schrieb Wido den Hollander:
>> What do you mean the OSD crashes? I assume you have multiple OSD's in
>> your cluster and one of them crashes? Or do ALL of them do go down?
> 2 of them went down (1st then 10 minutes later the 2nd)
>
>>> What's next / wrong?
>>
>> Could you fetch the last 100 line from the log file and also tell us
>> which version you are running?
> i'm upgrading right now to v0.47 and will try to reproduce.
>
>> Also, the output of "ceph -s" might be useful.
> before or after the crash?

Probably after, but both is fine. I just want to know how your cluster 
is doing and what the PG states are.

Wido

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

