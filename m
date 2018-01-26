From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: RGW bucket tagging
Date: Fri, 26 Jan 2018 15:47:24 +0100
Message-ID: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:39039 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeAZOrr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jan 2018 09:47:47 -0500
Received: by mail-lf0-f41.google.com with SMTP id w27so986089lfd.6
        for <ceph-devel@vger.kernel.org>; Fri, 26 Jan 2018 06:47:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I'm evaluating the possibility of using tags for buckets in RGW, using
boto3 s3.BucketTagging.put returns  client error and the rgw log
throws a 400 and says: provided input did not specify location
constraint correctly

I figured it's most likely that I did something silly in the code,
however before digging deeper I figured I should probably check if
it's even supported in RGW, I found this:
http://docs.ceph.com/docs/master/dev/radosgw/s3_compliance/

Which says Bucket Tagging "?", So I suspect Bucket Tagging isn't
supported? Any clarification or pointers appreciated here.

Thanks!
