From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/8] libceph: miscellaneous cleanups
Date: Sat, 09 Mar 2013 09:11:18 -0600
Message-ID: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50319 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab3CIPLV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:11:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so3147560ieb.37
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:11:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series contains a bunch of small cleanups.  All of
them I've created while working on other things, and most
of them were done in order to allow upcoming work to be
easier, or easier to understand.  I've moved them all to
the front of my stack of patches and now I'm posting them
as a set for review.  They apply on top of the ceph-client
"testing" branch as of a couple of days ago:
    2f60d302  libceph: fix decoding of pgids

					-Alex

[PATCH 1/8] libceph: define CEPH_MSG_MAX_MIDDLE_LEN
[PATCH 2/8] libceph: minor byte order problems in
[PATCH 3/8] libceph: change type of ceph_tcp_sendpage() "more"
[PATCH 4/8] libceph: kill args in read_partial_message_bio()
[PATCH 5/8] libceph: define and use in_msg_pos_next()
[PATCH 6/8] libceph: advance pagelist with list_rotate_left()
[PATCH 7/8] libceph: simplify new message initialization
[PATCH 8/8] libceph: record byte count not page count
