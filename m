From: Sage Weil <sage@inktank.com>
Subject: Re: Disabling journal
Date: Sun, 11 Nov 2012 07:24:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net>
References: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57773 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2KKPYr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Nov 2012 10:24:47 -0500
In-Reply-To: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Sun, 11 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Hi list,
> 
> is there a way to disable journal completely? For fast ssd storage it 
> doesn't make sense and I want to test how speed changes.

With btrfs, yes, although this isn't something we have tested in a while.  
You'd need to play with 'filestore min sync interval' and 'filestore max 
sync interval' to basically pick your latency range.

sage
