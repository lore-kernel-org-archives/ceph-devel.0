From: Chengguang Xu <cgxu519@icloud.com>
Subject: Translating raw capacity to real data capacity in statfs
Date: Thu, 08 Feb 2018 10:47:47 +0800
Message-ID: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp002.me.com ([17.142.213.63]:40636 "EHLO
        pv33p36im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeBHCry (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 21:47:54 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp002.me.com by
 pv33p36im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3T00F00936BW00@pv33p36im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Thu, 08 Feb 2018 02:47:53 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

Hi Cepher,

Current statfs(2) in ceph kernel client provides raw capacity =
information of total/used/avail,
but in the point of view of filesystem I think we actually more willing =
to see real data capacity instead of raw.

So I have a suggestion to translate raw capacity to real data capacity, =
it can be simply implemented by
taking advantage of num.object_copies, the result may be not very =
accurate but still having reference significance.

What do you think and any suggestion?

Thanks,
Chengguang.


