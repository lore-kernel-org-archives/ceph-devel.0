From: Alex Elder <elder@inktank.com>
Subject: Sparse Warning Message Patches
Date: Tue, 19 Feb 2013 18:44:44 -0600
Message-ID: <51241C7C.80901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34425 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3BTAos (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:44:48 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so9190108ieb.17
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:44:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

What follows is a few series of patches that get rid of code
issues that lead to warnings from the sparse utility.

The first three patches address the warnings in the rbd, ceph
file system, and libceph code respectively.  After that, one
warning remains in libceph, and that is addressed by a series
of five patches which both address the underlying problem and
reorganized and clean up the surrounding code.  The last two
are meant to be combined into one before commit; they've been
posted as two separate patches to make them easier to review.

					-Alex

[PATCH] rbd: eliminate sparse warnings

[PATCH] ceph: eliminate sparse warnings in fs code

[PATCH] libceph: eliminate sparse warnings

[PATCH 1/5] libceph: encapsulate connection backoff
[PATCH 2/5] libceph: separate non-locked fault handling
[PATCH 3/5] libceph: use a flag to indicate a fault has occurred
[PATCH 4/5] libceph: use a do..while loop in con_work()
[PATCH 5/5] libceph: indent properly
