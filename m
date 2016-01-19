From: Wido den Hollander <wido@42on.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Tue, 19 Jan 2016 16:34:40 +0100
Message-ID: <569E5790.1090905@42on.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:55261 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbcASPel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 10:34:41 -0500
In-Reply-To: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org



On 19-01-16 16:15, Sage Weil wrote:
> I think we should add an optional 'config' file location to the config 
> search path.  This would allow you to put customized options for an 
> individual daemon in the daemon data directory.  Or, you could avoid 
> putting a config in /etc/ceph entirely, so that the daemon data is 
> completely self-contained on the device.  That would streamline boot disk 
> failure (just reinstall OS and ceph package) or drive swaps between failed 
> host hardware.
> 
> What do you think?

I think that's an awesome idea. Simply plug in the disk, mount it and run!

Yes, this would make life a lot easier.

Wido

> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
