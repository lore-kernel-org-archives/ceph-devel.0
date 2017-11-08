From: Sage Weil <sweil@redhat.com>
Subject: who is using nfs-ganesha and cephfs?
Date: Wed, 8 Nov 2017 21:41:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbdKHVlm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 16:41:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Who is running nfs-ganesha's FSAL to export CephFS?  What has your 
experience been?

(We are working on building proper testing and support for this into 
Mimic, but the ganesha FSAL has been around for years.)

Thanks!
sage

