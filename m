From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Mon, 4 Apr 2016 14:44:20 +0000
Message-ID: <CY1PR0201MB1897E0C332F8ED4F5EE82A08E89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56FD572D.6070608@mirantis.com>
 <CY1PR0201MB1897E34D0EADBF59212AE047E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <57025A9B.700@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0076.outbound.protection.outlook.com ([207.46.100.76]:35936
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755633AbcDDOoY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 10:44:24 -0400
In-Reply-To: <57025A9B.700@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Monday, April 04, 2016 5:14 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sage@newdream.net>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> 
> 
> On 31.03.2016 21:38, Allen Samuels wrote:
> >> Another thing to consider is an ability to use introduced checksums
> >> for scrubbing. One can probably extend objectstore interface to be
> >> able to validate stored data without data sending back.
> >> I don't see such an option at the moment. Please correct me if I missed
> that.
> > No need for that option. Just read the data check the return code (good or
> checksum failure) then discard the data. This is essentially exactly the same
> code-path as a "please validate the checksum" specialized opcode.
> >
> I'd rather disagree.
> In fact one can perform object verification more effectively when using
> specific op:
> 
> - No need for decompression that's present in the read data-path

Yes, I missed this. I agree this is important to optimize.

> - No need to select proper read  buffer size. Verify operation can run over
> blob map instead of lextent one and read data by pextents.

With some careful structuring, this will just "fall out" of the code. In other words, you'll implement the code as the standard interface that takes in logical offsets and uses the lextent table to convert them into the correct set/subset of pextents. Then a second interface that operates in pextents. This also helps localize the checksum code.


> - Verify can be done via single op call.
> - IMHO code is more elegant and readable having specific op handler. In your
> option one has to Implement  "sub data-path" for read handler to discard
> data and do other optimizations if any... More flags, if statements, etc...
> 

