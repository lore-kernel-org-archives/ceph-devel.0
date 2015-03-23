From: =?gb2312?B?0c/V/Q==?= <zyan@redhat.com>
Subject: Re: [PATCH 1/1] ceph: properly release page upon error
Date: Mon, 23 Mar 2015 11:37:16 +0800
Message-ID: <A82D428E-B9FD-4D1D-A3F5-B4003CF941BD@redhat.com>
References: <1426887416-27312-1-git-send-email-tsgatesv@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426887416-27312-1-git-send-email-tsgatesv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taesoo Kim <tsgatesv@gmail.com>
Cc: sage@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org, taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, csong84@gatech.edu
List-Id: ceph-devel.vger.kernel.org


> =D4=DA 2015=C4=EA3=D4=C221=C8=D5=A3=AC05:36=A3=ACTaesoo Kim <tsgatesv=
@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> When ceph_update_writeable_page fails (including -EAGAIN), it
> unlocks (w/ unlock_page) the page but does not 'release'
> (w/ page_cache_release) properly.
>=20
> Upon error, properly set *pagep to NULL, indicating an error.
>=20
> Signed-off-by: Taesoo Kim <tsgatesv@gmail.com>
> ---
> fs/ceph/addr.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index fd5599d..89091e3 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1146,6 +1146,10 @@ static int ceph_write_begin(struct file *file,=
 struct address_space *mapping,
> 		     inode, page, (int)pos, (int)len);
>=20
> 		r =3D ceph_update_writeable_page(file, pos, len, page);
> +		if (r) {
> +			page_cache_release(page);
> +			*pagep =3D NULL;
> +		}
> 	} while (r =3D=3D -EAGAIN);
>=20
> 	return r;
> --=20

Added to our testing branch. Thank you

Yan, Zheng
>=20
