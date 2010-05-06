From: Christian Brunner <chb@muc.de>
Subject: rados_aio_get_return_value returning 0 on writes
Date: Thu, 6 May 2010 23:08:01 +0200
Message-ID: <20100506210801.GA57874@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:55431 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0EFVIE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 17:08:04 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Almost forgot to write this: When calling rados_aio_get_return_value
on the callback of a write it is always returning 0.

I would have expected the number of bytes written (or a value <0 on error).

Qemu doesn't seem to care, so this isn't really a problem for me.

Christian
