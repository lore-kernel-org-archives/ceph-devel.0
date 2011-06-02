From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph code coverage integration proposal
Date: Thu, 2 Jun 2011 14:18:01 -0700
Message-ID: <20110602211801.GD11721@dreamer>
References: <20110602180508.GC11721@dreamer>
 <4DE7FC06.9020704@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47382 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab1FBVSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 17:18:02 -0400
Content-Disposition: inline
In-Reply-To: <4DE7FC06.9020704@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jun 02, 2011 at 02:09:26PM -0700, Josh Durgin wrote:
> On 06/02/2011 11:05 AM, Tommi Virtanen wrote:
> <snip>
> >Proposal:
> >
> >- add autoconf flag --enable-coverage, or some such (afaik Josh has
> >   this already), that compiles with coverage recording
> 
> This is in the wip_gcov branch as --with-gcov.

Sweet.

BTW, I know this has been going on for a while, but autoconf wasn't
meant to be used like that.. --with-foo is supposed to be about
external libraries and such, --enable-foo is supposed to be about
features. So --with-debug should have been --enable-debug. I didn't
change that the last time I was working on autoconf, because I wanted
to limit the size of the crater I was creating, but for new stuff we
probably should do it the "right way".

-- 
:(){ :|:&};:
