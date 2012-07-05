From: David Blundell <David.Blundell@100percentit.com>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 5 Jul 2012 22:15:36 +0000
Message-ID: <A3220DFD-AD2E-49F8-A6E3-88FB92231C63@100percentit.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
 <4FF5D5C3.80207@inktank.com>
 <45F11B42CB5830479EF0E56A27F4E68D7F4E54@exchange1.ad.100it.net>
 <4FF5EFBD.1060603@inktank.com>
 <CACLRD_3BhUe2otUki+a8g8-zXRjUWjf4AMUkRN_Erw7cLdNixA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.100percentit.com ([217.25.0.14]:48297 "EHLO
	smtp.100percentit.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753738Ab2GEWPo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 18:15:44 -0400
In-Reply-To: <CACLRD_3BhUe2otUki+a8g8-zXRjUWjf4AMUkRN_Erw7cLdNixA@mail.gmail.com>
Content-Language: en-US
Content-ID: <C3E4B0F8BB6E45439049E6B3A24CD60B@ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 5 Jul 2012, at 21:21, Samuel Just wrote:

> David,
> 
> Could you try rados -p data bench 60 write -t 16 -b 4096?
> 
> rados bench defaults to 4MB objects, this'll give us results for 4k objects.
> 
> If you could give me the latency too, that would help.
> -Sam

Hi Sam,

I first ran this with the standard ceph settings giving http://pastebin.com/MWLxEazS

This did not cause any slow request warnings so I set "filestore queue max ops = 5000" to increase the number of requests in flight.  This resulted in http://pastebin.com/yFnALmGW and also a small number of slow request warnings.  I ran it again with similar results http://pastebin.com/VnKSVmsq

If there's anything else you need, please let me know.

David