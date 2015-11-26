From: Sage Weil <sage@newdream.net>
Subject: Re: rgw/civetweb privileged port bind
Date: Thu, 26 Nov 2015 11:38:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511261136380.12118@cobra.newdream.net>
References: <20151126192548.GA27729@oak.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53468 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbKZTi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Nov 2015 14:38:27 -0500
In-Reply-To: <20151126192548.GA27729@oak.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Mroz <kmroz@suse.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 26 Nov 2015, Karol Mroz wrote:
> Hello,
> 
> As I understand it, with the release of infernalis, ceph
> daemons are no longer being run as root. Thus, rgw/civetweb
> is unable to bind to privileged ports:
> 
> http://tracker.ceph.com/issues/13600
> 
> We encountered this problem as well in our downstream (hammer
> based) product, where we run rgw/civetweb as "wwwuser". To allow
> privileged port binding, we used file caps (setcap from the spec file).
> Going forward, however, we were thinking of taking one of two
> approaches:
> 
> 1. Start rgw/civetweb as root and utilize an existing civetweb
> config option (run_as_user) to drop permissions _after_
> the port bind and after certificate files have been read.
>
> 2. Utilize systemd socket activation, and allow systemd to bind
> to the necessary port. Once rgw/civetweb is started, civetweb
> can pull the listening socket from systemd.
> 
> Is this something you folks upstream have given some thought to?

I haven't. #2 sounds like it's harder, and I'm not sure it brings a lot fo 
benefit. Making #1 work is probably super simple (replace our set user 
option with the civetweb one?)...

What do you suggest?

sage
