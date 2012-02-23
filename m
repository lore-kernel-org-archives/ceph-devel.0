From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph does not work
Date: Thu, 23 Feb 2012 11:11:09 -0800
Message-ID: <CAORUGqCLqz9ty8KshwN1QDjt9etq+N=fsFFy5MGkFbRngOrovA@mail.gmail.com>
References: <1329988516.4f4603a4d1995@mail.inbox.lv> <CAORUGqC_bDOzyo4nmwT6gUo_yOsyEz3nUFdZs5+m0WdHFMraYw@mail.gmail.com>
 <CAF3hT9ALuVKcdQgsO-oJTP=KX9gnxGdSLLVjsvv69js=j+KXuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52178 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab2BWTLa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 14:11:30 -0500
Received: by werb13 with SMTP id b13so977426wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 11:11:29 -0800 (PST)
In-Reply-To: <CAF3hT9ALuVKcdQgsO-oJTP=KX9gnxGdSLLVjsvv69js=j+KXuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: =?UTF-8?B?0JTQtdC90LjRgdC60LAt0YDQtdC00LjRgdC60LA=?= <slim@inbox.lv>, ceph-devel@vger.kernel.org

On Thu, Feb 23, 2012 at 11:07, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
>>> 3 nodes, each running mon, mds & osd with replication level 3 for data & metadata pools.
...
> Actually the OSDs will happily (well, not happily; the will complain.
> But they will run) run in degraded mode. However, if you have 3 active
> MDSes and you kill one of them without a standby available, you will
> lose access to part of your tree. That's probably what happened
> here...

So let's try that angle. Slim, can you share the output of "ceph -s" with us?
