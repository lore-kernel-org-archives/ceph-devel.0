From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: radosgw question
Date: Tue, 20 Sep 2011 16:36:33 +0800
Message-ID: <CANExM-Mfy4braUiwMp1GC29d4fAeH933X_oLhJ2hd+AigukbFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41775 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab1ITIge (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 04:36:34 -0400
Received: by iaqq3 with SMTP id q3so378299iaq.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2011 01:36:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have a question about the radosgw.

The radosgw uses an object to record the buckets owned by one user
account. However, suppose that the user account is shared by multiple
users, and these users connect to the radosgw concurrently. If, say,
user A creates bucket B1 and user B deletes bucket B2 at the same
time, they will both update the object. Since it seems radosgw has no
lock mechanism for object update, the problems would occurs - either
the created bucket will be lost or the deleted bucket can still be
listed but dne actually.

I know it may be a rare case, just wondering if there is away to
handle this situation.

Thanks,
Henry
