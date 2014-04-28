From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] locks: ensure that fl_owner is always initialized
 properly in flock and lease codepaths
Date: Mon, 28 Apr 2014 11:15:24 -0700
Message-ID: <20140428181524.GA18775@kroah.com>
References: <1398707413-32384-1-git-send-email-jlayton@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1398707413-32384-1-git-send-email-jlayton@poochiereds.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Latchesar Ionkov <lucho@ionkov.net>, "J. Bruce Fields" <bfields@fieldses.org>, "open list:NFS, SUNRPC,
 AND..." <linux-nfs@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Sage Weil <sage@inktank.com>, Miklos Szeredi <miklos@szeredi.hu>, Eric Van Hensbergen <ericvh@gmail.com>, Trond Myklebust <trond.myklebust@primarydata.com>, open list <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "open list:FUSE: FILESYSTEM..." <fuse-devel@lists.sourceforge.net>, Alexander Viro <viro@zeniv.linux.org.uk>, "open list:9P FILE SYSTEM" <v9fs-developer@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>, "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>, "open list:AFS FILESYSTEM &..." <linux-afs@lists.infradead.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Apr 28, 2014 at 01:50:13PM -0400, Jeff Layton wrote:
> Currently, the fl_owner isn't set for flock locks. Some filesystems use
> byte-range locks to simulate flock locks and there is a common idiom in
> those that does:
> 
>     fl->fl_owner = (fl_owner_t)filp;
>     fl->fl_start = 0;
>     fl->fl_end = OFFSET_MAX;
> 
> Since flock locks are generally "owned" by the open file description,
> move this into the common flock lock setup code. The fl_start and fl_end
> fields are already set appropriately, so remove the unneeded setting of
> that in flock ops in those filesystems as well.
> 
> Finally, the lease code also sets the fl_owner as if they were owned by
> the process and not the open file description. This is incorrect as
> leases have the same ownership semantics as flock locks. Set them the
> same way. The lease code doesn't actually use the fl_owner value for
> anything, so this is more for consistency's sake than a bugfix.
> 
> Reported-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Jeff Layton <jlayton@poochiereds.net>
> ---
>  drivers/staging/lustre/lustre/llite/file.c | 17 ++++++-----------
>  fs/9p/vfs_file.c                           |  3 ---
>  fs/afs/flock.c                             |  4 ----
>  fs/ceph/locks.c                            | 10 ++--------
>  fs/fuse/file.c                             |  1 -
>  fs/locks.c                                 |  4 +++-
>  fs/nfs/file.c                              |  4 ----
>  7 files changed, 11 insertions(+), 32 deletions(-)

Staging portion:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
