From: Victor Denisov <vdenisov@mirantis.com>
Subject: Waste of free space waste in Firefly.
Date: Tue, 3 Jan 2017 16:04:12 -0800
Message-ID: <CA+hcxJSrqUKUdANouvyr11ChJwcAkBeGTOMXox3nT4qw5e4O7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35079 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759833AbdADAEO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 19:04:14 -0500
Received: by mail-ua0-f173.google.com with SMTP id y9so6219180uae.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 16:04:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Guys,

As I understand, ceph can become fully saturated even with some osds
partially free(in terms of disk usage). When some osds become fully
saturated ceph becomes virtually unusuable.
So, it means I need to add more osds even if I still have some space
left. For me it means I'm wasting my disk space. Another option is to
rebalance the cluster, but this process is unpredictable.
Are there any data about the normal percentage of this free disk space
waste in Firefly.
Has the situation gotten better in later versions of ceph: Hammer, Jewel?

Thanks,
Victor.
