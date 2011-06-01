From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph lock
Date: Wed, 1 Jun 2011 08:47:44 -0700
Message-ID: <20110601154744.GB28536@dreamer>
References: <BANLkTinzNqrd97WnAbBOE_t0bo-KO-2pOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55885 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758843Ab1FAPro (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 11:47:44 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinzNqrd97WnAbBOE_t0bo-KO-2pOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 01, 2011 at 10:26:03AM +0800, biyan chen wrote:
> HI
> 
> Everybody!
> 
> Who can give me some information about CEPH file locks
> 
> CEPH files lock mechanism is how

That's a really open ended question.

Ceph in general implements cluster-wide POSIX file locks, internally
managing the locks based on the same clustering & distribution
mechanisms as it uses for coordinating its own work. From the view
pointer of a filesystem user, it should "just work", though naturally
with network operations latency is higher than with purely local
locks.

The cfuse client does not support them, currently. This is merely a
case of "oh nobody wrote that code yet".

What are you interested in knowing?

-- 
:(){ :|:&};:
