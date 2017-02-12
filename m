From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd performance drop a lot with objectmap
Date: Sun, 12 Feb 2017 12:59:43 -0500
Message-ID: <CA+aFP1DpPYm1t2+wzgEOzciYAmkemTkuzabsArZCZF6OXzhO2g@mail.gmail.com>
References: <B30C48EF-D72E-471C-808F-02E666347EAB@alibaba-inc.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36311 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbdBLR7p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Feb 2017 12:59:45 -0500
Received: by mail-wr0-f175.google.com with SMTP id k90so137000951wrc.3
        for <ceph-devel@vger.kernel.org>; Sun, 12 Feb 2017 09:59:44 -0800 (PST)
In-Reply-To: <B30C48EF-D72E-471C-808F-02E666347EAB@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 10, 2017 at 9:50 AM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
> With FIO single job queue depth 1(W/ vs W/O)  , IOPS drop 3 times and
> latency increased 3 times. As with more jobs, the IOPS drops more and
> latency increase higher and higher.

Assuming you have a random write workload, within a QD=1, it is
entirely expected for the first write to the object to incur a
performance penalty since it requires an additional round-trip
operation to the backing OSDs. Since you only hit this penalty for the
very first write to the object, its cost is amortized over future
writes. This is similar to cloned images and the amortized cost of
copying up the backing parent object to the clone on the first write.

> The objectmap_locker in pre and post and objectmap update per IO really hurt
> performance. Lockless queue and new way to caching objectmap? Any thoughts?

By definition, with a QD=1, there is zero contention on that lock. The
lock is really only held for a minuscule amount of time and is dropped
while the OSD operation is in-progress. Do you actually have any
performance metrics to back up this claim? Note that the post state is
only hit when you issue a remove / trim / discard operation.

-- 
Jason
