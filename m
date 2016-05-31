From: Sage Weil <sage@newdream.net>
Subject: Re: Sizes of attributes and attributenames....
Date: Tue, 31 May 2016 08:55:46 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605310854550.6221@cpach.fuggernut.com>
References: <eeeec6f0-3aff-e1e1-8e85-5e7922fa2e15@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59155 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbcEaMzZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 08:55:25 -0400
In-Reply-To: <eeeec6f0-3aff-e1e1-8e85-5e7922fa2e15@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, ldachary@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 31 May 2016, Willem Jan Withagen wrote:
> 
> Hi,
> 
> I'm getting bitten in tests/ceph-disk.sh by.
> 
>  2 osd.0 0 boot
> -1 osd.0 0 backend (filestore) is unable to support max object
> name[space] len
> -1 osd.0 0    osd max object name len = 2048
> -1 osd.0 0    osd max object namespace len = 256
> -1 osd.0 0 (63) File name too long
>  1 journal close test-ceph-disk/dir/journal
> -1  ** ERROR: osd init failed: (63) File name too long	
> 
> And it seems that I did have this fixed in one run or another, but now
> it raises it scary head again.
> Now I think it is posible to fix this by starting vstart -short, but
> that does not cut it with other tests, so it seems.

I think we either need to do --short unconditionally for the make check 
vstart tests, or have an environment variable that does it conditionally.  
I'm inclined to do it unconditionally...  Loic, does that seem 
reasonable?  That way make check can work reliably on ext4.

sage
