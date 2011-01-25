From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Tue, 25 Jan 2011 14:36:51 -0800
Message-ID: <AANLkTimo8y7tV6dbmSLTSREOs_TeUDq9aYkvvUAHNaSx@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
	<AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
	<AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
	<AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com>
	<AANLkTimrXeUnWTPpOGvNFVFRNv=jb9g=Yn3hK=cBYwst@mail.gmail.com>
	<AANLkTim=Nk3HUwROkpCMZuL_vc_4mJt5dH8FkbMGM+Ci@mail.gmail.com>
	<AANLkTinixq_tnvSbMcOXEA=0=gDmG6wSSmRWZ_AOtAT1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63186 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1AYWgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 17:36:53 -0500
Received: by eye27 with SMTP id 27so222626eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 14:36:52 -0800 (PST)
In-Reply-To: <AANLkTinixq_tnvSbMcOXEA=0=gDmG6wSSmRWZ_AOtAT1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: DongJin Lee <dongjin.lee@auckland.ac.nz>, tsuna <tsunanet@gmail.com>

On Fri, Jan 21, 2011 at 2:14 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Thu, Jan 20, 2011 at 8:40 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
>> Greg: Thanks for the various supports (just emailing you since it's
>> minor updates)
>> and sorry for late reply, we were thinking to do your recommended
>> updates, but we *always* used 64bit version..
>> we followed the debian installation guide and apt-get all once as
>> guided on the Wiki.
> Hmmm. Well, your final two journal sizes are definitely overflowing
> somehow, though I don't know why that would happen on a 64-bit
> machine. I'm still not sure what's going on in the middle ones. Let us
> know if they persist after .24.2 (which should be going out today). :)
> -Greg

I just checked this briefly on version .24.2 and was unable to
reproduce any issues. Let me know if you encounter them again!
-Greg
