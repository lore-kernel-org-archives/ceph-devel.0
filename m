From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6]
Date: Fri, 05 Apr 2013 17:24:01 -0500
Message-ID: <515F4F01.2000704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:57486 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162867Ab3DEWYE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:24:04 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so3539473iae.25
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:24:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

(These patches, along with the two I just posted, are
available in the branch "review/wip-3761-2" of the
ceph-client git-repository.)

This series of patches implements messages having more
than one data item describing message data.  Recent
changes have implemented a list of data items in a
message, but it was in practice limited to use just
one item.  The first part of the series is rearranging
things so a message has a single cursor that moves among
the data items on the message's data list.

					-Alex

[PATCH 1/6] libceph: record bio length
[PATCH 2/6] libceph: move cursor into message
[PATCH 3/6] libceph: have cursor point to data
[PATCH 4/6] libceph: replace message data pointer with list
[PATCH 5/6] libceph: implement multiple data items in a message
[PATCH 6/6] libceph: add, don't set data for a message
