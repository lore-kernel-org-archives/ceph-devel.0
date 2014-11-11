From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: require cephx message signature by default
Date: Tue, 11 Nov 2014 16:49:19 +0400
Message-ID: <CALFYKtA7agWzo5h-LnQFpTvcd_d4RUsW8U2jwYDLTFb4+cpXLg@mail.gmail.com>
References: <1415695109-4698-1-git-send-email-zyan@redhat.com>
	<CALFYKtB7fHNDdW1UFecoq6O7DY=UEcAmGBLvw1NCv=nDTee5kQ@mail.gmail.com>
	<553E9F66-73DC-4BE2-A473-8DBEDCE0CA14@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50679 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaKKMtT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 07:49:19 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so8216523qcw.20
        for <ceph-devel@vger.kernel.org>; Tue, 11 Nov 2014 04:49:19 -0800 (PST)
In-Reply-To: <553E9F66-73DC-4BE2-A473-8DBEDCE0CA14@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 11, 2014 at 3:22 PM, =E4=B8=A5=E6=AD=A3 <zyan@redhat.com> w=
rote:
>
> =E5=9C=A8 2014=E5=B9=B411=E6=9C=8811=E6=97=A5=EF=BC=8C17:51=EF=BC=8CI=
lya Dryomov <ilya.dryomov@inktank.com> =E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 11, 2014 at 11:38 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
> include/linux/ceph/libceph.h |  1 +
> net/ceph/ceph_common.c       | 13 +++++++++++++
> 2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libcep=
h.h
> index d293f7e..8b11a79 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -29,6 +29,7 @@
> #define CEPH_OPT_NOSHARE          (1<<1) /* don't share client with o=
ther
> sbs */
> #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
> #define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
> +#define CEPH_OPT_NOMSGAUTH       (1<<4) /* not require cephx message
> signature */
>
> #define CEPH_OPT_DEFAULT   (0)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index d361a274..b22d82c 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -237,6 +237,8 @@ enum {
>        Opt_noshare,
>        Opt_crc,
>        Opt_nocrc,
> +       Opt_cephx_require_signature,
> +       Opt_cephx_require_no_signature,
> };
>
> static match_table_t opt_tokens =3D {
> @@ -255,6 +257,8 @@ static match_table_t opt_tokens =3D {
>        {Opt_noshare, "noshare"},
>        {Opt_crc, "crc"},
>        {Opt_nocrc, "nocrc"},
> +       {Opt_cephx_require_signature, "cephx_require_signature"},
> +       {Opt_cephx_require_no_signature, "cephx_require_no_signature"=
},
>
>
> Maybe "cephx_require_signatures", "nocephx_require_signatures" ?  It
> would (almost) match injectargs and be more in line with general moun=
t
> option conventions.
>
>
> nocephx_require_signature looks wired. I don=E2=80=99t like it. how a=
bout
> cephx_not_require_signaure.

=46irst, whatever we settle on should end with "_signatures", not
"_signature" because that's how it's spelled out in config_opts.h.

The second issue is how to express negation.  For mount options it's
conventional to have a "no" prepended.  Now, whether or not that "no"
should be separated with an underscore is debatable, mount(8) man page
has examples of both:

auto_da_alloc/noauto_da_alloc
block_validity/noblock_validity

hashed_relocation/no_unhashed_relocation
bulk_read/no_bulk_read

I'd personally go with the first option (i.e. no underscore), as it's
much more common.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
