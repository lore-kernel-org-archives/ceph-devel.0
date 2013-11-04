From: Bill Hastings <bllhastings@gmail.com>
Subject: librados integrity tests.
Date: Sun, 3 Nov 2013 20:16:22 -0800
Message-ID: <CAJMJAuMQH_kd_B=3DKxZUa9Lun2Q5UE9DiY9+yMYGU73ZF1YtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53911 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3KDEQY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Nov 2013 23:16:24 -0500
Received: by mail-we0-f174.google.com with SMTP id u56so1576366wes.5
        for <ceph-devel@vger.kernel.org>; Sun, 03 Nov 2013 20:16:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All

We are planning to test Ceph for certain use cases. But how do folks
usually measure integrity of librados i.e what kind of tests are run
to measure integrity of the block device. Does RADOS also depend on
MDS?

Thanks
Bill
