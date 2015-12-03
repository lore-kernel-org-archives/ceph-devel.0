From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, missing rbd
Date: Thu, 3 Dec 2015 14:27:52 +0100
Message-ID: <56604358.7010002@digiware.nl>
References: <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <565F74E8.1070109@digiware.nl>
 <20151203123416.GA16372@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:16884 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964954AbbLCN2V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 08:28:21 -0500
In-Reply-To: <20151203123416.GA16372@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On 3-12-2015 13:34, Mykola Golub wrote:
> On Wed, Dec 02, 2015 at 11:47:04PM +0100, Willem Jan Withagen wrote:
>>
>> Running gmake check is starting to work.
>> 	reporting still thinks there are no successful tests
>> 	but tests themselves report OKE
>>
>> But where I really can not get it to work is with testing rbd.
>>
>> Is starts with the simple:
>> 	 /bin/sh: rbd: not found
>>
>> And whatever I'm trying in configure, no way am I able to get either an
>> executable or a script that will do rbd....
>>
>> So how do I get a rbd that can be used in the tests.
> 
> On the master rbd is built on Linux only, see src/tools/Makefile-client.am.
> 
> I have a patch in my branch that makes rbd build on all platforms
> (excluding kernel bits):
> 
> https://github.com/trociny/ceph/commit/cd427e3ef2a5a307d6649e5b1dcfefdf67d60b29
> 
> But large rbd refactoring has happened in master since that time, and
> my patch requires some work to apply on the current master.
> 

Oke,

Is see the patch, which is simple enough.
Now when code has been moved around, I can imagine that there is going
to be some work required.

It's going on the list.

--WjW

