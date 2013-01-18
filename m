From: Travis Rhoden <trhoden@gmail.com>
Subject: max useful journal size
Date: Fri, 18 Jan 2013 17:20:24 -0500
Message-ID: <CACkq2mokPwwgue_OjsZngzGLLt5XODZiJdD5YwCDJ1um5TQ9eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:59334 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab3ARWUr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 17:20:47 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so1637847eaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 14:20:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks,

The Ceph docs give the following recommendation on sizing your journal:

osd journal size = {2 * (expected throughput * filestore min sync interval)}

The default value of min sync interval is .01.  If you use throughput
of a mediocre 7200RPM drive of 100MB/sec, this comes to 2 MB.  That
seems like the lower bound to have the journal do anything at all.

My question is what is the upper bound?  There's clearly a limit to
how big make, such that it just becomes wasted space.  The reason I
want to know is that since I will be journals on SSDs, with each
journal being a dedicated partition, there is a benefit to not making
the partition bigger than it needs to be.  All that unpartitioned
space can be used by the SSD firmware for wear-leveling and other
things (so long as it remains unpartitioned).

Would the following calc be appopriate?

Assume an SSD write speed of 400MB/sec.  Default max sync interval is 5.

2 * (400 MB/sec * 5sec) = 4 GB.

So is it appropriate to assume that if I can't write to an SSD faster
than 400 MB/sec, and I keep the default sync interval values, a
journal greater than 4GB is just a waste?

I had been using 10GB journals...  seems like overkill.

Or put another way, if I want to use 10GB journals, I should bump the
max sync interval to 12.5.

 - Travis
