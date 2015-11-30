From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 14:54:11 +0100
Message-ID: <565C5503.50200@digiware.nl>
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
Received: from smtp.digiware.nl ([31.223.170.169]:29081 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbK3NyY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Nov 2015 08:54:24 -0500
In-Reply-To: <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

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

Cool page that gitbuilder....
Would be nice to have a FreeBSD builder in there as well. :)

Once I get things up and running, I will be able to supply either VMs
and/or actual hardware to do building and testing.

My personal problem is that I'm a longtime FreeBSD user (since 1993) and
now I'm sort of forced into (the) other OS. Because we like Ceph. So we
are building currently on Linux, but would like to have a FreeBSD
possibility as well.

But first I need to get the code to compile, and then actually run.
Long term goal is to use ZFS as basis, since this is a rock solid FS on
FreeBSD. And then integrate it with another nice FreeBSD thingy: bhyve.

Now I'm taking small baby steps at the moment, and do have other chores
as well. So progress might be slow, but I think I found some of the
issues I did not get to yet in the git of Mykola.

Thanx for the feedback.

Regards,
--Willem Jan


