From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD Backup
Date: Wed, 21 Nov 2012 22:29:59 +0800
Message-ID: <50ACE567.9090704@widodh.nl>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl> <50ACDD9A.5050405@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54503 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab2KUOaG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 09:30:06 -0500
In-Reply-To: <50ACDD9A.5050405@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 11/21/2012 09:56 PM, Stefan Priebe - Profihost AG wrote:
> Hi Wido,
>
> thanks for all your explanations.
>
> This doesn't seem to work:
>> rbd export --snap BACKUP <img> <dest>
>
> rbd -p kvmpool1 export --snap BACKUP vm-101-disk-1 /vm-101-disk-1.img
> rbd: error setting snapshot context: (2) No such file or directory
>
> Or should i still create and delete a snapshot named BACKUP before doing
> this?
>

Yes, you should create the snapshot first before exporting it. Export 
does not create the snapshot for you.

Wido

> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
