From: John Spray <jspray@redhat.com>
Subject: Kraken cephfs test results
Date: Tue, 10 Jan 2017 14:04:09 +0000
Message-ID: <CALe9h7d5D=XQ_pRwZEEjY83TRY0ZzUkZX_DZ_D6mzp1L6xN_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36850 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbdAJOEa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 09:04:30 -0500
Received: by mail-oi0-f46.google.com with SMTP id u143so138764198oif.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2017 06:04:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sage,

Here are the notes on the failures on the latest cephfs tests on
kraken.  The tldr is that there's nothing blocking in here, but I'm
writing it out in full so that we can refer to this list to make sure
everything's backported to get the runs green.

Cheers,
John

samba:
* command failed with status 223 is PID file issue (pending backport)
http://tracker.ceph.com/issues/18309
* other samba failures are missing xenial packages.

fs:
* test_session_reject failure is an issue with the injection path the
test uses (PR open) https://github.com/ceph/ceph/pull/12757
* test_evict_client failure is the pidfile issue (pending backport)
http://tracker.ceph.com/issues/18309
* snaptest-snap-rm-cmp.sh failure is new issue (apparently
intermittent), PR open https://github.com/ceph/ceph/pull/12859

kcephfs:
* failures in TestClientRecovery, probably just issues with the newly
deployed kclient versions of the python tests (PR open)
http://tracker.ceph.com/issues/18396
