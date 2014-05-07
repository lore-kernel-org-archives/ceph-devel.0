From: tuxoko <tuxoko@gmail.com>
Subject: Re: [PATCH] ceph: fix corruption when using page_count 0 page in
 rbd
Date: Wed, 07 May 2014 12:16:50 +0800
Message-ID: <5369B3B2.3070108@gmail.com>
References: <1398227709-4926-1-git-send-email-tuxoko@gmail.com>	<CALFYKtBovU83Y5WDsYq1Kzi6=QtHPKuefxJ5Ej5bdFdVADCNzQ@mail.gmail.com>	<alpine.DEB.2.00.1405060930450.26929@cobra.newdream.net> <CALFYKtDEobYdZDRxoSLHK-EQWa04S+rut8wOKWvf3_jT_HWrvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALFYKtDEobYdZDRxoSLHK-EQWa04S+rut8wOKWvf3_jT_HWrvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org



On =E8=A5=BF=E5=85=832014=E5=B9=B405=E6=9C=8807=E6=97=A5 00:34, Ilya Dr=
yomov wrote:
> On Tue, May 6, 2014 at 8:31 PM, Sage Weil <sage@inktank.com> wrote:
>> On Tue, 6 May 2014, Ilya Dryomov wrote:
>>>
>>> Looks good to me.  Have you tested it with pre "Fix crash when usin=
g
>>> ZFS on Ceph rbd" ZFS?
>>
>> Once this looks ready, we should perhaps stick it in for-linus so th=
at it
>> can go into 3.15.
>=20
> That's the plan, I just wanted to confirm it's been tested, since ZFS
> folks went ahead and fixed it by using compound pages.
>=20
> Thanks,
>=20
>                 Ilya
>=20

Hi Ilya

Yes, I've tested before the ZFS fix and it worked for me.

Thanks,
Chunwei Chen
