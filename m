From: Samuel Just <sjust@redhat.com>
Subject: async messenger peering hang
Date: Wed, 23 Sep 2015 13:29:00 -0700
Message-ID: <CAN=+7FW6k6C8qdpOOrBWRRX4JoGULi4vG34L8FffJAuD77BdnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36307 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbIWU3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 16:29:00 -0400
Received: by ioii196 with SMTP id i196so55671306ioi.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 13:29:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm seeing some rados runs stuck on peering messages not getting sent
by the async messenger: http://tracker.ceph.com/issues/13213.  Can you
take a look?
-Sam
