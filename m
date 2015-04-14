From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Tue, 14 Apr 2015 10:12:36 -0600
Message-ID: <552D3C74.2000104@redhat.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39102 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbbDNQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Apr 2015 12:12:50 -0400
In-Reply-To: <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Tim Serong <tserong@suse.com>
Cc: cjwatson@debian.org, timm@fnal.gov, osynge@suse.com, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org

On 04/14/2015 09:21 AM, Sage Weil wrote:
> I think we still want them to be static across a distro; it's the 
> cross-distro change that will be relatively rare.  So a fixed ID from each 
> distro family ought to be okay?

Sounds sane to me. I've filed https://fedorahosted.org/fpc/ticket/524 to
request one from Fedora.

- Ken

