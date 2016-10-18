From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 11/28] block: rdb: false-postive gcc-4.9 -Wmaybe-uninitialized
Date: Tue, 18 Oct 2016 11:57:33 +0200
Message-ID: <CAOi1vP-N-Qp4_LU=MMoPp+wH5t+JoDxFsVgMa=65CBO=HTV_DA@mail.gmail.com>
References: <20161017220342.1627073-1-arnd@arndb.de> <20161017221037.1781185-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017221037.1781185-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Mike Christie <mchristi@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 18, 2016 at 12:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When building with gcc-4.9 -Wmaybe-uninitialized, we get a bogus
> warning in rbd_watch_cb, as the variable is not used at all
> in the one case in which it is not initialized first:
>
> drivers/block/rbd.c: In function =E2=80=98rbd_watch_cb=E2=80=99:
> drivers/block/rbd.c:3690:5: error: =E2=80=98struct_v=E2=80=99 may be used=
 uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> drivers/block/rbd.c:3759:5: note: =E2=80=98struct_v=E2=80=99 was declared=
 here
>
> Later compiler versions fix this, but adding another initialization
> here is harmless and lets us build cleanly with 4.9 as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rbd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index abb7162..4ab990b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3776,6 +3776,7 @@ static void rbd_watch_cb(void *arg, u64 notify_id, =
u64 cookie,
>         } else {
>                 /* legacy notification for header updates */
>                 notify_op =3D RBD_NOTIFY_OP_HEADER_UPDATE;
> +               struct_v =3D 0;
>                 len =3D 0;
>         }

It already got silenced by initializing at declaration in one of the
downstream trees, so I'd rather we do

@@ -3756,7 +3819,7 @@ static void rbd_watch_cb(void *arg, u64
notify_id, u64 cookie,
        struct rbd_device *rbd_dev =3D arg;
        void *p =3D data;
        void *const end =3D p + data_len;
-       u8 struct_v;
+       u8 struct_v =3D 0;
        u32 len;
        u32 notify_op;
        int ret;

to reduce the churn.

The "block" prefix is redundant and "rdb" should be "rbd" in the subject.

Thanks,

                Ilya
