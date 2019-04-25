From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 11:24:53 -0700
Message-ID: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <20190425182100.GU2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425182100.GU2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 25, 2019 at 11:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
> ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
> over that, but what does it protect against?  Sure, you'll get
> something that was valid while you held ->d_lock, but what good
> does it do to the callers?  If they really have to care about
> races with d_move(), which value do they want?

I suspect they only care that the data they gather for the network
packet is coherent, and passes internal sanity tests. You get either
old or new, but at least you don't get "not NUL terminated because the
length didn't match the data".

                    Linus
