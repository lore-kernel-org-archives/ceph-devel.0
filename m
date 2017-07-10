From: David Disseldorp <ddiss@suse.de>
Subject: Re: [systemd-devel] [PATCH] rules: block - add dm devices to
 whitelist
Date: Mon, 10 Jul 2017 11:37:03 +0200
Message-ID: <20170710113703.13ca760d@suse.de>
References: <20170705110145.20172-1-ddiss@suse.de>
        <20170710083838.GE5995@gardel-login>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752276AbdGJJhH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Jul 2017 05:37:07 -0400
In-Reply-To: <20170710083838.GE5995@gardel-login>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lennart Poettering <lennart@poettering.net>
Cc: systemd-devel@lists.freedesktop.org, ceph-devel@vger.kernel.org

Thanks for the feedback, Lennart...

On Mon, 10 Jul 2017 10:38:38 +0200, Lennart Poettering wrote:

> On Wed, 05.07.17 13:01, David Disseldorp (ddiss@suse.de) wrote:
> 
> > Ceph relies on by-partuuid symlinks, in order to locate the journal
> > partition from a given OSD partition. For details, see
> > http://tracker.ceph.com/issues/19489.  
> 
> This appears way too broad, as it would apply to all LVM and all other
> devices.
>
> It appears to me Ceph should do the same as LVM does for this, and
> ship its own set of rules, and be careful to only match against the
> actual devices it creates.

We can certainly do this in a Ceph specific manner via the existing
95-ceph-osd.rules, but my impression was that the by-partuuid symlinks
are "owned" by 60-persistent-storage.rules .

If you don't think the existence of these symlinks for dm paths will be
of use to others then I'll go ahead and propose it as a Ceph only
change.

Cheers, David
