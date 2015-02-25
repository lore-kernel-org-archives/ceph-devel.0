From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 23:36:05 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAD3A@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0076.outbound.protection.outlook.com ([157.56.111.76]:2031
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753063AbbBYXgJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:36:09 -0500
In-Reply-To: <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks Sage !
But, I think this is a serious issue, every time we will purge the cluster all the node network will be down :-(
Basically, it should not delete any component on which non-ceph components are dependent.
We need this purge-lite kind of stuff.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Wednesday, February 25, 2015 3:21 PM
To: Somnath Roy
Cc: Ceph Development
Subject: Re: librados2 and librbd1 dependency on libvirt-bin

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
> ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2 [...]

The problem is that libvirt (and probably qemu) are built against librbd1.
If you remove librbd1, those get removed too.

> So, I am curious why libvirt-bin has a depencey on librados2/librbd1 ?

qemu needs it for obvious reasons.  libvirt needs it to manage it's
(rbd) storage pools.

> Also, how come we get rid of this issue ?
> Ceph-deploy should not remove any package other than ceph's.

Purge could skip the libraries that may have other dependencies, but then it's a purge-lite.  Honestly I thought it skipped them for that reason but we probably changed it at some point because it (also confusingly) wouldn't remove librados etc...

sage


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

