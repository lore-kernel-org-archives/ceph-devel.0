From: Florian Haas <florian@hastexo.com>
Subject: Does radosgw really need to talk to an MDS?
Date: Mon, 2 Jul 2012 13:41:27 +0200
Message-ID: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37617 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2GBLl2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 07:41:28 -0400
Received: by qcro28 with SMTP id o28so2833934qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 04:41:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

radosgw(8) states that the following capabilities must be granted to
the user that radosgw uses to connect to RADOS.

ceph-authtool -n client.radosgw.gateway --cap mon 'allow r' --cap osd
'allow rwx' --cap mds 'allow' /etc/ceph/keyring.radosgw.gateway

Could someone explain why we need an "mds 'allow'" in here? I thought
only CephFS clients talked to MDSs, and at first glance configuring
client.radosgw.gateway without any MDS capability seems not to break
anything (at least with my limited S3 tests). Am I missing something?

Cheers,
Florian
