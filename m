From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 4.6-rc1
Date: Sat, 26 Mar 2016 22:19:22 +0100
Message-ID: <CAOi1vP_6RX8ZxZNfU2__FkfcOcgT49spHjWn8aGTOArRRNXpew@mail.gmail.com>
References: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
	<CA+55aFyXACVwL6inthTv=Orvp_6wDaA1c_BLvwJTYBORQTXa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34128 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbcCZVTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Mar 2016 17:19:24 -0400
In-Reply-To: <CA+55aFyXACVwL6inthTv=Orvp_6wDaA1c_BLvwJTYBORQTXa+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sage@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Mar 26, 2016 at 7:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 25, 2016 at 6:39 PM, Sage Weil <sage@redhat.com> wrote:
>>
>> This series is based on a recent merge of Al's tree to avoid conflicts
>> with his splice_dentry changes.
>
> Once again, and with feeling: please PLEASE stop doing these idiotic things.
>
> You should worry about *your* code. Don't worry about my merge. Don't
> worry about other trees. Make sure YOUR code is well-tested and
> stable, and make sure there is absolutely nothing questionable there.
>
> This whole idiotic "let's rebase on top of something else because of a
> tiny conflict" is a disease.
>
> I'm simply not pulling this. If you insist on sending me branches that
> have been rebased in the last day, then I will insist on just waiting
> for the next merge window.

Hi Linus,

I've seen the f2fs showdown, but this one is nothing like that.  If you
look at Al's merge this is rebased on, it's a week old and we've run
the whole thing though our test suite more than once.

>
> It really is that simple.
>
> This pull request came in very late in the merge window, and the code
> clearly has had almost zero actual testing since it was recently
> rebased.

The commit f7380af04bac "ceph: don't bother with d_rehash() in
splice_dentry()" has been sitting in our integration branch since
around -rc7.  The problem is Al took a *standalone* fs/ceph commit
through his tree.

>
> The fact that it avoids a merge conflict is not worth it.
>
> Stop doing this idiotic crazy thing. How many times do I have to tell
> people? When  you rebase, you are throwing your old testing away, and
> you're also making me get new commits that are different from the
> linux-next commits.
>
> I'm not AT ALL interested in getting newly minted untested crap the
> last day of the merge window.

None of the testing has been thrown out.  In fact, we always test
a rebased branch before sending the pull request to avoid post -rc1
breakages.  A pull request based on a 4.5 tag would have been less
tested...

This really is a result of a miscommunication between us and Al.
Lesson learned.  Please reconsider and pull.

Thanks,

                Ilya
