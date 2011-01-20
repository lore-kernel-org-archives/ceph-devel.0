From: tsuna <tsunanet@gmail.com>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Thu, 20 Jan 2011 09:13:18 -0800
Message-ID: <AANLkTim=Nk3HUwROkpCMZuL_vc_4mJt5dH8FkbMGM+Ci@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
 <AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
 <AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
 <AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com> <AANLkTimrXeUnWTPpOGvNFVFRNv=jb9g=Yn3hK=cBYwst@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64889 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1ATROD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 12:14:03 -0500
Received: by wyb28 with SMTP id 28so838159wyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jan 2011 09:14:01 -0800 (PST)
In-Reply-To: <AANLkTimrXeUnWTPpOGvNFVFRNv=jb9g=Yn3hK=cBYwst@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: DongJin Lee <dongjin.lee@auckland.ac.nz>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Jan 18, 2011 at 11:54 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> Are you running on 32-bit machines? It looks like we're accidentally
> overflowing a 32-bit value, but I don't have any 32-bit machines handy
> to test it on. Please apply the patch at http://pastebin.com/yahTxRzQ,
> recompile, and let me know if you still have journal size issues. :)

There's a typo in your patch, "newsize << 20;" should be "newsize <<= 20;"

-- 
Benoit "tsuna" Sigoure
Software Engineer @ www.StumbleUpon.com
