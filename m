From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Fri, 19 Apr 2013 09:50:43 -0500
Message-ID: <517159C3.5030100@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:65337 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030593Ab3DSOut (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 10:50:49 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so2071163qca.32
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 07:50:48 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/19/2013 06:09 AM, James Harper wrote:
> I just tried a 3.8 series kernel and can now get 25mbytes/second using dd with a 4mb block size, instead of the 700kbytes/second I was getting with the debian 3.2 kernel.

That's.... unexpected.  Was this the kernel on the client, the OSDs, or 
both?

>
> I'm still getting 120kbytes/second with a dd 4kb block size though... is that expected?

that's still quite a bit lower than I'd expect as well.  What were your 
fs mount options on the OSDs?  Can you try some rados bench read/write 
tests on your pool?  Something like:

rados -p <pool> -b 4096 bench 300 write --no-cleanup -t 64
rados -p <pool> -b 4096 bench 300 seq -t 64

with 2 drives and 2x replication I wouldn't expect much without RBD 
cache, but 120kb/s is rather excessively bad. :)

>
> James
>

Mark
