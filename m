From: =?UTF-8?B?QWRhbSBPY2htYcWEc2tp?= <blink@blink.waw.pl>
Subject: Re: problem with hanging cluster
Date: Thu, 08 Nov 2012 12:42:43 +0100
Message-ID: <509B9AB3.1060502@blink.waw.pl>
References: <509B9430.40903@blink.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from balagan.blink.waw.pl ([109.196.45.178]:57697 "EHLO
	balagan.blink.waw.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab2KHLm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 06:42:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by balagan.blink.waw.pl (Postfix) with ESMTP id B43963A13D
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 12:42:56 +0100 (CET)
Received: from balagan.blink.waw.pl ([127.0.0.1])
	by localhost (balagan.blink.waw.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Un8ozC0RrtJv for <ceph-devel@vger.kernel.org>;
	Thu,  8 Nov 2012 12:42:48 +0100 (CET)
Received: from MacBook-Pro-USER.local (cmt123.neoplus.adsl.tpnet.pl [83.31.147.123])
	by balagan.blink.waw.pl (Postfix) with ESMTPSA id 31DCA3A138
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 12:42:48 +0100 (CET)
In-Reply-To: <509B9430.40903@blink.waw.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

W dniu 08.11.2012 12:14, Adam Ochma=C5=84ski pisze:
> Hi,
> our test cluster going stuck every time when one of our osd host goin=
g
> down, when mising osd go to "up" state and recovery go to 100% cluste=
r
> still not working propertly.

I forgot add version of ceph i use: 0.53-422-g2d20f3a

--=20
Best,
blink
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
