From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 5.5-rc1
Date: Thu, 5 Dec 2019 13:19:14 -0800
Message-ID: <CAHk-=wjm+9rJvh=aRahfoN7z6waV87Eqr=-i_Cb7zOwHrugf5A@mail.gmail.com>
References: <20191204200307.21047-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204200307.21047-1-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Dec 4, 2019 at 12:02 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Colin Ian King (1):
>       rbd: fix spelling mistake "requeueing" -> "requeuing"

Hmm. Why? That's not a spelling mistake, it's the same word.

Arguably "requeue" isn't much of a real word to begin with, and is
more of a made-up tech language. And then on wiktionary apparently the
only "ing" form you find is the one without the final "e", but
honestly, that's reaching. The word doesn't exist in _real_
dictionaries at all.

I suspect "re-queueing" with the explicit hyphen would be the more
legible spelling (with or without the "e" - both forms are as
correct), but whatever.

I've pulled it, but I really don't think it was misspelled to begin
with, and somebody who actually cares about language probably wouldn't
like either form.

              Linus
