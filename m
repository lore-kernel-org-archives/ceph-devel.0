From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph fixes for 4.20-rc2
Date: Fri, 9 Nov 2018 16:31:18 -0600
Message-ID: <CAHk-=wjSArODWM+seBzUGRFgtfMWjorFsna_Ftb8XYW55fab0Q@mail.gmail.com>
References: <20181109164755.13100-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109164755.13100-1-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Nov 9, 2018 at 10:48 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Two CephFS fixes (copy_file_range and quota) and a small feature bit
> cleanup.

.. I'm doing a few final manual "pulled" ack emails just to let people
know that I'll be stopping them, because Konstantin's pr-tracker-bot
automation should now be in place if the message is cc'd to lkml.

NOTE! It's currently only lkml, afaik, so other people who don't cc
lkml for their pulls won't get the automation, but I also won't be
looking at "which lists were cc'd", so I won't be doing the manual
ones.

And if you want to use lkml but don't want to see the automated "it
has been merged" emails, there's opt-out too. I know some people hate
getting automated emails.

             Linus
