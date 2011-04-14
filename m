From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ext4 store and device-mapper
Date: Thu, 14 Apr 2011 12:00:27 -0700
Message-ID: <20110414190026.GF30604@dreamer>
References: <4DA73FEE.2060404@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40766 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232Ab1DNTA0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 15:00:26 -0400
Content-Disposition: inline
In-Reply-To: <4DA73FEE.2060404@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 14, 2011 at 08:41:50PM +0200, Zenon Panoussis wrote:
> 2011-04-14 20:22:24.887172 7fdc84de1720 OSD::mkfs: couldn't mount FileStore: error -95
> 2011-04-14 20:22:24.887226 7fdc84de1720  ** ERROR: error creating empty object store in /mnt/osd: error 95: Operation not supported
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.ShIRgaTSnR --init-daemon osd.0'

That usually means you're missing user_xattr from the mount
options. Can you confirm?

The error message was recently changed to be more helpful, just to
help people falling into this particular trap.

-- 
:(){ :|:&};:
