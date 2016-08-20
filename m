From: Victor Araujo <ve.ar91@gmail.com>
Subject: [GSoC 2016] End-to-end performance visualization in Ceph
Date: Sat, 20 Aug 2016 12:43:21 +0200
Message-ID: <CA+skQMtc1ij54t-X+AuCZd14JXkKqZBbs4YWNSbL-_KU+Rw-tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33235 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbcHTKnY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Aug 2016 06:43:24 -0400
Received: by mail-wm0-f52.google.com with SMTP id d196so12843777wmd.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Aug 2016 03:43:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone,

Google Summer of Code is coming to a close.

I'd like to share with you some details about the End-to-end
performance visualization in Ceph project:
http://vears91.github.io/babeltrace-zipkin/

It will allow the visualization of events in a timeline for specific
requests, recording timestamps and key-value pairs to give context
about the execution of Ceph components. A picture is worth a thousand
words, so in the page I linked you can find a screenshot of what
Twitter Zipkin shows for the execution of a request generated from fio
rbd engine as it goes through rados. The pull request is currently
being reviewed.


Best regards,


Victor Araujo
