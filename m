From: Chris Pacejo <cpacejo@clearskydata.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Tue, 3 Feb 2015 10:03:49 -0500
Message-ID: <CAC8iE5iLJ53AS4+AH-2F+NCVwf5h7oVcb79bTPMZQQY3VAu0fA@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
	<CAC8iE5hSDg-nY+7g+N2FF6M8ijGe-s3+Dmg1PkGP7KqJOduyqQ@mail.gmail.com>
	<CACJqLyZegga=U2gJ+bQWjG_AY7OhsWXhgrT=Og-ahO3btyd7fQ@mail.gmail.com>
	<6F3FA899187F0043BA1827A69DA2F7CC0214CCFA@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41298 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbBCPDu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 10:03:50 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so25707739iec.11
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 07:03:50 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0214CCFA@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

On Sun, Feb 1, 2015 at 9:50 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> We can always use a structure database in an unstructured way, I think it's workable in theory, but  why choose MySQL?

In our internal performance tests, it performed better than LevelDB
and some others, and it's well-proven.  It's not our first choice, nor
are we done investigating other options.  But we'll check out LMDB,
thanks for the pointer.

Regardless, the issues we're seeing are equally applicable to any
key-value backend.
