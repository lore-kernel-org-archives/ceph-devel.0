From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Thu, 7 Apr 2016 00:52:48 +0000
Message-ID: <CY1PR0201MB18977F92B66A47AE41220AC7E8900@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
 <20160405151030.GA20891@onthe.net.au> <20160406063849.GA5139@onthe.net.au>
 <BLUPR0201MB18900E0ADCEA8C22D67DF444E89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <20160406171702.GA5847@onthe.net.au>
 <BLUPR0201MB18903C5D060F326FEC75F81FE89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <20160407004307.GA15754@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0064.outbound.protection.outlook.com ([157.56.111.64]:35104
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751964AbcDGAw5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 20:52:57 -0400
In-Reply-To: <20160407004307.GA15754@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

So, what started this entire thread was Sage's suggestion that for HDD we would want to increase the size of the block under management. So if we assume something like a 32-bit checksum on a 128Kbyte block being read from 5ZB Then the odds become:

1 - (2^-32 * (1-(10^-15))^(128 * 8 * 1024) - 2^-32 + 1) ^ ((5 * 8 * 10^21) / (4 * 8 * 1024))

Which is 

0.257715899051042299960931575773635333355380139960141052927

Which is 25%. A big jump ---> That's my point :)

So if you increase the checksum size by 5 bits you'll get back to where you were:

1 - (2^-37 * (1-(10^-15))^(128 * 8 * 1024) - 2^-37 + 1) ^ ((5 * 8 * 10^21) / (4 * 8 * 1024))

0.009269991973796787499061899655143549844043842016480142301 



Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Chris Dunlop [mailto:chris@onthe.net.au]
> Sent: Wednesday, April 06, 2016 5:43 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Sage Weil <sage@newdream.net>; Igor Fedotov
> <ifedotov@mirantis.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> On Wed, Apr 06, 2016 at 06:06:25PM +0000, Allen Samuels wrote:
> >>>> On the bright side, if the 10^-9 formula (Chris #1, Chris #2, Sage)
> >>>> are anywhere near correct, they indicate with a block size of 4K
> >>>> and 32-bit checksum, you'd need to read 5 * 10^21 bits, or 0.5 ZB,
> >>>> to get to a 1% chance of seeing unflagged bad data, e.g.:
> >>
> >> P(bad data) @ U=10^-15, C=32, D=(4 * 8 * 1024), N=(5 * 8 * 10^21)
> >>   = 1 - (2^-C * (1-U)^D - 2^-C + 1) ^ (N / D)
> >>   = 1 - (2^-32 * (1-(10^-15))^(4 * 8 * 1024) - 2^-32 + 1) ^ ((5 * 8 * 10^21) / (4
> * 8 * 1024))
> >>   = 0.009269991978483162962573463579660791470065102520727107106
> >>   = 0.92%
> >
> > Where does 10^21 come into the equation? I thought we were dealing
> with 5PB.
> 
> ZB rather than PB. But I see my explanatory text still doesn't match the
> numbers actually being plugged into the formula. Sigh.
> 
> Corrected explanatory text: with a 4KB block size, 32 bit checksum and BER 1
> x 10^-15, 5 ZB of data gets you close to a 1% chance of seeing unflagged bad
> data.
