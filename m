From: Wido den Hollander <wido@widodh.nl>
Subject: Re: General question about a testbed
Date: Thu, 08 Mar 2012 17:11:51 +0100
Message-ID: <4F58DA47.5080500@widodh.nl>
References: <1331195839.14554.29.camel@zitpcx6759.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49969 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980Ab2CHQLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 11:11:54 -0500
In-Reply-To: <1331195839.14554.29.camel@zitpcx6759.desy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sven Sternberger <sven.sternberger@desy.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 03/08/2012 09:37 AM, Sven Sternberger wrote:
> Hello!
>
> I want to set up a testbed for evaluating
> ceph. At this point we want to look at the performance
> and the administration of a small cluster (4 machines,
> 60TB)
>
> So neither ceph nor btrfs are good supported by
> ScientificLinux which we use.

Instead of btrfs you could also use ext4 (with user_xattr!).
>
> It would be helpful if you could point out which
> linux distributions gives an easy starting point.
> Should we use an recent kernel, or go with the distribution
> default.

I'm running my cluster(s) on Ubuntu 11.10. For the OSD's you don't have 
to run the latest kernel, but if you decide to use btrfs it could be a 
good idea to use a new kernel. btrfs is still under development, it 
get's better with every kernel.

I think the main test systems of the dev's are running Debian, so that 
might be a good choice. Debian packages are available on the Ceph 
website or can easily be build from source.

When you want to use the kernel client (CephFS / POSIX filesystem) I 
recommend using a recent kernel on the client, same story was with btrfs.

Wido

>
> best regards!
>
> Sven
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

