From: Stefan Priebe <s.priebe@profihost.ag>
Subject: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 22:19:27 +0100
Message-ID: <50AAA25F.9040908@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59337 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2KSVTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 16:19:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Josh Durgin <josh.durgin@inktank.com>

Hello Josh,

after digging three days around i got it.

The problem is in aio_discard in internal.cc. The i/o fails when AioZero 
or AioTruncate is used.

It works fine with AioRemove. It seems to depend on overlapping. 
Hopefully i'm able to provide a patch this nicht.

Greets,
Stefan
