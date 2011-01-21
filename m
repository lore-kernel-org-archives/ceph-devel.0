From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Fri, 21 Jan 2011 14:14:41 -0800
Message-ID: <AANLkTinixq_tnvSbMcOXEA=0=gDmG6wSSmRWZ_AOtAT1@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
	<AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
	<AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
	<AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com>
	<AANLkTimrXeUnWTPpOGvNFVFRNv=jb9g=Yn3hK=cBYwst@mail.gmail.com>
	<AANLkTim=Nk3HUwROkpCMZuL_vc_4mJt5dH8FkbMGM+Ci@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37864 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab1AUWOm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jan 2011 17:14:42 -0500
Received: by ewy5 with SMTP id 5so1201350ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jan 2011 14:14:41 -0800 (PST)
In-Reply-To: <AANLkTim=Nk3HUwROkpCMZuL_vc_4mJt5dH8FkbMGM+Ci@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: DongJin Lee <dongjin.lee@auckland.ac.nz>, tsuna <tsunanet@gmail.com>

On Thu, Jan 20, 2011 at 9:13 AM, tsuna <tsunanet@gmail.com> wrote:
> On Tue, Jan 18, 2011 at 11:54 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
>> Are you running on 32-bit machines? It looks like we're accidentally
>> overflowing a 32-bit value, but I don't have any 32-bit machines handy
>> to test it on. Please apply the patch at http://pastebin.com/yahTxRzQ,
>> recompile, and let me know if you still have journal size issues. :)
>
> There's a typo in your patch, "newsize << 20;" should be "newsize <<= 20;"
Oh, yep. Thanks for that. It's fixed on the patch page and just got
pushed into the testing branch.

On Thu, Jan 20, 2011 at 8:40 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
> Greg: Thanks for the various supports (just emailing you since it's
> minor updates)
> and sorry for late reply, we were thinking to do your recommended
> updates, but we *always* used 64bit version..
> we followed the debian installation guide and apt-get all once as
> guided on the Wiki.
Hmmm. Well, your final two journal sizes are definitely overflowing
somehow, though I don't know why that would happen on a 64-bit
machine. I'm still not sure what's going on in the middle ones. Let us
know if they persist after .24.2 (which should be going out today). :)
-Greg
