From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: adminsocket
Date: Sat, 23 Nov 2013 07:05:30 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665FC039@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B665FBE58@BITCOM1.int.sbss.com.au>
 <52901BF5.9070708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:36161 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3KWHGN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Nov 2013 02:06:13 -0500
In-Reply-To: <52901BF5.9070708@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> On 11/22/2013 06:42 PM, James Harper wrote:
> > What is an adminsocket used for? Would librbd use one in normal
> operation?
> 
> It's a way to send administrative and informational commands directly
> to a Ceph entity (usually a daemon, but sometimes a client).  Almost
> all the ceph entities create one...osd, mon, mds, client.  It's not
> really "normal" operation, but you can find stats there, and often
> things like status, version of the software, etc.
> 

Ok. So if I commented out anything that uses it (just ceph context for perf counters by the looks of it), for the purposes of a win32 build of librbd, it should still be functional.

Thanks

James
