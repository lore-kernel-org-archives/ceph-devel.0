From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: inode64 mount option for XFS
Date: Mon, 03 Nov 2014 13:34:00 +0100
Message-ID: <54577638.7060900@profihost.ag>
References: <545774FA.2070102@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:34513 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaKCMeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 07:34:03 -0500
In-Reply-To: <545774FA.2070102@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>


Am 03.11.2014 um 13:28 schrieb Wido den Hollander:
> Hi,
> 
> While look at init-ceph and ceph-disk I noticed a discrepancy between them.
> 
> init-ceph mounts XFS filesystems with rw,noatime,inode64, but
> ceph-disk(-active) with rw,noatime
> 
> As inode64 gives the best performance, shouldn't ceph-disk do the same?
> 
> Any implications if we add inode64 on running deployments?

Isn't inode64 XFS default anyway?

Stefan

