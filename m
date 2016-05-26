From: Sage Weil <sweil@redhat.com>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 17:46:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605261718560.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com> <CA+55aFx=v0SYBURwJbFNdPW0nGpzJrVO2b0BcqJEonZedizm2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx=v0SYBURwJbFNdPW0nGpzJrVO2b0BcqJEonZedizm2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 26 May 2016, Linus Torvalds wrote:
> On Thu, May 26, 2016 at 11:31 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Pulled and then immediately unpulled again.
> 
> .. and having thought it over, I ended up re-pulling again, so now
> it's going through my build test.
> 
> Consider this discussion a strong encouragement to *not* do this in
> the future - sending me pull requests at the end of the merge window
> without them having been in linux-next is a no-no, unless those pull
> requests are small and trivial (or have fixes that I'd pull even
> outside the merge window, of course).

Thank you!  We'll be sure we include things in -next well beforehand next 
time around, especially if it's a big diff like this one.

One point of clarification, though: in the past I've squashed down fixes 
discovered during testing if the branch hasn't hit a stable tree yet 
(e.g., your tree).  AIUI this is(was?) standard procedure for things in 
-next.  Do you want us to avoid squashing if we are creeping up on pull 
request time, or are you primarily interested in, say, seeing that what 
has been in -next for a while is substantially the same as what you pull, 
and has perhaps been there unmodified for at least a few days?  Or would 
you rather see fixup patches if we identify issues in the last few days of 
testing?

Thanks-
sage
