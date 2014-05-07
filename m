From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: fix corruption when using page_count 0 page in rbd
Date: Wed, 7 May 2014 19:35:31 +0400
Message-ID: <CALFYKtBKqpZVvgdgp4gS4SNj6Gn-thAup_zTbQf--yyfaxSTXw@mail.gmail.com>
References: <1398227709-4926-1-git-send-email-tuxoko@gmail.com>
	<CALFYKtBovU83Y5WDsYq1Kzi6=QtHPKuefxJ5Ej5bdFdVADCNzQ@mail.gmail.com>
	<alpine.DEB.2.00.1405060930450.26929@cobra.newdream.net>
	<CALFYKtDEobYdZDRxoSLHK-EQWa04S+rut8wOKWvf3_jT_HWrvQ@mail.gmail.com>
	<5369B3B2.3070108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33715 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbaEGPfb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 11:35:31 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so1271877qcv.16
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 08:35:31 -0700 (PDT)
In-Reply-To: <5369B3B2.3070108@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tuxoko <tuxoko@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 7, 2014 at 8:16 AM, tuxoko <tuxoko@gmail.com> wrote:
>
>
> On =E8=A5=BF=E5=85=832014=E5=B9=B405=E6=9C=8807=E6=97=A5 00:34, Ilya =
Dryomov wrote:
>> On Tue, May 6, 2014 at 8:31 PM, Sage Weil <sage@inktank.com> wrote:
>>> On Tue, 6 May 2014, Ilya Dryomov wrote:
>>>>
>>>> Looks good to me.  Have you tested it with pre "Fix crash when usi=
ng
>>>> ZFS on Ceph rbd" ZFS?
>>>
>>> Once this looks ready, we should perhaps stick it in for-linus so t=
hat it
>>> can go into 3.15.
>>
>> That's the plan, I just wanted to confirm it's been tested, since ZF=
S
>> folks went ahead and fixed it by using compound pages.
>>
>> Thanks,
>>
>>                 Ilya
>>
>
> Hi Ilya
>
> Yes, I've tested before the ZFS fix and it worked for me.

Thanks, queued.

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
