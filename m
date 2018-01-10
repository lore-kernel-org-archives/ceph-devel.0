From: Sage Weil <sweil@redhat.com>
Subject: CSI (container storage interface)
Date: Wed, 10 Jan 2018 18:45:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801101842180.17779@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbeAJSp5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 13:45:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD2BEC00DB97
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 18:45:57 +0000 (UTC)
Received: from ovpn-112-43.rdu2.redhat.com (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3559780D8
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 18:45:57 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Development has kicked off on a CSI driver for Ceph (RBD initially; CephFS 
will follow).  See

	https://github.com/ceph/ceph-csi
	https://github.com/ceph/ceph-csi/pulls

CSI is a generic provisioning (and attachment) interface for container 
orchestration platforms, including Kubernetes and Mesos.

	https://github.com/container-storage-interface/spec

In the kubernetes context, this will /eventually/ replace the in-tree RBD 
and CephFS volume drivers, as well as Rook's flex volume plugin.

sage
