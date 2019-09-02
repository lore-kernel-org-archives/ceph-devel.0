From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: Move static keyword to the front of declarations
Date: Mon, 2 Sep 2019 10:54:26 +0200
Message-ID: <CAOi1vP92Q==y7eta5oyhV4q1qjzsMqposGeWbY8rFCWFSpU9yg@mail.gmail.com>
References: <20190831215712.10148-1-kw@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831215712.10148-1-kw@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Wilczynski <kw@linux.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Aug 31, 2019 at 11:57 PM Krzysztof Wilczynski <kw@linux.com> wrote:
>
> Move the static keyword to the front of declarations of
> snap_handle_length, handle_length and connected_handle_length,
> and resolve the following compiler warnings that can be seen
> when building with warnings enabled (W=3D1):
>
> fs/ceph/export.c:38:2: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> fs/ceph/export.c:88:2: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> fs/ceph/export.c:90:2: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>
>  fs/ceph/export.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 020d39a85ecc..b6bfa94332c3 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -35,7 +35,7 @@ struct ceph_nfs_snapfh {
>  static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_=
len,
>                               struct inode *parent_inode)
>  {
> -       const static int snap_handle_length =3D
> +       static const int snap_handle_length =3D
>                 sizeof(struct ceph_nfs_snapfh) >> 2;
>         struct ceph_nfs_snapfh *sfh =3D (void *)rawfh;
>         u64 snapid =3D ceph_snap(inode);
> @@ -85,9 +85,9 @@ static int ceph_encode_snapfh(struct inode *inode, u32 =
*rawfh, int *max_len,
>  static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
>                           struct inode *parent_inode)
>  {
> -       const static int handle_length =3D
> +       static const int handle_length =3D
>                 sizeof(struct ceph_nfs_fh) >> 2;
> -       const static int connected_handle_length =3D
> +       static const int connected_handle_length =3D
>                 sizeof(struct ceph_nfs_confh) >> 2;
>         int type;

Applied.

Thanks,

                Ilya
