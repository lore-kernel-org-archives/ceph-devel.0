From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: [Hammer Backports] Should rest-bench be removed on hammer ?
Date: Mon, 28 Sep 2015 15:49:33 +0530
Message-ID: <CAP3mxSymbxxh8k3==03EsR51jmAO6jyY_RZrUsKOyo=aN5tibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33018 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbbI1KTe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 06:19:34 -0400
Received: by iofh134 with SMTP id h134so169454243iof.0
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 03:19:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Hi,

The rest-bench tool has been removed in master through PR #5428
(https://github.com/ceph/ceph/pull/5428). The backport PR #5812
(https://github.com/ceph/ceph/pull/5812) is currently causing failures
on the hammer-backports integration branch. These failures can be
resolved by either backporting PR #5428 or by adding a hammer-specific
commit to PR #5812.

How should we proceed here?

Thanks
Abhishek
