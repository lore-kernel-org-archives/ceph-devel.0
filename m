From: Justinas LINGYS <jlingys@connect.ust.hk>
Subject: Why AsyncMessenger/AsyncConnection doesn't use
 support_zero_copy_read/zero_copy_read?
Date: Mon, 2 Oct 2017 08:19:18 +0000
Message-ID: <HK2PR01MB12974352BA7760B1C8361162997D0@HK2PR01MB1297.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0096.outbound.protection.outlook.com ([104.47.124.96]:8889
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750940AbdJBITU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 2 Oct 2017 04:19:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am wondering why AyncMessenger (src/msg/async/AsyncMessenger.h) does not
use the Stack's (src/msg/async/Stack.h) support_zero_copy_read method?  In =
addition, I would be interested in knowing why the RDMAStack (src/msg/async=
/rdma/RDMAStack.h) always returns false in its support_zero_copy_read metho=
d? Isn't RDMA supposed to be used for zero-copy communications?

Furthermore, I cannot understand why the AsyncConnection class does not use
the ConnectedSocket's zero_copy_read method for reading data since the DPDK=
Stack.h supports it. =
