From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Sat, 17 Aug 2013 14:10:34 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6649D242@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:36918 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab3HQOKu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Aug 2013 10:10:50 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

I can now reliably reproduce this with fio (see config following email), but never under valgrind so far.

James

[global]
directory=/tmp/fio
size=128M
ioengine=libaio

[randwrite1]
rw=randwrite
iodepth=32

[randread1]
rw=randread
iodepth=32

[randwrite2]
rw=randwrite
iodepth=32

[randread2]
rw=randread
iodepth=32
