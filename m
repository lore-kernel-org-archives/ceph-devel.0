From: Sage Weil <sage@newdream.net>
Subject: Re: osd logging
Date: Thu, 14 Jan 2016 08:51:40 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601140851310.26381@cpach.fuggernut.com>
References: <56970DE3.3070904@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59419 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbcANNvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 08:51:37 -0500
In-Reply-To: <56970DE3.3070904@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 13 Jan 2016, Dan Mick wrote:
> Watching osd logs, diagnosing a problem, I note a lot of level-5
> messages of the form
> 
> tick
> 
> and
> 
> tick_without_osd_lock
> 
> Anyone else think those ought to be a higher debug level?  They're
> awfully noisy for debug set to 5.

Yep...

	https://github.com/ceph/ceph/pull/7234

sage
