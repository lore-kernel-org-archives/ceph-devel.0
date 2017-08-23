From: Sage Weil <sage@newdream.net>
Subject: Re: Matching shard to crush bucket in erasure coding
Date: Wed, 23 Aug 2017 14:04:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708231400590.20435@piezo.novalocal>
References: <CAODUPsG=wnHdROuNvvCcxeDtahG2V2C24ttEETJtebCGnx6C8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32865 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbdHWOEL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 10:04:11 -0400
In-Reply-To: <CAODUPsG=wnHdROuNvvCcxeDtahG2V2C24ttEETJtebCGnx6C8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 22 Aug 2017, Oleg Kolosov wrote:
> Hi
> I'm working on a new erasure code, different than the one implemented
> in ceph lrc plugin. I'm trying to understand how ceph lrc plugin
> allocates shards in a layer, but it's not clear from the code.
> 
> For example, say I have a local group containing shards 0,1,2,5
> While 0,1,2 are data and 5 is parity. I'd like to place all of these
> shards in the same rack.
> 
> Where in lrc .cc code  these shards, which are composing a single
> layer, are allocated to the same rack?

The EC code has to be carefully matched with a CRUSH rule that lays things 
out properly.  This is the reason that the EC crush rules are tied 
to the erasure code profiles and the plugin handles rule creation.

In the LRC case, you have a rule like

 take root
 choose 3 rack
 choose 5 osd

to get a set of 15 shards, in groups of 5.  The LRC plugin has some logic 
to put the original data shards in the first 3 or 4 shards of each of 
those sets of 5, and the parity blocks in the remaing slots.  You'll want 
to do something similar.  Bonus points if you can reuse the scheme that 
LRC uses...

sage
