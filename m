From: Wido den Hollander <wido@42on.com>
Subject: Speeding up rbd_stat() in libvirt
Date: Mon, 28 Dec 2015 14:48:40 +0100
Message-ID: <56813DB8.2060008@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:39489 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbL1Nso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Dec 2015 08:48:44 -0500
Received: from [IPv6:2001:980:7936:0:d41f:2694:2ca4:e996] (unknown [IPv6:2001:980:7936:0:d41f:2694:2ca4:e996])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id E1D743FF0D
	for <ceph-devel@vger.kernel.org>; Mon, 28 Dec 2015 14:48:40 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

The storage pools of libvirt know a mechanism called 'refresh' which
will scan a storage pool to refresh the contents.

The current implementation does:
* List all images via rbd_list()
* Call rbd_stat() on each image

Source:
http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=cdbfdee98505492407669130712046783223c3cf;hb=master#l329

This works, but a RBD pool with 10k images takes a couple of minutes to
scan.

Now, Ceph is distributed, so this could be done in parallel, but before
I start on this I was wondering if somebody had a good idea to fix this?

I don't know if it is allowed in libvirt to spawn multiple threads and
have workers do this, but it was something which came to mind.

libvirt only wants to know the size of a image and this is now stored in
the rbd_directory object, so the rbd_stat() is required.

Suggestions or ideas? I would like to have this process to be as fast as
possible.

Wido
