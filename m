From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Sun, 28 Apr 2019 12:18:00 -0400
Message-ID: <c570c901c850b6308bc78fcc6c7308f0bc491cb1.camel@kernel.org>
References: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
         <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
         <20190426165055.GY2217@ZenIV.linux.org.uk>
         <b175faae4bb98d3379a8642fe5f4e00587c3a734.camel@kernel.org>
         <20190428043801.GE2217@ZenIV.linux.org.uk>
         <7bac7ba5655a8e783a70f915853a0846e7ff143b.camel@kernel.org>
         <20190428144850.GA23075@ZenIV.linux.org.uk>
         <b875fdb47e17ab68d18c5e5e5cbd0ec70fec7ce9.camel@kernel.org>
         <20190428155216.GB23075@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190428155216.GB23075@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-cifs <linux-cifs@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, 2019-04-28 at 16:52 +0100, Al Viro wrote:
> On Sun, Apr 28, 2019 at 11:47:58AM -0400, Jeff Layton wrote:
> 
> > We could stick that in ceph_dentry_info (->d_fsdata). We have a flags
> > field in there already.
> 
> Yes, but...  You have it freed in ->d_release(), AFAICS, and without
> any delays.  So lockless accesses will be trouble.

That's easy enough to fix -- we could add a rcu_head to it and call_rcu
in ceph_d_release instead of just freeing it immediately.

I guess if we find that d_fsdata is NULL, we can just treat it like we
currently do a negative dentry?
-- 
Jeff Layton <jlayton@kernel.org>
