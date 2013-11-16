From: James Harper <james.harper@bendigoit.com.au>
Subject: does librbd actually need leveldb?
Date: Sat, 16 Nov 2013 08:37:43 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665EE988@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:54762 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab3KPIht convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Nov 2013 03:37:49 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VhbNx-0007CW-Hn
	for ceph-devel@vger.kernel.org; Sat, 16 Nov 2013 19:37:45 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Does librbd actually need leveldb?

And if so, does it need it in all cases?

I'm trying to figure out what dependencies are required for librbd for win32, and leveldb doesn't build cleanly at first go.

Thanks

James
