From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Thu, 30 Jan 2014 14:01:38 -0800
Message-ID: <CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
References: <CALFYKtDCNWK+9m5m3P01dcxOOV7iHFeNaOH=Q=6Pffuo8gmrMQ@mail.gmail.com>
	<1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
	<CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
	<20140130075421.GA10050@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140130075421.GA10050@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 29, 2014 at 11:54 PM, Christoph Hellwig <hch@infradead.org> wrote:
>
> For ->set_acl that's fairly easily doable and I actually had a version
> doing that to be able to convert 9p.  But for ->get_acl the path walking
> caller didn't seem easily feasible.  ->get_acl actually is an invention
> of yours, so if you got a good idea to get the dentry to it I'd love
> to be able to pass it.

Yeah, that's pretty annoying, largely because that path is also
RCU-walk aware, which does *not* need this all (because it will never
call down into the filesystem - if the acl isn't found in the cached
acl's, we just abort).

And we're going through that very common "generic_permission()" thing
that in turn is also often called from the low-level filesystens, and
it's all fairly tightly integrated with __inode_permission() etc.

In the end, all the original call-sites should have a dentry, and none
of this is "fundamental". But you're right, it looks like an absolute
nightmare to add the dentry pointer through the whole chain. Damn.

So I'm not thrilled about it, but maybe that "d_find_alias(inode)" to
find the dentry is good enough in practice. It feels very much
incorrect (it could find a dentry with a path that you cannot actually
access on the server, and result in user-visible errors), but I
definitely see your argument. It may just not be worth the pain for
this odd ceph case.

That said, if the ceph people decide to try to bite the bullet and do
the required conversions to pass the dentry to the permissions
functions, I think I'd take it unless it ends up being *too* horribly
messy.

               Linus
