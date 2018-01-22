From: Rubab Syed <rubab.syed21@gmail.com>
Subject: Adding units to performance counters and configuration setting browser
Date: Tue, 23 Jan 2018 03:12:14 +0500
Message-ID: <CAPP7jAU-H5663h9svv3H1LjSLymi+W3aPzqd=Ysa3ukjgDO9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:42920 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeAVWMR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jan 2018 17:12:17 -0500
Received: by mail-lf0-f45.google.com with SMTP id q17so12546419lfa.9
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jan 2018 14:12:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: John Spray <jspray@redhat.com>

Hi everyone,

Currently, performance counters in Ceph don't indicate whether they
are just generic counts (e.g. number of requests), or something with a
unit (e.g. number of bytes).

I am working on a feature to add the support for units in our code
base so that sense and visualization of quantities can be improved
(from command line as well as from dashboard). For performance
counters browser [1], we are adding bytes/non-bytes units and for
configuration setting browser [2], bytes/non-bytes as well as time.

If you guys would like to have some additional units that might be
helpful, feel free to reply to this thread. All suggestions are
welcome.

Regards,
Rubab


[1] https://github.com/ceph/ceph/pull/19922
[2] https://github.com/ceph/ceph/pull/20043
