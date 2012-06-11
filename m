From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Journal size of each disk
Date: Mon, 11 Jun 2012 10:35:21 +0200
Message-ID: <4FD5ADC9.3080208@widodh.nl>
References: <8512670932FB654F81AF0FEF1BE6D49D017E52FD@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:44848 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2FKIfY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 04:35:24 -0400
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D017E52FD@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi,

On 06/11/2012 08:47 AM, Eric_YH_Chen@wiwynn.com wrote:
> Dear all:
>
>      I would like to know if the journal size influence the performance
> of disk.
>
>      If the size of each of my disk is 1T, how much size should I prepare
> for the journal?
>

You journal should be able to hold the writes for a short period of 
time, something like 10 ~ 20 seconds.

If your machine is on a 1Gbit line it will do something like 100MB/sec 
of writes.

100MB * 20 seconds = 2000MB

So a journal of something like 2GB should be enough.

You can always scale it bigger to 4GB, that won't hurt anything.

So it doesn't depend on the size of your data disk, but depends on how 
fast the writes are coming in.

Wido

>      Thanks for any comment.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
