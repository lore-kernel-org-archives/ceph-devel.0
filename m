From: Shinobu Kinjo <skinjo@redhat.com>
Subject: ./run-make-check.sh
Date: Thu, 19 Nov 2015 18:39:54 -0500 (EST)
Message-ID: <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com>
References: <955833108.16153353.1447976340808.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33976 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934629AbbKSXjz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 18:39:55 -0500
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tAJNdsRf029793
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 18:39:54 -0500
In-Reply-To: <955833108.16153353.1447976340808.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I saw this message during executing run-make-check.sh on fc23:

2015-11-20 01:05:37.529021 7f8742e3d7c0 -1  ** ERROR: error creating empty object store in testdir/osd-reactivate/0: (13) Permission denied

Can we ignore at the moment?

If I've missed anything, let me know.

Thanks!!
Shinobu
