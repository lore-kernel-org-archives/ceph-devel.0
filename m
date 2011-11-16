From: Sage Weil <sage@newdream.net>
Subject: Re: rbd format check
Date: Wed, 16 Nov 2011 10:40:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111161035050.22555@cobra.newdream.net>
References: <4EC2EED6.9040509@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44718 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab1KPSko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 13:40:44 -0500
In-Reply-To: <4EC2EED6.9040509@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 15 Nov 2011, Josh Durgin wrote:
> I added a simple check for the old version in the wip-rbd-layering branch of
> ceph and ceph-client.git. If that looks good and you want to push it upstream,
> maybe grab the rollback removal from wip-rollback as well.

On the librbd side, let's add a dout(0 or 1) so that we can figure out why 
things are failing.  Ideally we could use a distinct error code too so 
that the tools can report an appropriate error message, altho looking at 
errno-base.h nothing looks like an obvious choice.

For the kernel code, a pr_info or pr_warn would be good so that something 
useful up on the console.  And again, a distinct error code would be nice 
so that 'rbd map ...' can print something helpful to stderr...

sage
