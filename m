From: Lorieri <lorieri@gmail.com>
Subject: "strange issues recovering from inconsistent state"
Date: Sun, 16 Dec 2012 00:57:37 -0200
Message-ID: <CAPHxCcRX9EvJcwCFJVqL9d=LqDT603KGjqxb7PMDqPUoob6DHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55303 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2LPC5h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 21:57:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3284533pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 18:57:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Me and a friend of mine were doing some recovery tests (among others)
using radosgw.
We did exactly the same tests described in the link below, and we got
the same results.

http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/9412

After finding this thread I tried what Gregory said, and intentionally
changed the file in a non primary copy.
Trying to retrieve the file from radosgw triggered an automatically
recover of the file and radosgw did not crash.

Next test I did was a upgrade to 0.55 and increase the size of the
copies to 3, I was wondering if with 2 good copies it would do some
kind of election to recover the file.

When you know which file you crashed, it is easy to fix, otherwise it
is not simple to do.

My question is: what is the best way to avoid a problem like this to happen ?


bests,
-lorieri
