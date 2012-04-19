From: Sage Weil <sage@newdream.net>
Subject: Re: rbd snapshot in qemu and libvirt
Date: Thu, 19 Apr 2012 07:25:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204190722210.10110@cobra.newdream.net>
References: <4F8EBCB9.3030803@tuxadero.com> <4F8EBD4E.1050606@widodh.nl>
 <4F8EC028.40601@tuxadero.com> <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com>
 <4F8ED5CA.7040006@tuxadero.com> <CABYiri_GOHwpOZ2ZOUU4xTtHDmJFC01f07c2nQZ3yxT9j7m1Rg@mail.gmail.com>
 <4F900822.50707@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38572 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2DSOZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 10:25:20 -0400
In-Reply-To: <4F900822.50707@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 19 Apr 2012, Martin Mailand wrote:
> Hi List,
> 
> is it possible to quiesce the disk before a snapshot? Or does it make no sense
> with rbd?
> How about the new rbd_cache, does it get flushed before the snapshot?
> 
> I would like to use it like this.
> 
> virsh snapshot-create --quiesce $DOMAIN

librbd does flush before taking a snapshot.  I haven't seen --quiesce 
before, but it looks like it does exactly what I would want it to 
(freeze+thaw the fs inside the VM).

Let us know how it works for you!
sage

