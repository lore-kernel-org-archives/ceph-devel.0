From: Shinobu Kinjo <skinjo@redhat.com>
Subject: [ceph-deploy] Ambiguous Debug Message
Date: Tue, 1 Sep 2015 19:48:29 -0400 (EDT)
Message-ID: <1765197817.11321874.1441151309841.JavaMail.zimbra@redhat.com>
References: <1772331860.11320004.1441150585905.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:42600 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbIAXsa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 19:48:30 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t81NmTeH007769
	for <ceph-devel@vger.kernel.org>; Tue, 1 Sep 2015 19:48:29 -0400
In-Reply-To: <1772331860.11320004.1441150585905.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

When I ran:

    $ sudo ./ceph-deploy --username ceph install ceph01

I ended up with:

    [ceph_deploy][ERROR ] RuntimeError: connecting to host: ceph@ceph01 resulted in errors: HostNotFound ceph@ceph01

That's fine. I need to do something.
But actual reason of failure was:

    Permission denied (publickey,gssapi-keyex,gssapi-with-mic).

I think we should change such an ambiguous [ERROR ] message
to more reasonable one so that nobody doesn't confuse any 
hostname configuration?

Thought?

-
$ ./ceph-deploy --version
1.5.27

Shinobu
