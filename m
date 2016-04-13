From: Sage Weil <sage@newdream.net>
Subject: Re: MADV_MERGEABLE for osdmaps etc...
Date: Wed, 13 Apr 2016 08:42:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604130840200.29593@cpach.fuggernut.com>
References: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44974 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcDMMmh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:42:37 -0400
In-Reply-To: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 13 Apr 2016, Dan van der Ster wrote:
> Hi ceph-devel,
> 
> Did anyone ever consider using madvise MADV_MERGEABLE to enable kernel
> samepage merging for the ceph-osd? Typically this is used on kvm hosts
> to dedupe the VM memories, but naively I was thinking that since our
> osdmaps are duplicated (a few 100MB per daemon) we might profit as
> well. Though, perhaps these maps are changing often enough that KSM
> wouldn't help... no idea.
> 
> Any thoughts here?

My guess is not.  Maybe if we only kept the encoded maps in memory there'd 
be a better chance of dedup (but we don't).  And they do change reasonably 
quickly.. I've no idea what time interval KSM is expected to work over.

The high-level plan here is to move toward supporting a single process 
with multiple OSD instances.  That will allow for a shared OSDMap cache 
*and* let us consolidate/share TCP connections across hosts, which will 
have its own benefits.

sage
