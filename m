From: Sage Weil <sage@inktank.com>
Subject: Re: btrfs for mon server?
Date: Sun, 4 Nov 2012 10:53:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211041052070.8980@cobra.newdream.net>
References: <5096B811.1030904@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44524 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2KDSxx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 13:53:53 -0500
In-Reply-To: <5096B811.1030904@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 4 Nov 2012, Stefan Priebe wrote:
> Hello,
> 
> does the mon service also suffer from btrfs as fs? Right now i've only the
> osd's running btrfs.

Do you mean 'benefit' instead of 'suffer'?

The mon doesn't do anything special with the file system, so there's no 
extra benefit beyond whatever btrfs normally gives you (like checksums).
I'd just run whatever fs you're most comfortable with.

sage
