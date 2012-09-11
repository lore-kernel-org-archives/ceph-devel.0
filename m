From: Tommi Virtanen <tv@inktank.com>
Subject: Re: crush create-or-move
Date: Tue, 11 Sep 2012 09:44:10 -0700
Message-ID: <CADvuQRF5PSTV42Bd7yZb6-b1C2XKUZkz5AZ4BSqF4-8rmEhK9g@mail.gmail.com>
References: <alpine.DEB.2.00.1209110831260.1305@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34763 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2IKQob (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 12:44:31 -0400
Received: by vcbfy27 with SMTP id fy27so881015vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 09:44:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209110831260.1305@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 9:09 AM, Sage Weil <sage@inktank.com> wrote:
> I pushed a wip-crush branch that implements 'ceph osd crush create-or-move
> ...'.  I don't think it's worth backporting this to argonaut, since the
> user is actually in the deploy scripts, so any chef/juju/whatever won't
> care if they're running against argonaut or bobtail in this case.
> (Right?)  (It also depends on a bunch of option parsing cleanups that I'd
> rather not wade through.)

No need to backport. Stable will just keep resetting the weight to 1
(/configured value).
