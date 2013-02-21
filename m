From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 12:32:30 +0100
Message-ID: <CAJH6TXg_Kq=Mgk_PJVhG+sVZEp-kLsMAJw7d2bKM=YN1550F9Q@mail.gmail.com>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
	<CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com>
	<CAJH6TXizbuz-hoH-sxCe3H724BM2DDAuOuJduNwCiZAnK_txrw@mail.gmail.com>
	<5126028C.80008@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37414 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab3BULcc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 06:32:32 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so7356731wid.5
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 03:32:30 -0800 (PST)
In-Reply-To: <5126028C.80008@risc-software.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: ceph-devel@vger.kernel.org

2013/2/21 Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>:
> try sevice ceph -a restart osd.X (where X is the osd number) - maybe
> that helps. and check the kernel-logs, is the osd-directory mounted?

all dirs are mounted.
I have to manually restart many many time to get all osd up. Seems to be random.

If ceph status is not in HELTH_OK, radosgw doesn't start at all. Is this ok?
