From: kefu chai <tchaikov@gmail.com>
Subject: about "osd: stateful health warnings: mgr->mon"
Date: Wed, 25 Oct 2017 17:29:08 +0800
Message-ID: <CAJE9aOPYDJs1rXUqUMFZx_QKTk2s-fST6pKijvk+19zNis6Vow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:49357 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbdJYJ3J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 05:29:09 -0400
Received: by mail-oi0-f45.google.com with SMTP id w197so41897465oif.6
        for <ceph-devel@vger.kernel.org>; Wed, 25 Oct 2017 02:29:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi John and Sage,

as you know, i am working on [1]. but slow-requests alert are pretty
much a list of strings, in which the first one is a summary, and the
following ones are the details: like

- 1 slow requests, 1 included below; oldest blocked for > 30.005692 secs
- slow request 30.005692 seconds old, received at {date-time}:
osd_op(client.4240.0:8 benchmark_data_ceph-1_39426_object7 [write
0~4194304] 0.69848840) v4 currently waiting for subops from [610]

this fits well into a health_check_t struct. and we can add a field in
MMgrReport, and send it to mgr periodically. but at the mgr side, it
is supposed to compose a single std::map<string, health_check_t> in
MMonMgrReport, and send it to monitor.

if we put all slow requests from all osds into this map with the key
like "OSD_SLOW_OPS/${osd_id}". the monstore will be loaded by a slow
cluster, and the "health" section of "ceph status" will be flooded
with the slow requests. or we can just collect all the slow request
details into a single bucket of "OSD_SLOW_OPS".

but if we just send the summaries from OSDs as the
"health_check_t::detail" with the alert code of "OSD_SLOW_OPS". all
the details are practically stripped off. and the total *number* of
slow requests can be found nowhere unless the user parses the summary
lines, and sum it up manually.

we could refactor the OpTracker::check_ops_in_flight() so it returns
an array of info describing slow requests instead of a list of
human-readable strings. but we still need to face this problem of
level-of-details.

any thoughts?


---
https://trello.com/c/8f9y0YM6/51-osd-stateful-health-warnings-to-mgr-mon-eg-slow-requests


-- 
Regards
Kefu Chai
