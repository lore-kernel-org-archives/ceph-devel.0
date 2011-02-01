From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: gcov/lcov
Date: Tue, 1 Feb 2011 09:27:40 -0800
Message-ID: <20110201172740.GA13828@dreamer>
References: <Pine.LNX.4.64.1101312121050.8040@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35858 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab1BAR1k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 12:27:40 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101312121050.8040@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 31, 2011 at 09:21:14PM -0800, Sage Weil wrote:
> We should set up gcov/lcov as part of the testing infrastructure so we can 
> track what code paths are tested:
> 
>         http://ltp.sourceforge.net/coverage/lcov.php

That has been in the plans from day one. Line & branch coverage are
awesome tools.

Just focusing on system-level testing right now.. Please write unit
tests, because otherwise the first coverage reports are going to be
really disappointing ;)

-- 
:(){ :|:&};:
