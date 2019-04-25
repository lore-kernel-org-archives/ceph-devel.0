From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 19:31:48 +0100
Message-ID: <20190425183148.GV2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <20190425182100.GU2217@ZenIV.linux.org.uk>
 <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 25, 2019 at 11:24:53AM -0700, Linus Torvalds wrote:

> I suspect they only care that the data they gather for the network
> packet is coherent, and passes internal sanity tests. You get either
> old or new, but at least you don't get "not NUL terminated because the
> length didn't match the data".

I'm not familiar enough with the protocol to tell if it's actually
OK; if anything, it's a question to ceph folks...
