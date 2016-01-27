From: Sage Weil <sage@newdream.net>
Subject: Re: /var/lib/ceph/*/*/config
Date: Wed, 27 Jan 2016 10:45:19 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601271042590.6524@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com> <CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com> <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com> <alpine.DEB.2.11.1601270956260.6524@cpach.fuggernut.com>
 <56A8E142.4040401@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51089 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbcA0PpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 10:45:08 -0500
In-Reply-To: <56A8E142.4040401@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 27 Jan 2016, Wido den Hollander wrote:
> On 27-01-16 15:59, Sage Weil wrote:
> > Loic pointed out that adding a new config file that is overrides/combines 
> > with the global config makes our already-complicated config infrastructure 
> > even more so.  And it turned out to be more complicated to implement than 
> > I'd hoped.  On the other hand, I think there are valid use-cases for a 
> > global config, e.g.:
> > 
> >  - most config on the osd disk itself
> >  - /etc/ceph/ceph.conf containing crush_location and mon_host
> > 
> > ...and with a single config I'm not sure how we'd get the datacenter 
> > location set properly.
> > 
> 
> Yes, you probably want the mon_host variable in a global config. We
> might and I say *might* want to look at a DNS lookup at some time?
> 
> A lookup for 'ceph-monitor' in the current DNS search domain. But that
> might be offtopic here.

Yeah, I think if we make standard practice setting up DNS with an A or 
AAAA record for each monitor then we can avoid a global mon_host.  But 
there's still the crush location piece...
 
> > Anyway, I have two versions implemented.  The first just adds 
> > $data_dir/config to the search pathh:
> > 
> > 	https://github.com/ceph/ceph/pull/7377
> > 
> 
> I like the first patch, but it doesn't seem to merge the config files,
> right?
> 
> If a global /etc/ceph/ceph.conf is found it doesn't search any further.
> 
> > The second adds the extra_config infrastructure.  It's just the last patch 
> > that is different:
> > 
> > 	https://github.com/ceph/ceph/pull/7378
> > 
> 
> The --extra-config seems weird to me. Isn't there a way where you supply
> --config multiple times with multiple files?

Right now config is a search path, and when it finds a match, it stops and 
uses that config file exclusively.  extra_config is a way to merge two of 
them.  I agree it's not ideal...

An alternative approach would be to support 'include <file>' so that the 
$data_dir/config, if present, would include something from /etc/ceph.

sage
