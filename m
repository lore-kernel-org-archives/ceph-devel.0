From: Sylar Shen <kimulaaa@gmail.com>
Subject: Radosgw cannot output Chinese file names
Date: Wed, 13 Jul 2011 15:48:24 +0800
Message-ID: <CAPE_nyKQz0AR8H6HFe-BiGGoG=+uJpzRT_LfFNhn4OMr5ARH6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36609 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1GMHsZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 03:48:25 -0400
Received: by bwd5 with SMTP id 5so4629433bwd.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 00:48:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,
I installed ceph and radosgw v0.3 and got 1 server with  MON and
radosgw , 2 OSDs server. (without MDS)
The environment started successfully and I wanted to test
upload/download file via radosgw.
It all went well if I uploaded/downloaded English file names.
But It went wrong when I tried Chinese file names.
Radowgw can receive files normally, but Chinese file names were turned
into unrecognized codes.
Therefore, radosgw cannot show the file list in a bucket normally.
It turned out to show nothing when I wanted to list files in a bucket.
But the Chinese file did exist in the bucket.

I am curious that if I did something wrong to result in such kind of problems
Does anyone who has the same problem as I did?
Thanks~~~^^

--
Best Regards,
Sylar Shen
