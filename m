From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: cephfs: status of directory fragmentation and multiple filesystems
Date: Wed, 29 Jun 2016 19:47:32 +0200
Message-ID: <CA+H5UW0Uu_+GYNq6EKw7GguiL-w3bEv3AKV72APLSbqgkLzS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35787 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcF2RsA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 13:48:00 -0400
Received: by mail-qk0-f180.google.com with SMTP id a125so101162895qkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 10:47:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

I saw the recent question about having more than 1 active
MDS in a cluster. I would like to ask similar ones but in
the matter of 1) directory fragmentation and 2) running
multiple filesystems within same cluster.

When those features are expected to be production-ready?
What do we need to achieve this status?

Best regards,
Radoslaw Zarzynski
