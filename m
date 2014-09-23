From: yue longguang <yuelongguang@gmail.com>
Subject: question about object replication theory
Date: Tue, 23 Sep 2014 17:37:37 +0800
Message-ID: <CAPaK2r9eWn=GaEsMabtepjCOtBpvjOyE3vnpcFsUpuC2YJ_XJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35470 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaIWJhi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Sep 2014 05:37:38 -0400
Received: by mail-ig0-f172.google.com with SMTP id a13so4248396igq.11
        for <ceph-devel@vger.kernel.org>; Tue, 23 Sep 2014 02:37:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,all
   take a look at the link ,
http://www.ceph.com/docs/master/architecture/#smart-daemons-enable-hyperscale
could you explain  point 2, 3 in that picture.

1.
at point 2,3, before primary writes data  to next osd, where is the
data?  it is in momory or on disk already?

2. where is the  code of point 2 or 3,  at there  primary distributes
data to others?

thanks
