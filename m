From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Sat, 31 Jan 2015 00:18:11 +0800
Message-ID: <CACJqLyZegga=U2gJ+bQWjG_AY7OhsWXhgrT=Og-ahO3btyd7fQ@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
	<CAC8iE5hSDg-nY+7g+N2FF6M8ijGe-s3+Dmg1PkGP7KqJOduyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:48966 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759167AbbA3QSM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 11:18:12 -0500
Received: by mail-wi0-f176.google.com with SMTP id bs8so4199607wib.3
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 08:18:11 -0800 (PST)
In-Reply-To: <CAC8iE5hSDg-nY+7g+N2FF6M8ijGe-s3+Dmg1PkGP7KqJOduyqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Although I still have some confusing, it's glad to see more attempts.
More test results  are welcomed!

On Sat, Jan 31, 2015 at 12:08 AM, Chris Pacejo <cpacejo@clearskydata.com> wrote:
> On Fri, Jan 30, 2015 at 10:52 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> It's really a surprise that you impl a MySQL backend. Could I know the
>> purpose? Because it may not fit with keyvaluestore I think.
>
> We've found it to perform better (in isolation) than LevelDB.  We were
> able to map KeyValueDB's interface to it fairly painlessly, and I
> believe correctly.  (The only major catch was that we needed to buffer
> operations within a transaction and execute them all at once on
> submit, to prevent MySQL unnecessarily holding locks for the duration
> of long-lived transactions.)
>
>
>> You can simply calculate the sum of submit_transaction_sync consuming
>> time, it would be the multiple of the op thread number.
>
> I will try this, thanks.



-- 
Best Regards,

Wheat
