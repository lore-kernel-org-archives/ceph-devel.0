From: Sage Weil <sage@newdream.net>
Subject: Re: Integration with Management Layers
Date: Tue, 4 May 2010 10:44:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005041037500.11433@cobra.newdream.net>
References: <k2p543a57a81005040638p134d8fct6e89ab1cbef6c0af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33428 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0EDRlP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 May 2010 13:41:15 -0400
In-Reply-To: <k2p543a57a81005040638p134d8fct6e89ab1cbef6c0af@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joel Merrick <joel.merrick@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Joel,

On Tue, 4 May 2010, Joel Merrick wrote:
> Firstly well done with the project, it looks very interesting and I'm
> looking forward to see how it develops.
> 
> Has any work been done with any of the abstraction layers for VM
> management. I'm on the OpenNebula and Ganeti lists and I know nothing
> has been done with these yet, but I'd like to help adapt/patch/test
> these (specifically Ganeti as we use it in production) where possible
> to support ceph storage.

I haven't use either of those projects, but having them manage the 
backed VM storage using ceph would be extremely handy!  Let us know how we 
can help.

Currently, most of the rbd (rados block device) image management is done 
through the 'rbdtool'.  There are some missing features still, but it 
works for creating, resizing, and deleting images.

The rbd driver itself is in the 'rbd' branch of ceph-client.git.  It is 
managed via /sys/class/rbd, although that interface is still in flux.  
Currently we're working on snapshot support.

There is also a compatible qemu/kvm storage driver.  That means a VM can 
use an rbd device in two or three ways: either via the storage driver,  
by mapping the block device on the host and passing it through to the 
guest, or by mapping it directly on the guest.

sage
