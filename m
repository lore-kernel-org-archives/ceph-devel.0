From: Andrey Korolyov <andrey@xdel.ru>
Subject: Very intensive I/O under mon process
Date: Wed, 2 Jan 2013 18:40:43 +0300
Message-ID: <CABYiri_tx5+sSw3mZrVmtey6P6UcaRq_n4TxukzixUVm458u4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:53473 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab3ABPlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 10:41:06 -0500
Received: by mail-ob0-f169.google.com with SMTP id v19so13088811obq.14
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 07:41:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have just observed that ceph-mon process, at least bobtail one, has
an extremely high density of writes - times above _overall_ cluster
amount of writes, measured by qemu driver(and they are very close to
be fair). For example, test cluster of 32 osds have 7.5 MByte/s of
writes on each mon node having overall amount about 1.5 Mbyte/s and
dev- with only three osds has values is about 1Mbyte/s with
accumulated real write bandwidth of tens of kilobytes per second.

I`m afraid if this is normal, I may hit a limit of spinning storage
increasing test cluster, say, twenty times up of number of osd and
related ``idle'' write bandwidth.
