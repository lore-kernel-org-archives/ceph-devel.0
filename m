From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 09:05:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
 <87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33610 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab1BYRDx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 12:03:53 -0500
In-Reply-To: <87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Colin Patrick McCabe <colin.mccabe@dreamhost.com>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Fri, 25 Feb 2011, Gregory Farnum wrote:
> I think you guys talked about this yesterday -- sorry I missed it -- but 
> what's the logic behind this new name "rados_rollback"? It's not quite 
> working for me -- I think because it lacks the noun. :) Could we at 
> least do rados_object_rollback()? Or even 
> rados_object_rollback_to_snap()?

It matches rados_write, read, remove, etc.   Either they all get 
rados_object_ prefix or none do.  I'm fine with either...

sage
