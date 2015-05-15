From: Sage Weil <sage@newdream.net>
Subject: Re: Request for static uid/gid for ceph
Date: Fri, 15 May 2015 08:24:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505150824170.10788@cobra.newdream.net>
References: <87egnl2u87.fsf@meteor.durcheinandertal.bofh> <20150515102415.GN10485@riva.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57684 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934155AbbEOPYj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 11:24:39 -0400
In-Reply-To: <20150515102415.GN10485@riva.ucam.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Watson <cjwatson@debian.org>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, base-passwd@packages.debian.org, Tim Serong <tserong@suse.com>, ceph-devel@vger.kernel.org, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, timm@fnal.gov

On Fri, 15 May 2015, Colin Watson wrote:
> On Wed, Apr 15, 2015 at 07:10:16PM +0200, Gaudenz Steinlin wrote:
> > Ceph is currently developing unprivileged user support, and the upstream
> > developers are asking each of the distros to allocate a static numerical
> > UID for the "ceph" user and group.
> > 
> > The reason for the static number is to allow Ceph users to hot-swap hard
> > drives from one OSD server to another. Currently this practice works
> > because Ceph writes its files as "uid 0", but when Ceph starts writing
> > its files as an unprivileged user, it will be nice to allow
> > administrators to unplug a drive and plug it into another computer and
> > everything to just work.
> > 
> > For this I'm requesting an uid and gid from the reserved range
> > 60000-64999 according to the process outlined in
> > https://anonscm.debian.org/cgit/users/cjwatson/base-passwd.git/tree/README.
> 
> Sorry for the delay.  This seems entirely reasonable; I've allocated
> uid/gid 64045, which you'll now find in the git tree above.  I haven't
> uploaded base-passwd with this yet, but you can go ahead and make use of
> this immediately in Debian/Ubuntu without needing to wait for an upload.

Excellent!  Thanks, Colin!

sage

