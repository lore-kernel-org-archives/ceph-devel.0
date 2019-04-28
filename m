From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Sun, 28 Apr 2019 16:52:16 +0100
Message-ID: <20190428155216.GB23075@ZenIV.linux.org.uk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b875fdb47e17ab68d18c5e5e5cbd0ec70fec7ce9.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-cifs <linux-cifs@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, Apr 28, 2019 at 11:47:58AM -0400, Jeff Layton wrote:

> We could stick that in ceph_dentry_info (->d_fsdata). We have a flags
> field in there already.

Yes, but...  You have it freed in ->d_release(), AFAICS, and without
any delays.  So lockless accesses will be trouble.
