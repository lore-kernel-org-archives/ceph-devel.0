From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Tue, 03 Feb 2015 21:15:38 -0600
Message-ID: <54D18EDA.6020901@redhat.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>	<CAC8iE5hSDg-nY+7g+N2FF6M8ijGe-s3+Dmg1PkGP7KqJOduyqQ@mail.gmail.com>	<CACJqLyZegga=U2gJ+bQWjG_AY7OhsWXhgrT=Og-ahO3btyd7fQ@mail.gmail.com>	<6F3FA899187F0043BA1827A69DA2F7CC0214CCFA@shsmsx102.ccr.corp.intel.com> <CAC8iE5iLJ53AS4+AH-2F+NCVwf5h7oVcb79bTPMZQQY3VAu0fA@mail.gmail.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:57910 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbBDDPm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 22:15:42 -0500
Received: by mail-qg0-f49.google.com with SMTP id e89so641167qgf.8
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 19:15:41 -0800 (PST)
In-Reply-To: <CAC8iE5iLJ53AS4+AH-2F+NCVwf5h7oVcb79bTPMZQQY3VAu0fA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/03/2015 09:03 AM, Chris Pacejo wrote:
> Hi Xiaoxi,
>
> On Sun, Feb 1, 2015 at 9:50 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
>> We can always use a structure database in an unstructured way, I think it's workable in theory, but  why choose MySQL?
>
> In our internal performance tests, it performed better than LevelDB
> and some others, and it's well-proven.  It's not our first choice, nor
> are we done investigating other options.  But we'll check out LMDB,
> thanks for the pointer.
>
> Regardless, the issues we're seeing are equally applicable to any
> key-value backend.

You may also wish to try the rocksdb backend with universal compaction 
rather than leveled compaction.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
