From: =?UTF-8?B?5a6L5paw6aKW?= <songxinying.ftd@gmail.com>
Subject: rgw: who will write a key starting with a character greater than BI_PREFIX_CHAR
Date: Mon, 27 Nov 2017 22:30:25 +0800
Message-ID: <CAMWWNq9P2F5WTdkNOd1L_T9KbRgyYBm-3YvCBidXtesXy21yww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32799 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdK0Oa0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 09:30:26 -0500
Received: by mail-io0-f169.google.com with SMTP id i184so29068179ioa.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 06:30:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, yehuda@redhat.com

Hi, developers:
    Could anyone explain the commit
https://github.com/ceph/ceph/commit/7b5ec743f03a16bd9a901b754fcb64598e7d6b17
?
    "Previously we assumed that once we encounter the namespace tag
we're done. That was wrong." This really confuses me. I don't see
anyone who will write a key that greater than BI_PREFIX_CHAR in
current rgw codes. In my opinion, BI_PREFIX_CHAR is only used in
bucket versioning. For default buckets, the bucket index keys are
always normal ASCII strings, so no keys will greater than
BI_PREFIX_CHAR.

Thanks.
