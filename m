From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 19:16:54 -0700
Message-ID: <CA+55aFybKvJPwi4M0FWRe_MVc1NTSDX==23adSGRYFauAEnGYw@mail.gmail.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
	<CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
	<CA+55aFx=v0SYBURwJbFNdPW0nGpzJrVO2b0BcqJEonZedizm2A@mail.gmail.com>
	<alpine.DEB.2.11.1605261718560.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1605261718560.6221@cpach.fuggernut.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 26, 2016 at 2:46 PM, Sage Weil <sweil@redhat.com> wrote:
>
> One point of clarification, though: in the past I've squashed down fixes
> discovered during testing if the branch hasn't hit a stable tree yet
> (e.g., your tree).  AIUI this is(was?) standard procedure for things in
> -next.

Yes, rebasing with good reason is acceptable for branches that don't
have anybody else depend on them.

Adn the "good reason" ends up being a judgement call. If the merge
window hasn't even started yet, the "good" reason may not even be very
great, and might might be "oh, I screwed up the commit message, so
let's make the history look good".

If it's already inside the merge window, you should aim for having
increasingly higher barriers to rebasing your tree, and strive to
generally try to avoid it.

If it's about something mostly cosmetic and the merge windoe has
opened or is just about to, leave it be.

On the other hand, if it's really nasty problem and seriously will
hurt people who try to bisect - even if you have fixed the problem
then later in the history - you might choose to do it to not be in the
situation that people who use "git bisect" to find another bug will
then be left with data corruption or something like that because of a
major bug in the middle of the development history.

And in between those two extremes of "cosmetic" and "nasty data
corruption bug" there is obviously a graduation of issues. There can't
be any completely black-and-white rules.

But the corollary to that is that if you really had a major bug that
you feld had to be fixed not just at the tip, but going back, then you
then shouldn't immediately send the end result to me. Because you just
fixed something critical (by definition, if you chose to do it just
before you would have wanted to send to me), so now you need to retest
things.

So rebasing isn't some absolute wrong thing. Sometimes rebasing is
simply the right thing to do. For example, maybe I don't get the same
commits that were in -next, but I would have still seen that the code
was there.

              Linus
