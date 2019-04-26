From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Fri, 26 Apr 2019 09:43:33 -0700
Message-ID: <CAHk-=wj2h5XWt1+NuVdiBPmzQMrZHxs6zLkKquU1OvpxBGNS7w@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk> <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 26, 2019 at 9:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 26, 2019 at 9:25 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > Is it really ok to union the count and rcu_head there?
>
> It should be fine, because the rcu_count should only ever be used once
                                     ^^^^^

that should be 'head' of course.

              Linus "duh" Torvalds
