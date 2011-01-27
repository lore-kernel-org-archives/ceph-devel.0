From: wchen <wchen@tnsoft.com.cn>
Subject: QEMU RBD failed!
Date: Thu, 27 Jan 2011 17:48:56 +0800
Message-ID: <1296121736.25746.90.camel@node1>
References: <FB06A065-2077-41B8-9C55-74C5234DDFAC@cs.ucsc.edu>
	 <AANLkTikq8reF0zk_47LW1Q6nM3pPfv+JG-Hk7P_fi4+K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:7429 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753522Ab1A0Jpo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jan 2011 04:45:44 -0500
In-Reply-To: <AANLkTikq8reF0zk_47LW1Q6nM3pPfv+JG-Hk7P_fi4+K@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Farnum,

I follow the instructions on wiki to create a qemu image using qemu rbd=
,
but failed.

According to wiki, after compiled qemu and input the following command:
$ qemu-img create -f rbd rbd:data/foo 10G

But system tell me that "unknown format 'rbd'".
which step did I miss? how to register a 'rbd' format?
BTW, I run these commands on ceph cluster.

Thanks a lot!

--=20
best regards,
Kevin Chen (=E9=99=88=E5=B7=8D)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
