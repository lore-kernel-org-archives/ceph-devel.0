From: Sage Weil <sage@newdream.net>
Subject: Re: a problem related to stray directory
Date: Sun, 27 Mar 2011 21:39:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103272137560.6107@cobra.newdream.net>
References: <AANLkTik+SrDTRi06ioOnitOgvZRYSFpnD3SLaOPrTmGe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36694 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab1C1Eg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 00:36:29 -0400
In-Reply-To: <AANLkTik+SrDTRi06ioOnitOgvZRYSFpnD3SLaOPrTmGe@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 28 Mar 2011, huang jun wrote:
> hi
>   i just have another question.when a file is unlinked it goes into
> the stray directory.eval_stray() will be called, in the eval_stray()
> will check dirfrags is empty or no,
>   but i look log  file , the source exits after checked the dirfrag. i
> can't find the trim_dirfrags() or close_dirfrags() be called in the
> log file
>   so i have a problem, when trim_dirfrags() or close_dirfrags() will be 
> called.
>  thanks

Do you mean that the dirfrag is empty, but isn't closed, and as a result 
eval_stray() won't purge it?  Are you triggering this situation?

Thanks!
sage

