From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 4.6-rc1
Date: Sat, 26 Mar 2016 23:30:42 +0100
Message-ID: <CAOi1vP9J5Arg6+HtUE5vi7BtBFKN3frepzMDjOkzXoRgFVmcHQ@mail.gmail.com>
References: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
	<CA+55aFyXACVwL6inthTv=Orvp_6wDaA1c_BLvwJTYBORQTXa+w@mail.gmail.com>
	<CAOi1vP_6RX8ZxZNfU2__FkfcOcgT49spHjWn8aGTOArRRNXpew@mail.gmail.com>
	<CA+55aFyrep8hMApzYA4DyFgEoHc8o8KATTV=Jqf6-FgtLsqFOQ@mail.gmail.com>
	<CAOi1vP-=j49SgV3cSGq2z4LijkcaD13nT98PynXL2Y8MRy0puw@mail.gmail.com>
	<CA+55aFzwKpeuBLS5j+jyp_Zoh89edopgQNaC6GHBsx95Hza81A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36556 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbcCZWap (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Mar 2016 18:30:45 -0400
In-Reply-To: <CA+55aFzwKpeuBLS5j+jyp_Zoh89edopgQNaC6GHBsx95Hza81A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sage@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Mar 26, 2016 at 11:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Mar 26, 2016 at 2:46 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> FWIW, it matches -next content-wise.  SHAs don't match because of an
>> extra Signed-off-by in an unrelated commit, outside of fs/ceph.
>
> That's how git works. After you rebase, SHA's will *never* match,
> because you changed the history (dates, parenthood etc).
>
> The whole "it matches content-wise" is immaterial. You rebased and now
> I can see that it's not what was in next. It's really that simple.
>
> Just as an example of what rebasing does: it means that when I look at
> "ok, what is in next but not in my tree yet" to see what might be
> pending, the rebased commits don't cancel out, because they are
> different commits.
>
> Yes, yes, I've been lax about this. I have been ranting against people
> rebasing for years, but in the end I've usually let it slide.
>
> But dammit, when things come in at the very end of the merge window,
> which makes me grumpy to begin with, AND it is then re-based, at that
> point I'm not inclined to let things slide any more.
>
> At that point you guys are actively working to piss me off, and that
> means that I'm not in the least in the mood of pulling your work.
>
> Why *was* the pull request sent at the very end of the merge window
> anyway?  Was the code not ready?

A couple of commits were taken out and new integration snapshot was
made, based on Al's merge.  After it went through the usual test cycle,
I didn't think things through and it ended up being the pull request.

>
> So let me say again: keep your *own* tree in good shape.
>
> That's actually the only really valid reason for rebasing: if your
> *own* tree has something horribly bad going on, like majorly messed up
> commit messages, or history that is completely broken and will cause
> problems for people who want to bisect bugs, or things like that. Then
> "git rebase" is a perfectly good thing to fix bad things that are in
> _your_ tree.
>
> But no, git rebase is not a "let's react to random things that
> happened in other peoples trees". At that point you're worrying about
> entirely the wrong thing.

I get your argument.

Thanks,

                Ilya
