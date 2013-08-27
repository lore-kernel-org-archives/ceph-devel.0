From: James Harper <james.harper@bendigoit.com.au>
Subject: trivial bug in aio_write
Date: Tue, 27 Aug 2013 11:27:50 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664AFC7D@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:44146 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3H0L15 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 07:27:57 -0400
Received: from bitcom1.int.sbss.com.au ([2001:388:e000:712:a5ca:4fd3:14f:ad5d])
	by smtp1.bendigoit.com.au with esmtp (Exim 4.69)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VEHRQ-0007N1-3e
	for ceph-devel@vger.kernel.org; Tue, 27 Aug 2013 21:28:08 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In internal.cc function aio_write, the ldout(cct, ...) statement writes out &buf instead of buf. I assume this is not intentional.

James
