From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v5] Ceph: Punch hole support for kernel client
Date: Tue, 27 Aug 2013 16:38:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308271637280.24783@cobra.newdream.net>
References: <1376538704-6659-1-git-send-email-liwang@ubuntukylin.com> <20130827163555.99ef8be3dacd5bd5eadcac8c@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130827163555.99ef8be3dacd5bd5eadcac8c@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Wang <liwang@ubuntukylin.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

On Tue, 27 Aug 2013, Andrew Morton wrote:
> On Thu, 15 Aug 2013 11:51:44 +0800 Li Wang <liwang@ubuntukylin.com> wrote:
> 
> > This patch implements fallocate and punch hole support for Ceph kernel client.
> 
> i386 allmodconfig:
> 
> ERROR: "__divdi3" [fs/ceph/ceph.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> 
> Due to a 64-bit divide in ceph_zero_objects()

Yep, fix is in the ceph-client.git master branch now and should get picked 
up by the next -next.

sage
