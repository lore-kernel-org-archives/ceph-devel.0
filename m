From: Sage Weil <sage@inktank.com>
Subject: Re: Wireshark Dissector
Date: Tue, 18 Mar 2014 17:04:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403181659470.5823@cobra.newdream.net>
References: <5328DDAB.3050606@kevincox.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60080 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaCSAEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Mar 2014 20:04:44 -0400
In-Reply-To: <5328DDAB.3050606@kevincox.ca>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Cox <kevincox@kevincox.ca>
Cc: yehuda@inktank.com, ceph-devel@vger.kernel.org

Hi Kevin,

On Tue, 18 Mar 2014, Kevin Cox wrote:
> Hello Sage,
> 
> I was finishing up my proposal to write the wireshark dissector and was
> wondering how I should segment my work.  In order to ensure I stay on
> track I will set goals for every couple of weeks but am unsure of how to
> slice the work up.
> 
> I have looked that the files suggested by Patrick and some of the
> implementation behind them but I haven't got a solid grasp of the full
> protocol.  From what I can see there appears to be a "core" protocol
> which is used by all node types then there are separate client, mon,
> osd, and mds messages.  After dissecting the basic message format do you
> recommend proceeding by message "area" or is there another order which
> you would take?  Also relatively how much time do you expect each "area"
> to take, from what I have seen they are roughly the same size but I'm
> sure you have a better guess.

I think you're on the right track.  I suspect it would go something like:

 - get environment, infrastructure up and running
 - parse basic message exhcange, but not messages
 - add support for individual message types by subsystem
   - mon<->client (including authentication and such)   (small)
   - osd<->client    (small)
   - osd<->osd       (big)
   - mon<->mon       (medium)
   - client<->mds    (medium)
   - mds<->mds       (big)

The nice thing here is that the stop point is moveable.  Getting the 
basics in place will make it easy for others to add or update additional 
message decodings later, and with just the few most common messages the 
tool is immediately useful.

At some point early I would engage with the Wireshark folks too to make 
sure things are appropriate for upstreaming.  Getting the initial support 
in early and following up with support for additional message types later 
might be a good strategy as well.

> PS: Is it better to talk privately or to send these messages to the
> list?  If you think that they can be useful to others feel free to copy
> the list on your reply.

Copying the list is great as long as you're comfortable with it. :)

Thanks!
sage
