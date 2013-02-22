From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5, v2] libceph clean up con_work()
Date: Fri, 22 Feb 2013 11:21:57 -0600
Message-ID: <5127A935.8020605@inktank.com>
References: <5127A85D.1070000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37571 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab3BVRWA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:22:00 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so998660iea.14
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:22:00 -0800 (PST)
In-Reply-To: <5127A85D.1070000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

(Re-posting because these changes have been rebased.)

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

