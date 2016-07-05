From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: RBD volumes for bare-metal hosts
Date: Wed, 6 Jul 2016 00:16:04 +0200
Message-ID: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36444 "EHLO
	mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbcGEWQG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2016 18:16:06 -0400
Received: by mail-qt0-f177.google.com with SMTP id w59so108419151qtd.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2016 15:16:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>

Hello Guys,

I wonder about a method for providing bare-metal hosts with an access
to RBD volumes.

The most obvious solution is krbd. Unfortunately, it has a substantial
feature gap in comparison to librbd [1][2]. exclusive-lock seems to be
the basic dependency that should be satisfied to even start thinking
about the rest. Is someone working on this feature? What are the plans
in general?

I also saw that Jewel brought a new interesting concept: rbd-nbd.
It was mentioned in the pull request [2] that an internal testing
shows performance comparable with krbd. Could someone share
a bit more detail in that matter?

Best regards,
Radoslaw Zarzynski

[1] https://github.com/ceph/ceph-client/blob/for-linus/drivers/block/rbd.c#L121
[2] https://github.com/ceph/ceph/blob/master/src/include/rbd/features.h#L25
[3] https://github.com/ceph/ceph/pull/6657
