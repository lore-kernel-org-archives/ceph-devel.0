From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Sat, 16 Jan 2016 13:56:33 +0100
Message-ID: <569A3E01.3030109@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43543 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbcAQQaI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Jan 2016 11:30:08 -0500
In-Reply-To: <565D7FA8.3010301@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 1-12-2015 12:08, Willem Jan Withagen wrote:
> On 30-11-2015 14:21, Sage Weil wrote:
>> The problem with all of the porting code in general is that it is doomed
>> to break later on if we don't have (at least) ongoing build tests.  In
>> order for a FreeBSD or OSX port to continue working we need VMs that run
>> either gitbuilder or a jenkins job or similar so that we can tell when it
>> breaks.
>>
>> If someone is willing to run a VM somewhere to do this we can pretty
>> easily stick it on the gitbuilder page at
>>
>>     http://ceph.com/gitbuilder.cgi
> 

I have build a pull request that includes the changes to get the
automake tools do a decent job on the current master.

https://github.com/ceph/ceph/pull/7239

But then I tried building a second WIP with changes to the {cc,} code,
but then I end up with a WIP tree with a complete string of other
commits in between. Which is certainly not the intention.

https://github.com/wjwithagen/ceph/tree/wip-wjw-freebsd-compilechanges

The next one WIP would be wip-wjw-freebsd-testchanges which got me as
far as 110 tests successfully completed.

I see to be able to mess up the integration of the ceph/master into my
fork and my WIPs...

Is there a way to easily repair this? Or just
	save the diffs
	scrap the whole fork
	make a new fork and WIP
	push

Once I get this straight I promise to write this down as simple howto,
on then how to keep up in this fork and WIP with ceph/master

Thanx,
--WjW


