From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 19:21:00 +0100
Message-ID: <20190425182100.GU2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 25, 2019 at 11:02:54AM -0700, Linus Torvalds wrote:

> I've pulled this, but maybe Jeff wants to look at whether that
> snapshotting model could have helped.

I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
over that, but what does it protect against?  Sure, you'll get
something that was valid while you held ->d_lock, but what good
does it do to the callers?  If they really have to care about
races with d_move(), which value do they want?
