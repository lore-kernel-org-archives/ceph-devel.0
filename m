From: Sage Weil <sage@newdream.net>
Subject: Re: rbd import rbd_writeback_window
Date: Tue, 11 Oct 2011 13:33:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110111333010.20977@cobra.newdream.net>
References: <4E94A4FC.4020609@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35378 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab1JKUdd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 16:33:33 -0400
In-Reply-To: <4E94A4FC.4020609@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 11 Oct 2011, Martin Mailand wrote:
> Hello,
> is it possible to use the rbd_writeback_window with the rbd command to speed
> up the import?
> Something like rbd import /mnt/image_vm1 vm99:rbd_writeback_window=800000

Yep,

 rbd import /mnt/image_vm1 vm99 --rbd-writeback-window=8000000

sage
