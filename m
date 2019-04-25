From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 14:36:53 -0400
Message-ID: <7c25c38a57a61f0603364e64956a8f54026c6e3f.camel@kernel.org>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <20190425182100.GU2217@ZenIV.linux.org.uk>
         <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2019-04-25 at 11:24 -0700, Linus Torvalds wrote:
> On Thu, Apr 25, 2019 at 11:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
> > ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
> > over that, but what does it protect against?  Sure, you'll get
> > something that was valid while you held ->d_lock, but what good
> > does it do to the callers?  If they really have to care about
> > races with d_move(), which value do they want?
> 
> I suspect they only care that the data they gather for the network
> packet is coherent, and passes internal sanity tests. You get either
> old or new, but at least you don't get "not NUL terminated because the
> length didn't match the data".
> 
>                     Linus

Right. My main concern was preventing oopses while iterating over
d_name.

The main use for this hash is to help determine to which MDS we should
direct the request. My understanding is that if we get it wrong, we'll
end up retrying the request and pick a different MDS, so it's not fatal
if we do race in this fashion.
-- 
Jeff Layton <jlayton@kernel.org>
