From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: rados and next infernalis release v9.2.1
Date: Thu, 11 Feb 2016 11:50:38 +0530
Message-ID: <CAP3mxSzmcJbep_Z-yn1tzV+2UcNdOWZC-_MfvUbzAjs1J3kf0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33881 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbcBKGUj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 01:20:39 -0500
Received: by mail-lb0-f177.google.com with SMTP id cw1so22399540lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 22:20:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi Sam,

The next infernalis release as found at
https://github.com/ceph/ceph/tree/infernalis passed the rados suite (
http://tracker.ceph.com/issues/13750#note-14 ) and the upgrade suite (
http://tracker.ceph.com/issues/13750#note-15 ). Do you think the
infernalis branch is ready for QE to start their own round of testing
?

Note that there is one failed test, but it is related to RGW (
http://tracker.ceph.com/issues/14665 ).

Thanks
Abhishek
