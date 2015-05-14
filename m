From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 14 May 2015 09:08:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505140906400.10788@cobra.newdream.net>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com>
 <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh> <553E07C7.8030905@suse.com> <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net> <55549206.3040008@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965012AbbENQIf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 12:08:35 -0400
In-Reply-To: <55549206.3040008@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel@vger.kernel.org, cjwatson@debian.org, ceph-maintainers@ceph.com, timm@fnal.gov, Owen Synge <osynge@suse.com>

On Thu, 14 May 2015, Tim Serong wrote:
> On 04/28/2015 02:02 AM, Sage Weil wrote:
> >> much progress on the SUSE front.  I did suggest everyone just do what
> >> Debian does ;) but both Fedora and SUSE people pointed out that the 64K
> >> range isn't safe to claim, what with not being specifically reserved.
> >>
> >> I did make one small bit of progress - I've added the ceph user and
> >> group to rpmlint on openSUSE Factory
> >> (https://build.opensuse.org/request/show/303537) so at least the SUSE
> >> build won't bitch if files specified in any of the packages are owned by
> >> ceph:ceph.
> 
> It is my sad duty to report that I've been unable to get a static
> UID/GID allocated for SLES or openSUSE.

Too bad!  :(

> * There's nothing free in the reserved static range 0-99.
> * We can't take something from the unreserved ranges (500-999,
> 60001-64K) and hope for the best due to potential conflicts with old
> systems, LDAP users on those ranges, customers, etc. etc.

Just out of curiousity, what is 100-499?

> Consequently I would like to propose the following as a least-worst
> fallback/workaround:
> 
> 1) Add functionality to ceph-deploy to create the user and group during
> `ceph-deploy install`.  This would happen iff new (optional) --ceph-uid
> and --ceph-gid arguments[1] were passed to `ceph-deploy install`, and
> would happen before any ceph packages are installed.  This would allow
> individual sites to choose the UID/GID so they know it doesn't conflict
> with anything already in use.
> 
> 2) Add a guard to the %pre script in the RPM so it only invokes `useradd
> and `groupadd` if the ceph user and group don't already exist.
> 
> If the UID and GID aren't specified during `ceph-deploy install`, then
> it'll fall back to "next available" in the system range when
> useradd/groupadd are invoked in the rpm %pre script.
> 
> The above should have no impact on other distros where a fixed UID/GID
> is already set in the package.

This sounds pretty reasonable to me!  Perhaps there can be a 'default' 
(but still opt-in) uid that is reserved and won't conflict going forward, 
but may conflict with legacy environments?  That at least minimizes 
complexity/pain for fresh environments (which I suspect will 
be the bulk of the install base)?

> [1] Or, possibly, it should force both UID and GID to the same number,
> meaning we only need one argument, say --ceph-uidgid?

+1

sage
