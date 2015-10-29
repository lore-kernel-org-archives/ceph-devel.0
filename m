From: Wido den Hollander <wido@42on.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Thu, 29 Oct 2015 11:11:22 +0100
Message-ID: <5631F0CA.3010200@42on.com>
References: <5631E4A5.9020003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:45790 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845AbbJ2KLQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 06:11:16 -0400
In-Reply-To: <5631E4A5.9020003@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>



On 29-10-15 10:19, Nathan Cutler wrote:
> Hi Ceph:
> 
> The civetweb code in RGW is taken from https://github.com/ceph/civetweb/
> which is a fork of https://github.com/civetweb/civetweb. The last commit
> to our fork took place on March 18.
> 
> Upstream civetweb development has progressed ("This branch is 19 commits
> ahead, 972 commits behind civetweb:master.")
> 
> Are there plans to rebase to a newer upstream version or should we think
> more in terms of backporting (to ceph/civetweb.git) from upstream
> (civetweb/civetweb.git) when we need to fix bugs or add features?
> 

I think it would be smart to keep tracking civetweb from upstream
otherwise we forked Civetweb.

We might run into some issues with Civetweb which we need to fix
upstream, that's a lot easier if we are close to where upstream is.

Wido

> Thanks and regards
> 
