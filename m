From: Colin Watson <cjwatson@debian.org>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Fri, 15 May 2015 11:25:48 +0100
Message-ID: <20150515102548.GO10485@riva.ucam.org>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net>
 <5488919E.4090109@redhat.com>
 <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net>
 <5488FC46.5080106@suse.com>
 <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net>
 <552C9182.5030605@suse.com>
 <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
 <552D3C74.2000104@redhat.com>
 <87bnip2u10.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from b.painless.aa.net.uk ([81.187.30.52]:38781 "EHLO
	b.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbbEOL3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 07:29:24 -0400
Content-Disposition: inline
In-Reply-To: <87bnip2u10.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz@debian.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>, Tim Serong <tserong@suse.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com, timm@fnal.gov

On Wed, Apr 15, 2015 at 07:14:35PM +0200, Gaudenz Steinlin wrote:
> I have now requested the same for Debian. If the request is granted we
> will most likely get the uid/gid 64045.

Indeed so, and done.

> It seems that only Debian has a range of reserved ids for this purpose.
> I would expect Ubuntu to use the same id, but that's up to them finally.

(Switching hats:) Debian's base-passwd allocations are authoritative for
Ubuntu too.

Cheers,

-- 
Colin Watson                                       [cjwatson@debian.org]
