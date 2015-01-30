From: Bassam Tabbara <bassamtabbara@hotmail.com>
Subject: Supporting partial writes for EC backend
Date: Fri, 30 Jan 2015 08:36:59 -0800
Message-ID: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s23.hotmail.com ([65.55.111.162]:56365 "EHLO
	BLU004-OMC4S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752058AbbA3QnV convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jan 2015 11:43:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I realize that the EC Backend does not support all operations like part=
ial writes, truncate, and others. I=E2=80=99d like to understand whethe=
r adding the missing operations is something that is architecturally po=
ssible, or if this is a limitation of the architecture / approach. Can =
someone shed some light on this?

I realize that partial writes are going to be slow/inefficient on an EC=
 backend compared to a replicated backend.

Thanks!
Bassam--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
