From: Sage Weil <sweil@redhat.com>
Subject: Re: Fedora 22 systemd and rgw
Date: Tue, 4 Aug 2015 06:07:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508040604310.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <55BFBA99.4070205@suse.com> <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net> <55C0904A.8010902@suse.com> <55C0B0C7.7050907@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933605AbbHDNH5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 09:07:57 -0400
In-Reply-To: <55C0B0C7.7050907@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 4 Aug 2015, Owen Synge wrote:
> On 08/04/2015 12:13 PM, Owen Synge wrote:
> > On 08/03/2015 09:07 PM, Sage Weil wrote:
> >> On Mon, 3 Aug 2015, Owen Synge wrote:
> 
> > I will check the rgw.
> 
> It is not working due to missing:
> 
> /usr/lib/ceph-radosgw/ceph-radosgw-prestart.sh
> 
> which is a useful check tool, available in this commit:
> 
> https://github.com/SUSE/ceph/commit/92ef2ecfe0c0c0b0df4c9349310f930057202305

I removed this reference from the unit file, see

	https://github.com/ceph/ceph/commit/4d10dc134b817160bab6aecb9f5c08fb2d4f08e6

mainly because I didn't have a copy of the prestart script in my tree.  
Looking at it now, though, it's not clear to me that any of those steps 
are necessary.  They might be useful in making a legacy install/config 
continue functioning, but I don't think any of the complexity is needed 
for newly created rgw instances, and I'd prefer to make the upgrade 
process look like

 - upgrade ceph
 - killall radosgw
 - [optional] rename and sanitize ceph.conf section if there are special 
configs
 - ceph-deploy rgw create $hostname

than worry about trying to keep supporting the kludgey way we used 
to deploy rgw.

FWIW with the wip-systemd branch I was able to deploy new rgw instances 
on fc22 without any issues...

sage
