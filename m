From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ceph: fix spelling mistake: "resgister" -> "register"
Date: Thu, 23 Jun 2016 09:01:11 -0700
Message-ID: <1466697671.1847.5.camel@perches.com>
References: <1466689524-1836-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466689524-1836-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, zyan@redhat.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2016-06-23 at 14:45 +0100, Colin King wrote:
> trivial fix to spelling mistake in pr_err message
[]
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
[]
> @@ -71,7 +71,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client*=
 fsc)
> =A0					=A0=A0=A0=A0=A0=A0&ceph_fscache_fsid_object_def,
> =A0					=A0=A0=A0=A0=A0=A0fsc, true);
> =A0	if (!fsc->fscache)
> -		pr_err("Unable to resgister fsid: %p fscache cookie", fsc);
> +		pr_err("Unable to register fsid: %p fscache cookie", fsc);

Could change to "cookie\n" to avoid possible interleaving
from other messages too.
