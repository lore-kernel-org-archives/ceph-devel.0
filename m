From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] libceph: refactor messenger for multiple data sources
Date: Sat, 09 Mar 2013 10:41:03 -0600
Message-ID: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:35621 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760352Ab3CIQlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:41:06 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so2408364iaf.14
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:41:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series factors out blocks of common code and generally
aims to simplify and make more consistent the way the ceph
messenger processes the data portions of both incoming and
outgoing messages.

They can be found in the "review/wip-msgr-refactor" branch of
the ceph-client git repository.  (That branch is based on
branch "review/wip-abstract-2").

					-Alex

[PATCH 1/6] libceph: use local variables for message positions
[PATCH 2/6] libceph: consolidate message prep code
[PATCH 3/6] libceph: small write_partial_msg_pages() refactor
[PATCH 4/6] libceph: encapsulate reading message data
[PATCH 5/6] libceph: define and use ceph_tcp_recvpage()
[PATCH 6/6] libceph: define and use ceph_crc32c_page()
