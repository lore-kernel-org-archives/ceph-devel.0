From: Loic Dachary <loic@dachary.org>
Subject: 10.2.5 Jewel released
Date: Sat, 10 Dec 2016 10:16:57 +0100
Message-ID: <a12f6420-59fc-b6fa-4c83-ef76f9a951a7@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46517 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcLJJRF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Dec 2016 04:17:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This point release fixes an important regression introduced in v10.2.4.

We recommend that all v10.2.x users upgrade.

Notable Changes
---------------
* msg/simple/Pipe: avoid returning 0 on poll timeout (issue#18185, pr#12376, Sage Weil)

For more detailed information refer to the complete changelog[1] and the
release notes[2]

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.2.5.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy

[1]: http://docs.ceph.com/docs/master/_downloads/v10.2.5.txt
[2]: http://docs.ceph.com/docs/master/release-notes/#v10-2-5-jewel

