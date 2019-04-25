From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 11:02:54 -0700
Message-ID: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425174739.27604-1-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 25, 2019 at 10:48 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> dentry name handling fixes from Jeff and a memory leak fix from Zheng.
> Both are old issues, marked for stable.

Hmm. You probably should have talked to Al about the dentry name
issue, because he'd most likely have pointed you towards our helper
function for exactly this thing:

    struct name_snapshot stable;

    take_dentry_name_snapshot(&stable, dentry);
    ... use stable.name ..
    release_dentry_name_snapshot(&stable);

which doesn't need any extra memory allocation outside of some fairly
limited stack allocation for the 'name_snapshot' itself, because it
knows about the dentry name rules, and

 - for inline names, it copies it under the d_lock into the fixed
DNAME_INLINE_LEN-sized buffer

 - for out-of-line names, it knows that the name allocation is stable
and ref-counted, and just increments the refcount and uses the
existing name pointer.

now, maybe you need to always do that name allocation anyway (looking
at the diff it looks like you often do that for other cases), so maybe
the name snapshot capability isn't all that useful for you and the
above wouldn't have helped, but I suspect you might not even have
realized that there was an option like this.

I've pulled this, but maybe Jeff wants to look at whether that
snapshotting model could have helped.

                       Linus
