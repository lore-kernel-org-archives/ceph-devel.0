From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Fs to use?
Date: Tue, 06 Nov 2012 10:26:18 +0100
Message-ID: <5098D7BA.3080900@widodh.nl>
References: <44586A02-C7FB-423A-9CF4-5470FE417581@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40775 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2KFJ0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 04:26:20 -0500
In-Reply-To: <44586A02-C7FB-423A-9CF4-5470FE417581@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 06-11-12 07:54, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> is there any recommendation regarding fs? I mean btrfs is still experimental would you still use it with ceph in production? Do I need big metadata with btrfs? (seems to make btrfs slow)
>

XFS seems to be the recommendation right now. Although in the long term 
goal you want btrfs due to the checksumming you might be best off with 
XFS at the moment.

Wido

> Greets
> Stefan--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
