From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: mon disk access pattern
Date: Fri, 15 Jun 2012 22:31:27 +0200
Message-ID: <4FDB9B9F.10709@profihost.ag>
References: <4FDACD90.2080807@profihost.ag> <4FDB05A7.3080202@widodh.nl> <4FDB1DCC.6090701@inktank.com> <Pine.LNX.4.64.1206150930110.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56173 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589Ab2FOUb0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 16:31:26 -0400
In-Reply-To: <Pine.LNX.4.64.1206150930110.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 18:30, schrieb Sage Weil:
> On Fri, 15 Jun 2012, Mark Nelson wrote:
>> On 06/15/2012 04:51 AM, Wido den Hollander wrote:
>> I think at some point someone mentioned to me that the mon can cause a lot of
>> syncs, so running them on the OSDs without syncfs might be detrimental.  For
>> the majority of our internal performance testing I've kept them off the OSDs
>> just to be sure.
>
> Right.  The only thing interesting about the mon access pattern is that it
> calls fsync() a lot when healthy, and will call syncfs() or sync() during
> recovery.

But if i have syncfs support does it still matter if they sit on an osd 
with a seperate disk? Do you have any iops or bandwith knowledge for the 
mon daemon?

Stefan
