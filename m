From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: [PATCH v3 0/2] Add ceph root filesystem
Date: Wed, 28 May 2014 16:46:09 -0700
Message-ID: <lm5sg3$tn3$1@ger.gmane.org>
References: <cover.1389806186.git.mark.doffman@codethink.co.uk> <cover.1401306206.git.mark.doffman@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60559 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaE1Xqb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 May 2014 19:46:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1WpnY9-0004ma-VB
	for ceph-devel@vger.kernel.org; Thu, 29 May 2014 01:46:25 +0200
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 01:46:25 +0200
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 01:46:25 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

mark.doffman@codethink.co.uk wrote:

> From: Mark Doffman <mark.doffman@codethink.co.uk>
> 
> Hi All,
> 
> The following is a third version of a patch series that adds the ability
> to use a ceph distributed file system as the root device.
<snip>

Would you mind expanding on why you want to do this in the kernel, instead 
of using an initramfs? For example, dracut supports the following syntax, 
and sets it up using the same tools as mounting NFS in a running system 
rather than the kernel's nfsroot support:

root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
root={dhcp|dhcp6}

root=dhcp alone directs initrd to look at the DHCP root-path where NFS 
options can be specified.

It also supports CIFS, as a further illustration:

root=cifs://[<username>[:<password>]@]<server-ip>:<root-dir>

Extending this to Ceph seems much simpler than implementing such a thing in 
the kernel, especially given dracut's modular nature, and it's easy enough 
to compile an initramfs into the kernel.

