From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.6-rc1
Date: Sat, 26 Mar 2016 11:30:12 -0700
Message-ID: <CA+55aFyXACVwL6inthTv=Orvp_6wDaA1c_BLvwJTYBORQTXa+w@mail.gmail.com>
References: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 25, 2016 at 6:39 PM, Sage Weil <sage@redhat.com> wrote:
>
> This series is based on a recent merge of Al's tree to avoid conflicts
> with his splice_dentry changes.

Once again, and with feeling: please PLEASE stop doing these idiotic things.

You should worry about *your* code. Don't worry about my merge. Don't
worry about other trees. Make sure YOUR code is well-tested and
stable, and make sure there is absolutely nothing questionable there.

This whole idiotic "let's rebase on top of something else because of a
tiny conflict" is a disease.

I'm simply not pulling this. If you insist on sending me branches that
have been rebased in the last day, then I will insist on just waiting
for the next merge window.

It really is that simple.

This pull request came in very late in the merge window, and the code
clearly has had almost zero actual testing since it was recently
rebased.

The fact that it avoids a merge conflict is not worth it.

Stop doing this idiotic crazy thing. How many times do I have to tell
people? When  you rebase, you are throwing your old testing away, and
you're also making me get new commits that are different from the
linux-next commits.

I'm not AT ALL interested in getting newly minted untested crap the
last day of the merge window.

Really.

                      Linus
