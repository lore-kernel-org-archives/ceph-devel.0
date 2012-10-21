From: Sage Weil <sage@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Sun, 21 Oct 2012 14:35:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
References: <508469CE.3000502@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569Ab2JUVfm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Oct 2012 17:35:42 -0400
In-Reply-To: <508469CE.3000502@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 21 Oct 2012, Joe Buck wrote:
> It looks like vstart.sh does not work without authx enabled. Given that, I'd
> propose to change the default to having cephx be enabled and then use the -x
> flag to disable cephx.
> 
> Interestingly enough, the help output for vstart.sh already states that the -x
> flag disables authx (which is not the case at present, but is after this patch
> is applied).
> 
> I've attached a patch to vstart that 1) changes the mention of authx to cephx
> for consistency and 2) defaults vstart.sh to using cephx with the -x flag now
> serving to disable cephx.

Sounds like a good change, but let's make -x do nothing and -X disable 
cephx, so that existing habitual typing of -x doesn't lead to failure.

Also, we should fix the auth none usage at some point.  :)

sage
