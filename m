From: Sage Weil <sage@inktank.com>
Subject: Re: chaos monkeys
Date: Tue, 9 Oct 2012 09:46:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210090944140.11453@cobra.newdream.net>
References: <5074541B.4000504@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56610 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab2JIQqt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 12:46:49 -0400
In-Reply-To: <5074541B.4000504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

[moved to ceph-devel]

On Tue, 9 Oct 2012, Sam Lang wrote:
> Could we add some other chaos monkeys to the network/storage infrastructure
> besides ms_inject_socket_failures?  In particular, I would like to add
> ms_inject_delay_msg and ms_inject_reorder_msgs?  I think those could
> potentially help flush out some bugs (such as:
> https://github.com/ceph/ceph/commit/fa66eaa162542ac01752ada91a46051dde060831).
> 
> Right now I'm particularly interested in network delays, but we should
> probably add storage delays as well.
> 
> Maybe something like this already exists and I'm just not finding it?

Injecting message delays is a great idea, and pretty straightforward... 
let's do it!  Maybe a combination of 'ms inject delay max' and 'ms inject 
delay probability' (default 0)?

Reordering messages isn't allowed to happen; if we do see out of order 
delivery, it is a bug in the messenger code, and not something higher 
layeers should need to worry about.

sage
