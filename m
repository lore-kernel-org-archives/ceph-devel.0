From: Dong Wu <archer.wudong@gmail.com>
Subject: how io works when backfill
Date: Sun, 27 Dec 2015 20:48:05 +0800
Message-ID: <CAAL-TMe06UBK9XBWd+WW8FqB+o5J1n+_GvDJ7FgQtSO51KbSyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33948 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbbL0MsG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Dec 2015 07:48:06 -0500
Received: by mail-pa0-f53.google.com with SMTP id uo6so74830588pac.1
        for <ceph-devel@vger.kernel.org>; Sun, 27 Dec 2015 04:48:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

Hi,
When add osd or remove osd, ceph will backfill to rebalance data.
eg:
- pg1.0    [1, 2, 3]
- add an osd(eg. osd.7)
- ceph start backfill, then pg1.0 osd set changes to [1, 2, 7]
- if [a, b, c, d, e] are objects needing to backfill to osd.7 and now
object a is backfilling
- when a write io hits object a, then the io needs to wait for its
complete, then goes on.
- but if io hits object b which has not been backfilled, io reaches
osd.1, then osd.1 send the io to osd.2  and osd.7, but osd.7 does not
have object b, so osd.7 needs to wait for object b to backfilled, then
write. Is it right? Or osd.1 only send the io to osd.2, not both?
