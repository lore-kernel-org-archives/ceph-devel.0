From: Leander Yu <leander.yu@gmail.com>
Subject: radosgw performance after 0.37
Date: Mon, 21 Nov 2011 01:49:03 +0800
Message-ID: <CAA9wQNc9qmbbshrL5hYYhiwpAbwF-5bzhM=h3dG9B_jY9HO3Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56529 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1KTRtE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Nov 2011 12:49:04 -0500
Received: by iage36 with SMTP id e36so6234292iag.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 Nov 2011 09:49:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I found that after 0.37 the radosgw have some fundamental changes
which put all object in to .rgw.buckets pool.
From the release note it seem for better scalability however I wonder
how this changes will improve the scalability? Base on our test, a
simple list bucket command by s3cmd will take more than 10 sec when
the file number is bigger than 10k. is this normal? or it's a
potential bug?

I haven't fully understand the radosgw code but it seems when you list
a bucket, it has to list all object in .rgw.buckets and filter out
those object not belong to the bucket id? if my understanding is
correct then it make sense to have 10 sec for listing a bucket from
s3cmd since "rados -p .rgw.bucket ls" took about 7 sec in my case.

So my question is: is this by design ? or did I miss some thing?

Regards,
Leander Yu.
