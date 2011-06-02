From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: write file problems
Date: Thu, 2 Jun 2011 08:56:05 -0700
Message-ID: <20110602155605.GB11721@dreamer>
References: <BANLkTimbwCo1yJ3vJ5qc6QbELAdZdwZGHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37334 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab1FBP4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 11:56:06 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimbwCo1yJ3vJ5qc6QbELAdZdwZGHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jun 02, 2011 at 05:35:59PM +0800, biyan chen wrote:
> Ceph file systems, write file will be no reaction, namely dead state
> 
> For example:
> 
> Dd if = / a dev/zero of = MMM bs = 8k = 100 count
> 
> Will have been waiting!
> 
> And then other SSH window using command "ls -al" is no  reaction!

Is this perhaps the same as http://tracker.newdream.net/issues/1110
as seen by Andre Noll?

In either case, you need to give us more information; what version of
ceph are you running, what does your cluster look like, do you use
kclient or cfuse, what kernel version; and then, we probably need to
see the logs created when this problem starts happening.

-- 
:(){ :|:&};:
