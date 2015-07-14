From: Gregory Farnum <greg@gregs42.com>
Subject: Client: what is supposed to protect racing readdirs and unlinks?
Date: Tue, 14 Jul 2015 18:11:06 +0100
Message-ID: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37097 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbGNRLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 13:11:07 -0400
Received: by igbpg9 with SMTP id pg9so17172318igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 10:11:06 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id v82sm941480ioi.11.2015.07.14.10.11.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 10:11:06 -0700 (PDT)
Received: by iggf3 with SMTP id f3so17135773igg.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 10:11:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I spent a bunch of today looking at http://tracker.ceph.com/issues/12297.

Long story short: the workload is doing a readdir at the same time as
it's unlinking files. The readdir functions (in this case,
_readdir_cache_cb) drop the client_lock each time they invoke the
callback (for obvious reasons). There is some effort in
_readdir_cache_cb to try and keep the iterator valid (we check on each
loop that we aren't at end; we increment the iterator before dropping
the lock), but it's not sufficient.

Is there supposed to be something preventing this kind of race? If not
I can work something out in the code but I've not done much work in
that bit and there are enough pieces that I wonder if I'm missing some
other issue.
-Greg
