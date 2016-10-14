From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: Fix uninitialized dentry pointer in ceph_real_mount()
Date: Fri, 14 Oct 2016 10:47:51 +0800
Message-ID: <CAAM7YAkuzcCB45Jx3nqQjyt3mUNmgYsq3cSG707ga_-mQ8ag8Q@mail.gmail.com>
References: <1476371737-2116-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476371737-2116-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zheng Yan <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Oct 13, 2016 at 11:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>     fs/ceph/super.c: In function =E2=80=98ceph_real_mount=E2=80=99:
>     fs/ceph/super.c:818: warning: =E2=80=98root=E2=80=99 may be used unin=
itialized in this function
>
> If s_root is already valid, dentry pointer root is never initialized,
> and returned by ceph_real_mount(). This will cause a crash later when
> the caller dereferences the pointer.
>
> Fix this by initializing root early.
>
> Fixes: ce2728aaa82bbeba ("ceph: avoid accessing / when mounting a subpath=
")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.
> ---
>  fs/ceph/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a29ffce981879d5f..794c5fd0e0cf5e45 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -821,7 +821,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs_=
client *fsc)
>         dout("mount start %p\n", fsc);
>         mutex_lock(&fsc->client->mount_mutex);
>
> -       if (!fsc->sb->s_root) {
> +       root =3D fsc->sb->s_root;
> +       if (!root) {
>                 const char *path;
>                 err =3D __ceph_open_session(fsc->client, started);
>                 if (err < 0)

For sb->s_root is not NULL case, we also need to increase sb->s_root's
reference count. I applied this patch and fixed it.

Regards
Yan, Zheng


> --
> 1.9.1
>
