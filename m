From: Dan van der Ster <dan@vanderster.com>
Subject: fs: mandatory client quota
Date: Fri, 5 May 2017 16:36:18 +0200
Message-ID: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34632 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdEEOhA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 10:37:00 -0400
Received: by mail-io0-f180.google.com with SMTP id k91so10746987ioi.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 07:37:00 -0700 (PDT)
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com. [209.85.223.177])
        by smtp.gmail.com with ESMTPSA id u191sm1057980ita.15.2017.05.05.07.36.59
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 07:36:59 -0700 (PDT)
Received: by mail-io0-f177.google.com with SMTP id k91so10746394ioi.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 07:36:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

It would be really nice if for Luminous client quotas were always
enabled -- it should be impossible to disable quota enforcement on the
client side.

From the looks of things, the patch to remove client_quota and
client_quota_df would be trivial.
Is there some reason we need to leave that optional?

Cheers, Dan
