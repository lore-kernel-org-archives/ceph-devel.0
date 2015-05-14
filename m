From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 14 May 2015 07:53:45 -0600
Message-ID: <5554A8E9.1050501@redhat.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh> <553E07C7.8030905@suse.com> <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net> <55549206.3040008@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbbENNyJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 09:54:09 -0400
In-Reply-To: <55549206.3040008@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>, Sage Weil <sweil@redhat.com>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, ceph-devel@vger.kernel.org, cjwatson@debian.org, ceph-maintainers@ceph.com, timm@fnal.gov, Owen Synge <osynge@suse.com>

On 05/14/2015 06:16 AM, Tim Serong wrote:
> The above should have no impact on other distros where a fixed UID/GID
> is already set in the package.
> 
> Does this sound viable?

This plan sounds fine to me.

- Ken

> [1] Or, possibly, it should force both UID and GID to the same number,
> meaning we only need one argument, say --ceph-uidgid?

Sure, sounds good.
