From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: mon config storage (config-key vs config)
Date: Fri, 5 Jan 2018 15:30:11 -0800 (PST)
Message-ID: <alpine.LSU.2.21.1801051525330.27069@smaug>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35947 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbeAEX3l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 18:29:41 -0500
In-Reply-To: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Jan 2018, Sage Weil wrote:

> mgr/dashboard/server_port = 7000

I like this style. There could be an "all" or "shared" magic root for 
items that are shared everywhere, and (though I admit this feels a bit 
half-baked, I'm thowing it out there) maybe something like:

shared/osd,mon/max_threads = foo

> OSDMap creation only).  Is there a way we can realistically rename some of
> these options, perhaps as part of the ceph.conf -> mon config transition?

I feel like if there are going to be visible configuration changes, then 
it's a good time to break things. Maybe it's possible to make the "old" 
names work for the next release, but give a deprecation warning? A script 
that can do migration?

-Jesse
