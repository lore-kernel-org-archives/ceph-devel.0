From: James Harper <james.harper@bendigoit.com.au>
Subject: link errors
Date: Fri, 20 Dec 2013 09:38:53 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66CD8CBA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:53190 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab3LTJi6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Dec 2013 04:38:58 -0500
Received: from smtp2.bendigoit.com.au ([203.16.207.99] helo=BITCOM1.int.sbss.com.au)
	by smtp1.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VtwYR-0000OD-8t
	for ceph-devel@vger.kernel.org; Fri, 20 Dec 2013 20:39:35 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm trying to compile qemu with rbd support, but it throws up a heap of errors like '/usr/local/src/ceph-0.67.4/src/./osd/osd_types.h:2442: undefined reference to `__cxa_throw'' when it tries to test for rbd support.

It's breaking when doing static link of a dummy file in configure. Is this supposed to work?

Thanks

James

