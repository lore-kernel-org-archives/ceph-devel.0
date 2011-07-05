From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crash.
Date: Tue, 5 Jul 2011 09:03:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107050903160.5150@cobra.newdream.net>
References: <4E0F8DFD.5000601@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50103 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab1GEQAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 12:00:48 -0400
In-Reply-To: <4E0F8DFD.5000601@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sun, 3 Jul 2011, Fyodor Ustinov wrote:

> Hi!
> 
> mds - 0.30
> 
> I can not to reproduce, sorry.
> 
> mds/Locker.cc: In function 'void Locker::file_excl(ScatterLock*, bool*)', in
> thread '0x7fefc6c68700'
> mds/Locker.cc: 3982: FAILED assert(in->get_loner() >= 0 &&
> in->mds_caps_wanted.empty())
>  ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)
>  1: (Locker::file_excl(ScatterLock*, bool*)+0x944) [0x5baa04]
>  2: (Locker::simple_sync(SimpleLock*, bool*)+0x211) [0x5bea41]
>  3: (Locker::file_eval(ScatterLock*, bool*)+0x2c7) [0x5bf537]
> [...]

Thanks, pushed a fix for this to the stable branch.  It'll be included in 
v0.31.

sage
