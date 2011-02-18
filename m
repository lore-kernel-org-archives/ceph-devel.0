From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 18 Feb 2011 09:15:18 -0800
Message-ID: <25EE8D916B8E4C7293AA2E436DCA143F@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40000 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1BRRQM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 12:16:12 -0500
Received: by gyh20 with SMTP id 20so62529gyh.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 09:16:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, February 17, 2011 at 11:13 PM, Sage Weil wrote:
On Thu, 17 Feb 2011, Jim Schutt wrote:
> > Why should it take 28 seconds to add a new timer event?
> 
> Huh.. that is pretty weird. I see multiple sync in there, too, so it's 
> not like something was somehow blocking on a btrfs commit.
> 
> Anybody else have ideas? :/
> 
> sage
I must be missing something but I looked through that code (it's short), and as far as I can tell there's no blocking code anywhere at all. The only time it takes any locks is when grabbing the dout locks for those debug prints; it doesn't initiate any file IO or wait for any completions; it just does a few map ops and g_time.now() arithmetic.
It does signal Timer::cond at the end of the timer insert, but the only things waiting on that should be the timer thread itself, which needs to get back the osd_lock, which is currently locked so that shouldn't be a problem either!
-Greg



