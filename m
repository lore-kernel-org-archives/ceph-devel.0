From: Sage Weil <sweil@redhat.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 7 Jul 2014 12:29:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
References: <53BACB03.5010603@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47982 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaGGT3X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 15:29:23 -0400
In-Reply-To: <53BACB03.5010603@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Pabon <lpabon@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 7 Jul 2014, Luis Pabon wrote:
> Hi all,
>     I am working on OSDMonitor.cc:5325 and wanted to confirm the following
> read_forward cache tier transition:
> 
>     readforward -> forward || writeback || (any && num_objects_dirty == 0)
>     forward -> writeback || readforward || (any && num_objects_dirty == 0)
>     writeback -> readforward || forward
> 
> Is this the correct cache tier state transition?

That looks right to me.

By the way, I had a thought after we spoke that we probably want something 
that is somewhere inbetween the current writeback behavior (promote on 
first read) and the read_forward behavior (never promote on read).  I 
suspect a good all-around policy is something like promote on second read?  
This should probably be rolled into the writeback mode as a tunable...

sage


