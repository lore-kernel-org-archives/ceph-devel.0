From: Sage Weil <sweil@redhat.com>
Subject: Re: Permissions for /run/ceph
Date: Wed, 6 Apr 2016 10:39:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604061038210.19675@cpach.fuggernut.com>
References: <CADr68WZ+A7YLb1OF7RdijqKMyD9em1jCuprgqXWAFB0810Go+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbcDFOjV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Apr 2016 10:39:21 -0400
In-Reply-To: <CADr68WZ+A7YLb1OF7RdijqKMyD9em1jCuprgqXWAFB0810Go+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Rosenboom <j.rosenboom@x-ion.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 6 Apr 2016, Jens Rosenboom wrote:
> Hi Sage,
> 
> in https://github.com/ceph/ceph/commit/3aa38bc07f84f452d70757585ef2620ee60ee227
> you changed the permissions from 0755 to 0770. The description of the
> commit only talks about making the directory group-writable, so I'm
> failing to see why this should not be world-readable anymore.
> 
> In particular this breaks our monitoring, which tries to check things
> with a different user. That used to work earlier, because the sockets
> themselves are still 0755.
> 
> Was this just an oversight and you really meant to change it to 0775?
> Or is there some other argument that I am not seeing yet?

I think I was just erring on the side of private.  I don't see any reason 
not to switch it to 0775.  It highlights that we should be careful with 
the mode on the socket files we put there, but that was already true.

sage
