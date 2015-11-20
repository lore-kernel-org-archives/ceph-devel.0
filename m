From: Sage Weil <sage@newdream.net>
Subject: Re: OSD replacement feature
Date: Fri, 20 Nov 2015 03:38:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
References: <564E04F9.20607@dachary.org> <CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934555AbbKTLis (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 06:38:48 -0500
In-Reply-To: <CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 20 Nov 2015, Wei-Chung Cheng wrote:
> Hi Loic and cephers,
> 
> Sure, I have time to help (comment) on this feature replace a disk.
> This is a useful feature to handle disk failure :p
> 
> An simple step is described on http://tracker.ceph.com/issues/13732 :
> 1. set noout flag - if the broken osd is primary osd, could we handle well?
> 2. stop osd daemon and we need to wait the osd actually down. (or
> maybe use deactivate option with ceph-disk)
> 
> these two above step seems OK.
> about handle crush map, should we remove the broken osd out?
> If we do that, why we set noout flag? It still trigger re-balance
> after we remove osd from crushmap.

Right--I think you generally want to do either one or the other:

1) mark osd out, leave failed disk in place.  or, replace with new disk 
that re-uses the same osd id.

or,

2) remove osd from crush map.  replace with new disk (which gets new osd 
id).

I think re-using the osd id is awkward currently, so doing 1 and replacing 
the disk ends up moving data twice.

sage
