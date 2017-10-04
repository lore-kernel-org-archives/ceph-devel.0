From: Justinas LINGYS <jlingys@connect.ust.hk>
Subject: What is the progress of RDMA READ/WRITE?
Date: Wed, 4 Oct 2017 06:29:53 +0000
Message-ID: <HK2PR01MB1297B775CACF2508C3F734DD99730@HK2PR01MB1297.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0126.outbound.protection.outlook.com ([104.47.126.126]:6502
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbdJDG34 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 4 Oct 2017 02:29:56 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am wondering if there has been made any progress in the RDMA of Ceph
so that Ceph could use READ/WRITE verbs for some of operations (like data r=
eplication).

I would be interested in knowing since the official code does not contain n=
ew updates on
RDMA regarding RDMA READ/WRITE. Also, tracker.ceph seems not to have any sp=
ecific
information about it.




