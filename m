From: Wade Holler <wade.holler@gmail.com>
Subject: Dramatic performance drop at certain number of objects in pool
Date: Thu, 16 Jun 2016 08:14:57 -0400
Message-ID: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35828 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcFPMO7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 08:14:59 -0400
Received: by mail-oi0-f52.google.com with SMTP id w5so65584751oib.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 05:14:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I have a repeatable condition when the object count in a pool gets to
320-330 million the object write time dramatically and almost
instantly increases as much as 10X, exhibited by fs_apply_latency
going from 10ms to 100s of ms.

Can someone point me in a direction / have an explanation ?

I can add a new pool and it performs normally.

Config is generally
3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
with NVME for journals. Centos 7.2, XFS

Jewell is the release; inserting objects with librados via some Python
test code.

Best Regards
Wade
