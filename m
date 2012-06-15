From: Wido den Hollander <wido@widodh.nl>
Subject: Re: mon disk access pattern
Date: Fri, 15 Jun 2012 11:51:35 +0200
Message-ID: <4FDB05A7.3080202@widodh.nl>
References: <4FDACD90.2080807@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52335 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab2FOJvi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 05:51:38 -0400
In-Reply-To: <4FDACD90.2080807@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 15-06-12 07:52, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i read somewhere that the mon has "special" disk access patterns - even
> though it does not write much data.

"special"? Where did you read that? The monitor has about 1 ~ 2GB of 
storage.

So if your monitor has something like 4GB ~ 8GB of RAM, your kernel 
should cache almost all your monitor data.

>
> I'm using a patched debian squeeze with syncfs support (thanks to amon).
> Are there any recommandations where to put the mon data? (SSD? Raid?
> Which FS?)
>

Something like a regular disk with ext4 should be fine, but you can 
always put in an SSD if you want that.

Wido

> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
