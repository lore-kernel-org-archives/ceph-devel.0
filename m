From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Out-of-tree build of ceph
Date: Thu, 14 Nov 2013 11:39:53 +0000
Message-ID: <5284B689.7090801@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ip.uk.com ([81.2.115.98]:46105 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752887Ab3KNLkA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Nov 2013 06:40:00 -0500
Received: from [10.0.1.108]
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1VgvBA-0005wM-VL
	for ceph-devel@vger.kernel.org; Thu, 14 Nov 2013 11:33:45 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is a very minor point, but this list is very responsive and
helpful, and I am trying to be helpful myself.

I find that an out-of-tree build of ceph fails because 'ceph_ver.c'
can't be found in the build tree.

I simply 'cp ceph-0.72/src/ceph_ver.c build/src' to work around the
problem for my purposes.

This issue has not always been present, but has been for quite a few
versions now.

Regards,
David
