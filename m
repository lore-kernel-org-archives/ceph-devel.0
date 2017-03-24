From: kefu chai <tchaikov@gmail.com>
Subject: gsoc proposal review
Date: Fri, 24 Mar 2017 15:22:14 +0800
Message-ID: <CAJE9aON8KMVwab6YZ2gVgG2aBprG3WzqjLiu+8mn=OY=R7Ui=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36851 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755580AbdCXHWV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 03:22:21 -0400
Received: by mail-vk0-f48.google.com with SMTP id s68so6400169vke.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Mar 2017 00:22:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: vedant15114@iiitd.ac.in, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi Vedant,

please use the public mailing list. that will allow other developers
to provide you help if i am not able to do so. also, it means that you
can start interacting with the rest (large) community instead of just
me (barely useful).

i just reviewed your proposal[1], couple comments:

- you need to reference your contribution to the ceph project in your
proposal. this is required.
- you can be more specific regarding to what metrics you could use to
identify a slow OSD. would be better if you can list some of them.

>  For example,if for all OSDs, the subdirectories split at the same time, it may lead to throttling in speeds.

this is the root cause, not the metrics.

some part of the M.O. overlap with
http://ceph.com/gsoc2017-ideas/#root-cause-analysis-tool.



---
[1] https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/


-- 
Regards
Kefu Chai
