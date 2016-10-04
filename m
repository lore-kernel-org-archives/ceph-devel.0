From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-mgr is in master
Date: Tue, 4 Oct 2016 14:03:31 +0200
Message-ID: <bf4c0368-09f1-0f6d-16c3-ed7a321cba51@digiware.nl>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
 <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:16674 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753589AbcJDMDh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Oct 2016 08:03:37 -0400
In-Reply-To: <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 4-10-2016 08:07, John Spray wrote:
> As Dan says, `ceph tell` is the new one, the one that sends commands
> directly from the CLI to the named service (not via the mon).
> However, this is a bit of a placeholder, as we'll eventually be
> switching to some commands (especially PG stats ones) to silently go
> to the mgr instead of the mon.  There are various ways of
> accomplishing that, the simplest one is to have the CLI fetch both mgr
> and mon command descriptions, and preferentially send commands to
> matching entries from the mgr.

ATM I had to disable building MGR, because Clang/Python/FreeBSD throw a
fit when having to compile on of the python files...
Something to do with function-signatures not matching.
I'll look into it after I've completed most of my other blocking
problems. Unless you'd really want to have the compiler errors now, I'll
fireup a build with MGR on.

Just hope that this switch is not enforced before that...
And I'd then expect the WITH_MGR flag to go away?

--WjW

