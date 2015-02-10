From: Stefan Priebe <s.priebe@profihost.ag>
Subject: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 19:55:26 +0100
Message-ID: <54DA541E.9000608@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:32097 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbbBJSz0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:55:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

last year in june i already reported this but there was no real result. 
(http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)

I then had the hope that this will be fixed itself when hammer is 
released. Now i tried hammer an the results are bad as before.

Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s 
than dumpling - this is also the reason why i still stick to dumpling.

I've now modified my test again to be a bit more clear.

Ceph cluster itself completely dumpling.

librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for random 
4k writes

- stopped qemu
- cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/
- cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/
- start qemu

same fio, same qemu, same vm, same host, same ceph dumpling storage, 
different librados / librbd: 16k iop/s for random 4k writes

What's wrong with librbd / librados2 since firefly?

Greets,
Stefan
