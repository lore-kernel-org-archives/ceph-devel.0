From: Sage Weil <sweil@redhat.com>
Subject: Re: Why does crushtool send all it's output to stderr?
Date: Thu, 17 Jul 2014 14:06:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407171406000.3932@cobra.newdream.net>
References: <53C8391D.8020300@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57113 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120AbaGQVG0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 17:06:26 -0400
In-Reply-To: <53C8391D.8020300@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 17 Jul 2014, Wido den Hollander wrote:
> Hi,
> 
> When running tests on a crushmap with crushtool it noticed that all output is
> send to stderr, for example:
> 
> $ crushtool -i cm --test --rule 4 --num-rep 3 --show-statistics
> 
> All the output goes to stderr while I think stdout would be a better place.
> 
> Any good reason for this?

Nope!  There's a lot that could be improved here from a UX standpoint, I 
think.  :)

sage
