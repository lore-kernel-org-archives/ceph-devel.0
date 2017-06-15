From: Sage Weil <sage@newdream.net>
Subject: Re: Cluster log: hiding cluster map prints, decreasing audit log
 messages
Date: Thu, 15 Jun 2017 19:27:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706151924590.32272@piezo.novalocal>
References: <CALe9h7cVUB-H8aeXGRFPFOeTe+nFyMZ=Obmqr4P527gmR7268A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43845 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdFOT1F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 15:27:05 -0400
In-Reply-To: <CALe9h7cVUB-H8aeXGRFPFOeTe+nFyMZ=Obmqr4P527gmR7268A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 15 Jun 2017, John Spray wrote:
> Some musings from me about the cluster log, interested in others' thoughts.
> 
> Audit log
> =======
> 
> The audit logging is nice, but it has a couple of noticeable annoyances:
>  - it crowds out real health messages, e.g. when using the new "log
> last" command you may see mostly see audit log messages, especially if
> a monitoring tool is polling some commands.
>  - the messages themselves are ugly JSON dumps
> 
> We already have a separate channel for these, so it's easy for UIs to
> split out the audit stuff (I just did this in the dashboad module),
> but I think they're still consuming some number of the lines when we
> fetch a set number of lines using "log last".
> 
> Maybe things like log last (and the internal buffering in the mon)
> should keep N lines for each channel, rather than channels competing
> for the space?  It might already be like that on some level, haven't
> dug into the mon internals yet.

- last N for each channel makes sense to me.  The way LogMonitor 
implements this needs a bit of cleanup at the same time.
- I think it makes sense to only show the 'default' channel by default and 
ignore all others (including audit log) unless asked for?  I guess this 
would add a channel option to 'last' that takes either the channel name 
(audit or default) or '*' or 'all' for all.

> Cluster maps
> ===========
> 
> It is very nice for debugging that we can see updates to osdmap/fsmap
> ticking by as the mon updates the state of the system.  However, it
> kind of disrupts our ability to output clearly readable log messages
> for ordinary users when things changed.
> 
> Maybe the cluster maps should be on a separate channel, like the audit logs are?
> 
> Of course, when we're hiding the low level cluster map prints away, we
> need to at the same time make sure we're adding in the right high
> level "OSD 123 went down" messages to replace where the "osdmap e456
> ..." lines currently give you the hint that something happened.

We could also just put these at the DBG level so that they are hidden by 
default...

sage
