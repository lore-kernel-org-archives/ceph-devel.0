From: Sage Weil <sage@inktank.com>
Subject: RE: debugging librbd async
Date: Wed, 28 Aug 2013 08:45:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308280845040.1984@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B6649D242@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B664B16E7@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33926 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab3H1Pp6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 11:45:58 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B664B16E7@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

On Wed, 28 Aug 2013, James Harper wrote:
> Still having crashes with the rbd module for blktap. I think I can't get 
> consistent debugging info out of librbd. When it writes to a file the 
> logging is buffered so the tail is always missing. When it logs to 
> syslog I thought I was getting everything but now I'm not so sure.

You can disable buffering with

 log max recent = 0

That should catch everything!

> What is the best way to ensure that each log message gets flushed to the 
> logfile? I'm looking now but a hint would get the job done faster!

sage


> 
> Thanks
> 
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
