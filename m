From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Sat, 28 May 2016 02:15:44 +0200
Message-ID: <b939f4d1-189e-9593-5fba-ff6867f80a9e@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:10103 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055AbcE1AQG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2016 20:16:06 -0400
In-Reply-To: <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 30-11-2015 14:21, Sage Weil wrote:
> The problem with all of the porting code in general is that it is doomed 
> to break later on if we don't have (at least) ongoing build tests.  In 
> order for a FreeBSD or OSX port to continue working we need VMs that run 
> either gitbuilder or a jenkins job or similar so that we can tell when it 
> breaks.
> 
> If someone is willing to run a VM somewhere to do this we can pretty 
> easily stick it on the gitbuilder page at
> 
> 	http://ceph.com/gitbuilder.cgi

Hi Sage,

Just a bit of victory after 6 months.

I'm not yet there by far, but I've just passed the mark of only one test
not working (the osd-markdown.sh one) and all other tests that I think
that are passable have now passed.

And that all against a tree that is rather recent.

osd-markdown is a test that is rather hard to follow, analyse, debug...
Which starts with the fact that I cannot find any docs on the parameters
that are being manipulated.
Asked the author, but got no response.
So I'm very tempted to execlude that test for the time being.

And I'm hoping that you can merge the compiletime #9178 wip soon, and I
can begin with the next set of commit to merge the testing work.

Thanx,
--WjW


