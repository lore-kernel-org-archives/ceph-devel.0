From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to upgrade ceph.
Date: Fri, 05 Oct 2012 16:13:05 +0200
Message-ID: <506EEAF1.9040306@widodh.nl>
References: <loom.20121005T111634-599@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:53190 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab2JEONI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Oct 2012 10:13:08 -0400
In-Reply-To: <loom.20121005T111634-599@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 10/05/2012 11:18 AM, ramu eppa wrote:
> Hi all,
>      I want upgrade ceph from ceph-0.47.2 to 0.52.
> Can give steps to upgrade ceph.
>

I think you are running on Ubuntu 12.04? That's what I'm assuming.

Between 0.47.2 and 0.52 there is a on-disk format change, this happened 
at 0.48[0]

I'd advise to to a upgrade from 0.47.2 to 0.48.2[1] first.

When you are running stable on 0.48.2 you can do the upgrade to 0.52, 
but for now 0.48.2 is the first "stable" release, so you might want to 
stick with that first.

Wido

[0]: http://ceph.com/releases/v0-48-argonaut-released/
[1]: http://ceph.com/releases/v0-48-2-argonaut-stable-update-released/

> Thanks,
> Ramu.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

