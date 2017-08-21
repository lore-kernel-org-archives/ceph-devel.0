From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 0/3] Ceph: Adjustments for some function implementations
Date: Mon, 21 Aug 2017 09:46:54 +0800
Message-ID: <621A6044-0445-42A4-AE39-E3E300833A7F@redhat.com>
References: <b05df66b-b8a7-ac63-989d-091efecf2ab8@users.sourceforge.net>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b05df66b-b8a7-ac63-989d-091efecf2ab8@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On 21 Aug 2017, at 02:37, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 20 Aug 2017 20:32:10 +0200
> 
> Three update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (3):
>  Delete an error message for a failed memory allocation in __get_or_create_frag()
>  Delete an unnecessary return statement in update_dentry_lease()
>  Adjust 36 checks for null pointers
> 
> fs/ceph/addr.c       |  2 +-
> fs/ceph/cache.c      |  2 +-
> fs/ceph/caps.c       |  4 ++--
> fs/ceph/debugfs.c    |  2 +-
> fs/ceph/file.c       |  2 +-
> fs/ceph/inode.c      | 14 +++++---------
> fs/ceph/mds_client.c | 22 +++++++++++-----------
> fs/ceph/mdsmap.c     |  6 +++---
> fs/ceph/super.c      | 18 +++++++++---------
> fs/ceph/xattr.c      |  8 ++++----
> 10 files changed, 38 insertions(+), 42 deletions(-)
> 
> — 

Whole series applied, thanks

Yan, Zheng

> 2.14.0
> 
