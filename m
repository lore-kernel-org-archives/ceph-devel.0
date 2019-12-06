From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.5-rc1
Date: Fri, 6 Dec 2019 12:05:01 +0100
Message-ID: <CAOi1vP_biwOVuG9U4nemfH803O_ADHGgjmd0_6eL-ZJhyrkOYA@mail.gmail.com>
References: <20191204200307.21047-1-idryomov@gmail.com> <CAHk-=wjm+9rJvh=aRahfoN7z6waV87Eqr=-i_Cb7zOwHrugf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjm+9rJvh=aRahfoN7z6waV87Eqr=-i_Cb7zOwHrugf5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Dec 5, 2019 at 10:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 4, 2019 at 12:02 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > Colin Ian King (1):
> >       rbd: fix spelling mistake "requeueing" -> "requeuing"
>
> Hmm. Why? That's not a spelling mistake, it's the same word.
>
> Arguably "requeue" isn't much of a real word to begin with, and is
> more of a made-up tech language. And then on wiktionary apparently the
> only "ing" form you find is the one without the final "e", but
> honestly, that's reaching. The word doesn't exist in _real_
> dictionaries at all.
>
> I suspect "re-queueing" with the explicit hyphen would be the more
> legible spelling (with or without the "e" - both forms are as
> correct), but whatever.
>
> I've pulled it, but I really don't think it was misspelled to begin
> with, and somebody who actually cares about language probably wouldn't
> like either form.

FWIW that was my spelling.  I suspected the same thing, saw it being
used in various spellings, but since Colin is a native speaker I took
the patch.

Thanks,

                Ilya
