From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Fri, 20 Jul 2012 14:54:34 +0930
Message-ID: <5008EB92.3010106@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <5007FB6E.1080307@bashkirtsev.com> <CADvuQRGaivtgho4R=rk3c_B6eJ2GfG=tZFGNy9knoKyh2CR-zg@mail.gmail.com> <CADxhoDT8rimSwP+Y75tGVo3Nd5WYw8xHyDxBAMV8tb5no0OP4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:54222 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2GTFYr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 01:24:47 -0400
In-Reply-To: <CADxhoDT8rimSwP+Y75tGVo3Nd5WYw8xHyDxBAMV8tb5no0OP4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: Tommi Virtanen <tv@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org


> What node/leaf size are you using on your btrfs volume?
Default 4K.

