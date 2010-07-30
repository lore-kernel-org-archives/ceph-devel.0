From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: /sys/class/rbd does not exist after loading ceph module
Date: Fri, 30 Jul 2010 09:02:57 +0000 (UTC)
Message-ID: <i2u4g1$hnt$3@dough.gmane.org>
References: <AANLkTi=r74Q3SBS71+QcditFhNxzUfdCf1F9F18R4Yiy@mail.gmail.com>
	<AANLkTikOViq3VCY2fwtut1c1kU8dkM7pRRwqfrYyhEPL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55042 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321Ab0G3JDJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jul 2010 05:03:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OelUh-0000yc-CH
	for ceph-devel@vger.kernel.org; Fri, 30 Jul 2010 11:03:07 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 11:03:07 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 11:03:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Fri, 30 Jul 2010 16:41:51 +0800 schrieb Xiaoguang Liu:



> I would like to try the RBD feature of Ceph. I am following
> http://ceph.newdream.net/wiki/Rbd,=C2=A0 but failed at :

* did you really compile the ceph.ko module from source?
* did you verify that you actually loaded the right ceph.ko module and=20
not stock ceph.ko?

general note: do use the new 0.21. you won't get happy with 0.20.2.

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
