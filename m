From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Date: Mon, 26 Mar 2018 15:24:41 +0200
Message-ID: <CAOi1vP_qFkDK00-_KJpbrnC3PbP371=R4wxBH8gk2s47qwfrhg@mail.gmail.com>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
 <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
 <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
 <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com> <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?= <hitoshi.kamei.xm@hitachi.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 26, 2018 at 2:31 PM, =E4=BA=80=E4=BA=95=E4=BB=81=E5=BF=97 / KAM=
EI=EF=BC=8CHITOSHI
<hitoshi.kamei.xm@hitachi.com> wrote:
> Hi Ilya,
>
> I think your patch fully completes our purpose and I confirmed
> that the kernel with the patch could work well by testing in my environme=
nt.
>
> I added the notrim option to rbd map command in accordance with
> your kernel rbd driver patch, and I pushed the patch to GitHub
> (https://github.com/hitoshikamei/ceph/tree/rbdmap-notrim).

Change the man page text to say

* notrim - Turn off discard and write zeroes offload support to avoid
  deprovisioning a fully provisioned image (since 4.17).  When enabled, dis=
card
  requests will fail with -EOPNOTSUPP, write zeroes requests will fall back=
 to
  manually zeroing.

and merge it into the first patch.

>
> So, could you please merge your patch to the kernel? If your patch is mer=
ged,
> then my patch can work, so I will send the Pull Request.

https://github.com/ceph/ceph-client/commit/7ddd22f2dd1d82da9a4cc0c54dc10760=
a53964f0

You can open the PR right now, we just won't merge it until the
kernel patch is in.

Thanks,

                Ilya
