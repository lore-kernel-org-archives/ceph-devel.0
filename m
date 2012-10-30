From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Re: Ceph performance
Date: Tue, 30 Oct 2012 11:57:38 +0100
Message-ID: <CAGqxmDNRAZdHwuWLmjXMxVV_wMTNX_s_yme_e+otdkepHBKvqw@mail.gmail.com>
References: <508E8C1C.4020605@gmail.com>
	<508ED184.50203@inktank.com>
	<508F8F8D.7010107@gmail.com>
	<CAPYLRzhfv08vS0CNEHP2d6+M1FpwNDgtU28DTYn9vjFmLnP9XA@mail.gmail.com>
	<CAGqxmDPfmX1-j5H+sJwAgJD1_1jPVsJfmPW1Bet+UuHAv1BKZg@mail.gmail.com>
	<508FAB9A.20307@gmail.com>
	<CAGqxmDN10ELB5dh3jyDr7BBZQ=KEsuR3gcg4nvJi3J50Ju56fA@mail.gmail.com>
	<508FB1BB.405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52868 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757785Ab2J3K5k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 06:57:40 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so99180wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 03:57:39 -0700 (PDT)
In-Reply-To: <508FB1BB.405@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Sam Lang <sam.lang@inktank.com>, ceph-devel@vger.kernel.org

> Give me a moment to check this out and thank you for opening my eyes.
> Let me to notify you about the results of implementing your recommendations.

I am looking forward to hearing from you. One more thing. Run rados
bench right now to see from what performance level are you starting. I
suggest 2 tests for default block size and lets say 4KB.

Here is very useful paper which helped me a lot:
http://ceph.com/community/ceph-performance-part-1-disk-controller-write-throughput/

-- 
Regards
Maciej Galkiewicz
