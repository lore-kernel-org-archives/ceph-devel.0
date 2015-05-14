From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 14 May 2015 09:41:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505140935020.10788@cobra.newdream.net>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com>
 <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh> <553E07C7.8030905@suse.com> <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net> <55549206.3040008@suse.com>
 <alpine.DEB.2.00.1505140906400.10788@cobra.newdream.net> <CAANLjFpgivwxMhFLy4OcCxnJ_k5ssORCUm2r+BgtU+LEPQmvPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-152798833-1431621708=:10788"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933498AbbENQmG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 12:42:06 -0400
In-Reply-To: <CAANLjFpgivwxMhFLy4OcCxnJ_k5ssORCUm2r+BgtU+LEPQmvPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Tim Serong <tserong@suse.com>, Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cjwatson@debian.org, ceph-maintainers@ceph.com, Steven Timm <timm@fnal.gov>, Owen Synge <osynge@suse.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-152798833-1431621708=:10788
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 May 2015, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On Thu, May 14, 2015 at 10:08 AM, Sage Weil  wrote:
> > The above should have no impact on other distros where a fixed UID/GID
> > is already set in the package.
> 
> This sounds pretty reasonable to me!  Perhaps there can be a 'default'
> (but still opt-in) uid that is reserved and won't conflict going forward,
> but may conflict with legacy environments?  That at least minimizes
> complexity/pain for fresh environments (which I suspect will
> be the bulk of the install base)?
> 
> 
> Since there is no guarantee, can we just default to the same UID/GID that wa
> s received from Debian, or is there a known conflict in RH/Cent/SUSE/etc?

The Fedora UID is 167.
  - fedora: 0-200 = fixed allocations
  - debian: 100-999 = dynamically allocated
  - suse: 100-499 = dyamically allocated system users

The Debian UID is likely to be 64045.
  - fedora: undefined (1000-60000 = user accounts, nothing above that)
  - debian: 60000-64999 = reserved fixed uids, dynamically created
  - suse: undefined (1000-60000 = user accounts, nothing above that)

I'm not sure which is less likely: colliding with a dynamically allocated 
system user (how many of those are there?) or a regular user (64045 is a 
very large uid).

sage
--557981400-152798833-1431621708=:10788--
