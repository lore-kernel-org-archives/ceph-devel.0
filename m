From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Fri, 26 Apr 2019 10:08:48 -0700
Message-ID: <CAHk-=wgm37dg541ok7pOjM-3ifM8tbsNDSBO79FP_n7T-gPuOQ@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk> <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com> <20190426170108.GZ2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426170108.GZ2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 26, 2019 at 10:01 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What I don't understand is why would anyone want to mess with
> name snapshots for dentry_path() lookalikes...

Talking about dentry_path()... Shouldn't the ceph path walking code
also check the mount_lock sequence to make sure the path is actually
stable?

Maybe it doesn't matter.

                  Linus
