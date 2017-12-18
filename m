From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: "No space left on device" when doing massive directory deletion.
Date: Mon, 18 Dec 2017 12:47:08 +0800
Message-ID: <CAJACTufKA2fyLY-Y6nTJmgRyWMJC+SUaXZ1iVLNGDdMxogoniQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:44714 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdLRErJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Dec 2017 23:47:09 -0500
Received: by mail-ot0-f182.google.com with SMTP id d27so12386680ote.11
        for <ceph-devel@vger.kernel.org>; Sun, 17 Dec 2017 20:47:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, everyone.

Recently, when we were doing a massive directory deletion test in
which totally 7 million directories are to be removed, we found that
the client occasionally receive "ENOSPC" errors while there were still
plenty of spare space in the underlying cephfs space. Having read some
related source codes, we found that the reason may be that the "STRAY"
directories are never fragmented, and when doing our test, the number
of stray directories in some of these "STRAY" dirs might reach the
limit "mds_bal_fragment_size_max". So we modified the level of output
in "Server::check_fragment_space" to 0 and did the test again. And
when clients received "ENOSPC", we found lots of logs as the
following:

2017-12-18 12:22:31.370524 7f6672fff700  0 mds.0.server fragment [dir
0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
exceeds 100000 (ENOSPC)
2017-12-18 12:22:31.370769 7f6672fff700  0 mds.0.server fragment [dir
0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
exceeds 100000 (ENOSPC)
2017-12-18 12:22:31.370836 7f6672fff700  0 mds.0.server fragment [dir
0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
exceeds 100000 (ENOSPC)
2017-12-18 12:22:31.370907 7f6672fff700  0 mds.0.server fragment [dir
0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
exceeds 100000 (ENOSPC)
2017-12-18 12:22:31.370968 7f6672fff700  0 mds.0.server fragment [dir
0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
exceeds 100000 (ENOSPC)


It seems that our guest is right. Is this by design?

Thanks:-)
