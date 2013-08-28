From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Wed, 28 Aug 2013 04:49:44 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664B16E7@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
  <6035A0D088A63A46850C3988ED045A4B6649D242@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:37948 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab3H1Etv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 00:49:51 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B6649D242@BITCOM1.int.sbss.com.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

Still having crashes with the rbd module for blktap. I think I can't get consistent debugging info out of librbd. When it writes to a file the logging is buffered so the tail is always missing. When it logs to syslog I thought I was getting everything but now I'm not so sure.

What is the best way to ensure that each log message gets flushed to the logfile? I'm looking now but a hint would get the job done faster!

Thanks

James
