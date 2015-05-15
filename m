From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 12:48:24 +0300
Message-ID: <CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
References: <5555B1E9.3010003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38052 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbbEOJs0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 05:48:26 -0400
Received: by wicnf17 with SMTP id nf17so130112327wic.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2015 02:48:25 -0700 (PDT)
In-Reply-To: <5555B1E9.3010003@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 15, 2015 at 11:44 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> I'm a newcomer to the ceph project. SubmittingPatches says to target
> next for bugfixes and master for features. Beyond that I only have the
> vaguest notion of what the next branch is for and how patches get moved
> back and forth between master and next. Can anyone comment?

next is development release branch (while firefly, hammer, etc are
stable release branches).  Bugfix PRs are submitted against next, next
is periodically merged into master.  In fact anybody can merge next
into master at any time to get the fix merged into next in master.
(Not the other way around - fixes are not supposed to go into master and
then be cherry-picked into next.)  After the development release is
cut, next is reset to master.

I'm sure others will correct me if I missed something.

Thanks,

                Ilya
