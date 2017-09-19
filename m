From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: OSD crashes (10.2.9)
Date: Tue, 19 Sep 2017 11:28:08 -0400
Message-ID: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:44084 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdISP2L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 11:28:11 -0400
Received: by mail-lf0-f53.google.com with SMTP id l196so392056lfl.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 08:28:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Im seeing this stack trace in a lot of my OSDs (21 out of 92).  I
suspect its a corrupt leveldb or journal, but not sure how to debug it
further.  Any suggestions on how to debug further?

 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (()+0x984c4e) [0x56032b65ec4e]
 2: (()+0x11390) [0x7f89adce8390]
 3: (gsignal()+0x38) [0x7f89abc86428]
 4: (abort()+0x16a) [0x7f89abc8802a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x26b) [0x56032b75f0db]
 6: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char
const*, long)+0x259) [0x56032b69b2d9]
 7: (ceph::HeartbeatMap::is_healthy()+0xe6) [0x56032b69bc06]
 8: (ceph::HeartbeatMap::check_touch_file()+0x2c) [0x56032b69c45c]
 9: (CephContextServiceThread::entry()+0x167) [0x56032b777777]
 10: (()+0x76ba) [0x7f89adcde6ba]
 11: (clone()+0x6d) [0x7f89abd5782d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
