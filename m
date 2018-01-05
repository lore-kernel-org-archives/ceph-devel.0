From: Sage Weil <sweil@redhat.com>
Subject: Re: mon config storage (config-key vs config)
Date: Fri, 5 Jan 2018 23:51:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801052347040.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal> <alpine.LSU.2.21.1801051525330.27069@smaug>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbeAEXvy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 18:51:54 -0500
In-Reply-To: <alpine.LSU.2.21.1801051525330.27069@smaug>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Jan 2018, Jesse Williamson wrote:
> On Fri, 5 Jan 2018, Sage Weil wrote:
> 
> > mgr/dashboard/server_port = 7000
> 
> I like this style. There could be an "all" or "shared" magic root for items
> that are shared everywhere, and (though I admit this feels a bit half-baked,

The thing to keep in mind here is that the module options are pretty much 
freeform.  The normal config options have a pretty strict schema.

> I'm thowing it out there) maybe something like:
>
> shared/osd,mon/max_threads = foo

Maaaybe... this makes me nervous, and I'm not sure this has big benefits 
over just setting 2 separate options.

> > OSDMap creation only).  Is there a way we can realistically rename some of
> > these options, perhaps as part of the ceph.conf -> mon config transition?
> 
> I feel like if there are going to be visible configuration changes, then it's
> a good time to break things. Maybe it's possible to make the "old" names work
> for the next release, but give a deprecation warning? A script that can do
> migration?

I think we could annotate the options with "old" names so they get parsed 
properly.  And deprecate them.  And the process to assimilate 
ceph.conf settings into the mon config can do the remapping for you.  And 
once options are in the mon in the future we can rename them transparently 
(if we choose).  We could even raise health warnings if deprecated options 
are in use (in config files) that are about to be killed off.

So I think the question(s) are (1) is it worth investing the time to go 
through the options and rename them, and (2) assuming we did that, is 
there a more sane/intuitive way to mix the mgr module options with 
the traditional options?

sage
