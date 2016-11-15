From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: drivers/block/rbd.c:838: bad if expression ?
Date: Tue, 15 Nov 2016 14:07:52 +0100
Message-ID: <CAOi1vP_R8_1_WT+NSr+nanXf_O-8gvijDgB6f04zH+VYj_rs0w@mail.gmail.com>
References: <VI1PR08MB1022C985BAEC457437FABBF69CBF0@VI1PR08MB1022.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR08MB1022C985BAEC457437FABBF69CBF0@VI1PR08MB1022.eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 15, 2016 at 11:38 AM, David Binderman <dcb314@hotmail.com> wrot=
e:
> Hello there,
>
> drivers/block/rbd.c:838:34: warning: logical =E2=80=98and=E2=80=99 of mut=
ually exclusive tests is always false [-Wlogical-op]
>
> Source code is
>
>    } else if (token > Opt_last_int && token < Opt_last_string) {
>
> but
>
> enum {
>     Opt_queue_depth,
>     Opt_last_int,
>     /* int args above */
>     Opt_last_string,

Hi David,

It's just a placeholder for any string options that might be added in
the future.  See opt_tokens definition in net/ceph/ceph_common.c for an
example (fsid, secret, etc).

Thanks,

                Ilya
