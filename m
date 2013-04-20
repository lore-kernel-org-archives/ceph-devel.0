From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Sat, 20 Apr 2013 01:30:15 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D73B75D@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
 <517159C3.5030100@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:52309 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965311Ab3DTBaX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 21:30:23 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > rados -p <pool> -b 4096 bench 300 seq -t 64
> 
> sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       0         0         0         0         0         -         0
> read got -2
> error during benchmark: -5
> error 5: (5) Input/output error
> 
> not sure what that's about...
> 

Oops... I typo'd --no-cleanup. Now I get:

   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
 Total time run:        0.243709
Total reads made:     1292
Read size:            4096
Bandwidth (MB/sec):    20.709

Average Latency:       0.0118838
Max latency:           0.031942
Min latency:           0.001445

So it finishes instantly without seeming to do much actual testing...

James

