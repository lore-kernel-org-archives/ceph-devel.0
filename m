From: Ning Yao <zay11022@gmail.com>
Subject: Client Message Priority Optimazation
Date: Sat, 3 Dec 2016 17:21:20 +0800
Message-ID: <CALZt5jzdRA8obUCqGeSnS_ZEEY2C77=+i7kc1z_qXJ8MRVPZfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35247 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbcLCJVV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2016 04:21:21 -0500
Received: by mail-io0-f176.google.com with SMTP id a124so522177054ioe.2
        for <ceph-devel@vger.kernel.org>; Sat, 03 Dec 2016 01:21:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

Currently,  we can modify osd_client_op_priority to assign different
clients' ops with different priority such like we can assign high
priority for OLTP and assign low priority for OLAP. However, there are
some consideration as below:

1) it seems OLTP's client op still can be blocked by OLAP's sub_ops
since sub_ops use the CEPH_MSG_PRIO_DEFAULT.  So should we consider
sub_op should inherit the message's priority from client Ops (if
client ops do not give priority  explicitly, use CEPH_MSG_PRIO_DEFAULT
by default), does this make sense?

2) secondly, reply message is assigned with
priority(CEPH_MSG_PRIO_HIGH), but there is no restriction for client
Ops' priority (use can set 210), which will lead to blocked for reply
message. So should we think change those kind of message to highest
priority(CEPH_MSG_PRIO_HIGHEST). Currently, it seems no ops use
CEPH_MSG_PRIO_HIGHEST.

3) I think the kick recovery ops should inherit the client ops priority

4) Is that possible to add test cases to verify whether it works
properly as expected in ceph-qa-suite as Sam mentioned before? Any
guidelines?


Regards
Ning Yao
