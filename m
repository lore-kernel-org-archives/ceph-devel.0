From: Chris Pacejo <cpacejo@clearskydata.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Fri, 30 Jan 2015 11:08:12 -0500
Message-ID: <CAC8iE5hSDg-nY+7g+N2FF6M8ijGe-s3+Dmg1PkGP7KqJOduyqQ@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60855 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbA3QIN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 11:08:13 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so4366578ieb.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 08:08:12 -0800 (PST)
In-Reply-To: <CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 30, 2015 at 10:52 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> It's really a surprise that you impl a MySQL backend. Could I know the
> purpose? Because it may not fit with keyvaluestore I think.

We've found it to perform better (in isolation) than LevelDB.  We were
able to map KeyValueDB's interface to it fairly painlessly, and I
believe correctly.  (The only major catch was that we needed to buffer
operations within a transaction and execute them all at once on
submit, to prevent MySQL unnecessarily holding locks for the duration
of long-lived transactions.)


> You can simply calculate the sum of submit_transaction_sync consuming
> time, it would be the multiple of the op thread number.

I will try this, thanks.
