From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Fwd: how io works when backfill
Date: Mon, 28 Dec 2015 16:09:40 +0800
Message-ID: <CA+cZ7sir4YJBJDtejh+2_r6Hq0AMOU1TEzvNzrfH=tbzUVvCuA@mail.gmail.com>
References: <CAAL-TMe06UBK9XBWd+WW8FqB+o5J1n+_GvDJ7FgQtSO51KbSyQ@mail.gmail.com>
	<CA+cZ7sg8NXXmkX-RULnE3uYN91ZV1d1xeVqZeXjmdTyAwq1h2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35516 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbbL1IJl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Dec 2015 03:09:41 -0500
Received: by mail-io0-f178.google.com with SMTP id q126so298940378iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Dec 2015 00:09:40 -0800 (PST)
In-Reply-To: <CA+cZ7sg8NXXmkX-RULnE3uYN91ZV1d1xeVqZeXjmdTyAwq1h2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Wu <archer.wudong@gmail.com>
Cc: ceph-devel@vger.kernel.org

2015-12-27 20:48 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
> Hi,
> When add osd or remove osd, ceph will backfill to rebalance data.
> eg:
> - pg1.0    [1, 2, 3]
> - add an osd(eg. osd.7)
> - ceph start backfill, then pg1.0 osd set changes to [1, 2, 7]
> - if [a, b, c, d, e] are objects needing to backfill to osd.7 and now
> object a is backfilling
> - when a write io hits object a, then the io needs to wait for its
> complete, then goes on.
> - but if io hits object b which has not been backfilled, io reaches
> osd.1, then osd.1 send the io to osd.2  and osd.7, but osd.7 does not
> have object b, so osd.7 needs to wait for object b to backfilled, then
> write. Is it right? Or osd.1 only send the io to osd.2, not both?

I think in this case, when the write of object b reaches osd.1, it
holds the client write, raises the priority of the recovery of object
b, and kick off the recovery of it. When the recovery of object b is
done, it requeue the client write, and then everything goes like
usual.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
