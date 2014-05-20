From: Andrey Korolyov <andrey@xdel.ru>
Subject: Helper for state replication machine
Date: Tue, 20 May 2014 13:45:44 +0400
Message-ID: <537B2448.2090104@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:55798 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaETJqh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 May 2014 05:46:37 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so181370lab.16
        for <ceph-devel@vger.kernel.org>; Tue, 20 May 2014 02:46:35 -0700 (PDT)
Received: from [192.168.10.12] (h195-91-128-218.ln.rinet.ru. [195.91.128.218])
        by mx.google.com with ESMTPSA id k9sm22388760lam.11.2014.05.20.02.46.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 02:46:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I do not know about how many of you aware of this work of Michael Hines
[0], but looks like it can be extremely usable for critical applications
using qemu and, of course, Ceph at the block level. My thought was that
if qemu rbd driver can provide any kind of metadata interface to mark
each atomic write, it can be easily used to check and replay machine
states on the acceptor side independently. Since Ceph replication is
asynchronous, there is no acceptable approach to tell when it`s time to
replay certain memory state on acceptor side, even if we are pushing all
writes in synchronous manner. I`d be happy to hear any suggestions on
this, because the result probably will be widely adopted by enterprise
users whose needs includes state replication and who are bounded to
VMWare by now. Of course, I am assuming worst case above, when primary
replica shifts during disaster state and there are at least two sites
holding primary and non-primary replica sets, with 100% distinction of
primary role (>=0.80). Of course there are a lot of points to discuss,
like 'fallback' primary affinity and so on, but I`d like to ask first of
possibility to implement such mechanism at a driver level.

Thanks!

0. http://wiki.qemu.org/Features/MicroCheckpointing
