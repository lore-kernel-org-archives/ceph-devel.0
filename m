From: Wido den Hollander <wido@42on.com>
Subject: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 15:46:46 +0100
Message-ID: <54B7D2D6.4020503@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:40124 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbbAOOqs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Jan 2015 09:46:48 -0500
Received: from [192.168.10.63] (unknown [31.161.47.74])
	by websrv.42on.com (Postfix) with ESMTPSA id ABEEBD2FB5
	for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 15:46:46 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Although the userland tools like 'ceph' and 'rados' have a safeguard
against fat fingers when it comes to removing a pool there is no such
safeguard when using native librados.

The danger still exists that by accident you remove a pool which is then
completely gone, no way to restore it.

This is still something I find quite dangerous, so I was thinking about
a additional 'Immutable bit' which could be set on a pool before
rados_pool_delete() allows this pool to be removed.

Is it a sane thing to look at 'features' which pools could have? Other
features which might be set on a pool:

- Read Only (all write operations return -EPERM)
- Delete Protected

It's just that looking at a 20TB RBD pool and thinking that just one API
call could remove this pool make me a bit scared.

Am I the only one or is this something worth looking in to?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
