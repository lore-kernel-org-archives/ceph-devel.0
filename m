From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crash
Date: Mon, 23 May 2011 16:08:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105231606440.30953@cobra.newdream.net>
References: <4DDACFF0.5060902@ufm.su> <Pine.LNX.4.64.1105231526470.30953@cobra.newdream.net>
 <4DDAE39A.4040003@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53753 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab1EWXGu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 19:06:50 -0400
In-Reply-To: <4DDAE39A.4040003@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Tue, 24 May 2011, Fyodor Ustinov wrote:
> On 05/24/2011 01:27 AM, Sage Weil wrote:
> > Hi Fyodor,
> > 
> > This looks like #1104.  Will try to sort it out today, it should be a
> > simple one.
> > 
> > sage
> May be need my "debug mds = 20, debug ms = 1" log?
> But it is zipped - 26M. Need?

If you can attach it to that bug, that'd be great.  Also, do you have a 
core file?  It's not clear from the other log which bad pointer is being 
dereferenced.

Thanks!
sage
