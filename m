From: Sage Weil <sage@newdream.net>
Subject: Re: mon: forwarding user commands
Date: Sun, 18 Jan 2015 10:33:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501181030070.8527@cobra.newdream.net>
References: <20150118092815.GA2488@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40875 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbARSdH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jan 2015 13:33:07 -0500
In-Reply-To: <20150118092815.GA2488@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 18 Jan 2015, Mykola Golub wrote:
> Hi Ceph,
> 
> Right now, for not a monitor leader, if a received command is not
> supported locally, but is supported by the leader, it is forwarded to
> the leader.
> 
> For the recently added "ceph tell mon.x version" it gives a confusing
> behavior: if the mon.x is not a leader and does not support "version"
> command yet, but the leader does, the user will receive the version of
> the leader, and can't be actually sure about a non leader version.
> 
> I have a patch that fixes this by checking if the received "version"
> command is forwarded and returning the error in this case:
> 
> https://github.com/trociny/ceph/commit/98f835357e378b1c5f05b32ba90a8b8537ba1ad8
> 
> But may be we need a more general solution? We might face a similar
> issue in future, when adding a new command, which is not expected to
> be forwarded to the leader (like injectargs).

Yeah.. that works for 'version' but not any other 'tell mon ...' command.

I think the way to do it properly going forward is to add a flags field to 
MMonCommand, with a flag NOFORWARD.

That won't help in the version case, so we can combine it with your 
patch...

sage
