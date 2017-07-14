From: Nathan Cutler <ncutler@suse.cz>
Subject: v10.2.9 Jewel released
Date: Fri, 14 Jul 2017 22:47:27 +0200
Message-ID: <a29d622a-57b1-beac-cea4-345d6394ce57@suse.cz>
References: <333d2b6c-f2d7-69a2-a879-4f321006e765@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35435 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbdGNUr2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Jul 2017 16:47:28 -0400
In-Reply-To: <333d2b6c-f2d7-69a2-a879-4f321006e765@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com
Cc: Abhishek Lekshmanan <abhishek@suse.com>

v10.2.9 Jewel released
======================

This point release fixes a regression introduced in v10.2.8.

We recommend that all Jewel users upgrade.

For more detailed information, see the complete changelog[1]
and release notes[2].

Notable Changes
---------------

* cephfs: Damaged MDS with 10.2.8 (pr#16282, Nathan Cutler)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.2.9.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see 
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release SHA1: 2ee413f77150c0f375ff6f10edd6c8f9c7d060d0

[1]: http://docs.ceph.com/docs/master/_downloads/v10.2.9.txt
[2]: http://ceph.com/releases/v10-2-9-jewel-released/
