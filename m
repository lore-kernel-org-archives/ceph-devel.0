From: Sage Weil <sage@newdream.net>
Subject: Re: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 15:21:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42196 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbbBYXVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:21:19 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 25 Feb 2015, Somnath Roy wrote:
> Hi,
> We are facing problem that ceph-deploy purge is uninstalling latest Mellanox ofed driver packages.
> Digging down more we found libvirt-bin is dependent on librados2/librbd1.
> So, here is what happening.
> 
> 1. Mellanox ofed driver has a dependency on the libvirt-bin*
> 
> 2. purging librados2/librbd1 is removing libvirt-bin and resulting the removal of the Mellanox driver package as well.
> 
> Here is what I found.
> 
> http://packages.ubuntu.com/trusty/devel/libvirt-bin
> 
> ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2
> [...]

The problem is that libvirt (and probably qemu) are built against librbd1.  
If you remove librbd1, those get removed too.

> So, I am curious why libvirt-bin has a depencey on librados2/librbd1 ?

qemu needs it for obvious reasons.  libvirt needs it to manage it's 
(rbd) storage pools.

> Also, how come we get rid of this issue ?
> Ceph-deploy should not remove any package other than ceph's.

Purge could skip the libraries that may have other dependencies, but then 
it's a purge-lite.  Honestly I thought it skipped them for that reason but 
we probably changed it at some point because it (also confusingly) 
wouldn't remove librados etc...

sage

