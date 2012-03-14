From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: q. about rbd-header
Date: Wed, 14 Mar 2012 16:05:00 +0100
Message-ID: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:43364 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2CNPFC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 11:05:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey,

anybody out there who could explain the structure of a rbd-header? After 
last crash we have about 10 images with a:
   2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading 
header: 2 No such file or directory
error opening image vm-266-disk-1.rbd: 2 No such file or directory
... error?
I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But 
the size/count encoding is not intuitive ;)

Besides one file, where I "created" a header and putted it via "rados 
put" back into the pool, and got some files
back, many of the other images with lost headers have different sizes.

We got bad luck again, too many crashed VM's, too much data-loss...

Comments welcome ;)

Oliver.
