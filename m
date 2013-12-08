From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: many meta files in osd
Date: Sun, 8 Dec 2013 20:00:09 +0100
Message-ID: <CAMNMNTw3OM-aoUAOAEJcN5BqsrL+4S79Ha20=xt5wE_56Jd5_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47556 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab3LHTAL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Dec 2013 14:00:11 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so2799283obc.8
        for <ceph-devel@vger.kernel.org>; Sun, 08 Dec 2013 11:00:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
My api app to put files to s3/ceph checks if bucket exists by create
this bucket.
Each bucket create command adds 2 meta files.

-----
root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
44
root@vm-1:/vol0/ceph/osd# s3 -u create test1
Bucket successfully created.
root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
46
-----

Unfortunately:
-----
root@vm-1:/vol0/ceph/osd# s3 -u delete test1
root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
46
-----

Is there some way to remove this meta files from ceph?

-- 
Regards
Dominik
