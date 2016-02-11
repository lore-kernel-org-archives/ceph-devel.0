From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: rgw and the next infernalis release v9.2.1
Date: Thu, 11 Feb 2016 11:47:10 +0530
Message-ID: <CAP3mxSw9bgcyfCeSRtQZQctEgLHfbvXJa-VMM9uhMGX9-Zgesg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32965 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbcBKGRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 01:17:12 -0500
Received: by mail-lf0-f47.google.com with SMTP id m1so25579345lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 22:17:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi Yehuda,

The next infernalis release as found at
https://github.com/ceph/ceph/tree/infernalis passed the rgw suite (
http://tracker.ceph.com/issues/13750#note-21 ). Do you think the
infernalis branch is ready for QE to start their own round of testing
?

The upgrade suite has a RGW failed test (
http://tracker.ceph.com/issues/14665 ), is it something that needs to
be fixed before the release ?

Thanks
Abhishek
