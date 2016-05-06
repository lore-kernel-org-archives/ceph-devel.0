From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Adding new nodes to ceph cluster
Date: Fri, 6 May 2016 14:06:31 +0530
Message-ID: <CANA9Uk4Nw8P0f3j3Sz7N8Eoh5Rqm+6tRspSHQMHvs=Hq5jTHcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33600 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbcEFIgc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 04:36:32 -0400
Received: by mail-yw0-f178.google.com with SMTP id t10so191977695ywa.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 01:36:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi,
I wanted to add 2 new nodes (21 OSDs per node) to the current ceph
cluster (v 0.80.7).

What is best way doing the same without impacting the customers with
no downtime (and not network impact due to rebalcing activity)?

Thanks
Swami
