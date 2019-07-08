From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ceph: fix uninitialized return code
Date: Mon, 8 Jul 2019 07:50:03 -0700
Message-ID: <20190708145003.GB43693@archlinux-epyc>
References: <20190708134821.587398-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708134821.587398-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Luis Henriques <lhenriques@suse.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 08, 2019 at 03:48:08PM +0200, Arnd Bergmann wrote:
> clang points out a -Wsometimed-uninitized bug in the modified
> ceph_real_mount() function:
> 
> fs/ceph/super.c:850:6: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (!fsc->sb->s_root) {
>             ^~~~~~~~~~~~~~~~
> fs/ceph/super.c:885:9: note: uninitialized use occurs here
>         return err;
>                ^~~
> fs/ceph/super.c:850:2: note: remove the 'if' if its condition is always true
>         if (!fsc->sb->s_root) {
>         ^~~~~~~~~~~~~~~~~~~~~~
> fs/ceph/super.c:843:9: note: initialize the variable 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 
> Set it to zero if the condition is false.
> 
> Fixes: 108f95bfaa56 ("vfs: Convert ceph to use the new mount API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
