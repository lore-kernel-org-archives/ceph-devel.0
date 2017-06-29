From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-mgr setup magic
Date: Thu, 29 Jun 2017 17:40:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706291740240.3424@piezo.novalocal>
References: <alpine.DEB.2.11.1706281857110.8533@piezo.novalocal> <CALe9h7c2E3hS5dyvA8xf8pNpJDQ1g4p-X7T4EPasqNqNY8aLYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40600 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdF2RlC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 13:41:02 -0400
In-Reply-To: <CALe9h7c2E3hS5dyvA8xf8pNpJDQ1g4p-X7T4EPasqNqNY8aLYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Tim Serong <tserong@suse.com>

On Thu, 29 Jun 2017, John Spray wrote:
> On Wed, Jun 28, 2017 at 8:04 PM, Sage Weil <sage@newdream.net> wrote:
> > There is some goofy behavior with the systemd unit files that tries to
> > make a new ceph-mgr daemon automagically appear next to the mons during a
> > cluster upgrade:
> >
> > - The ceph-mon@.service triggers ceph-mgr@ to start
> > - The ceph-mgr@.service tries to create a ceph-mgr key using whatever
> > mon key it can find
> >
> > This was intended to ease the upgrade path by auto-creating ceph-mgr
> > daemons along the way.
> >
> > Do we really want this?  I was reminded this behavior is here because of
> > #19994, which points out that this isn't implemented for upstart (still
> > used by trusty 14.04).
> 
> I was thinking of it as a temporary thing for Kraken, because mgr
> didn't really do anything so it seemed unreasonable to make people
> jump through manual hoops at the time, and the tools support wasn't
> there.
> 
> For luminous I'm kind of ambivalent about whether to remove it in the
> name of cleanliness or leave it in in the name of convenience.

I lean toward cleanliness and transparency. Major upgrades are a rare 
opportunity have the admin's full attention; let's take advantage of it.

	https://github.com/ceph/ceph/pull/16023

sage
