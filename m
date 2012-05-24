From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 09:28:20 +0200
Message-ID: <4FBDE314.7030305@widodh.nl>
References: <4FBDDCAE.7040709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56615 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2EXH2Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 03:28:25 -0400
In-Reply-To: <4FBDDCAE.7040709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 24-05-12 09:01, Stefan Priebe - Profihost AG wrote:
> Hi,
>
> every rados bench write uses disk space and my space fills up. How to
> free this space again?
>
> Used command?
> rados -p data bench 60 write -t 16

What does this show:

$ rados -p data ls|wc -l

If that shows something greater than 0 it means you still have objects 
in that pool which are using up space.

Try removing those objects manually. Be cautious not to remove any other 
objects!

To be safe I'd recommend running benchmark commands in a separate pool.

Also note that when you remove objects it will take some time before the 
OSD's have removed them and you see the usage go down with "ceph -s".

Wido

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
