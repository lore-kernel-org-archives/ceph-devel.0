From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] libceph clean up con_work()
Date: Tue, 19 Feb 2013 18:51:33 -0600
Message-ID: <51241E15.80903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:54961 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094Ab3BTAvg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:51:36 -0500
Received: by mail-qe0-f52.google.com with SMTP id 6so3370077qeb.39
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:51:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This series cleans up con_work() a bit.  The original motivation
was to get rid of a warning issued by the sparse utility, but
addressing that required a little rework and it was fairly
straightforward once that was done to make that function
fairly simple.

The problem sparse reported was really due to sparse not
being able to follow the logic between multiple functions
that together implement locking.  The result of these
changes makes both acquiring and releasing the connection
mutex occur in con_work().

					-Alex

[PATCH 1/5] libceph: encapsulate connection backoff
[PATCH 2/5] libceph: separate non-locked fault handling
[PATCH 3/5] libceph: use a flag to indicate a fault has occurred
[PATCH 4/5] libceph: use a do..while loop in con_work()
[PATCH 5/5] libceph: indent properly
