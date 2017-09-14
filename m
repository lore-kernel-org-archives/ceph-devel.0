From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: what I did to fix the damaged
Date: Thu, 14 Sep 2017 11:39:22 -0700
Message-ID: <CAKRxpuvEV9rNST=4fFeKPeGZzDaa684dvR40a3n0b1n+RMtfuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:49961 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdINSjX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 14:39:23 -0400
Received: by mail-it0-f50.google.com with SMTP id w204so950261itc.4
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 11:39:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> the unfound object is the tail object of mds log. what I did was finding the position of latest valid log entry and set log write_pos to it

Thanks for the help. The file system came back up after the scrub, I
mounted it, started copying files back on to it and within 1-2 hours
the file system went back degraded. Is this possibly due to the same
bug you found with mds not replay? Do I need to wait for a patch to
continue testing this?
