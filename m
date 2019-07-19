From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/4] ceph: fix buffer free while holding i_ceph_lock in
 __ceph_setxattr()
Date: Sat, 20 Jul 2019 00:23:08 +0100
Message-ID: <20190719232307.GA17978@ZenIV.linux.org.uk>
References: <20190719143222.16058-1-lhenriques@suse.com>
 <20190719143222.16058-3-lhenriques@suse.com>
 <1dee14212043f12ef5b26e4aee0c3155e118abf3.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1dee14212043f12ef5b26e4aee0c3155e118abf3.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 19, 2019 at 07:07:49PM -0400, Jeff Layton wrote:

> Al pointed out on IRC that vfree should be callable under spinlock.

Al had been near-terminally low on caffeine at the time, posted
a retraction a few minutes later and went to grab some coffee...

> It
> only sleeps if !in_interrupt(), and I think that should return true if
> we're holding a spinlock.

It can be used from RCU callbacks and all such; it *can't* be used from
under spinlock - on non-preempt builds there's no way to recognize that.
