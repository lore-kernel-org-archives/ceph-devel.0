From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: max rbd devices
Date: Tue, 28 Jul 2015 11:08:21 -0400
Message-ID: <CAGbvivLZ_4EZE=cC1UY_skPP3r7zke+=cgfGTTx4o_Rhq8A2Ww@mail.gmail.com>
References: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
	<CAOi1vP80S138HcbSb-CXYQoa2-r-z=LDHB5iEVsmNohzGCn=Ug@mail.gmail.com>
	<CAGbvivKR6yJLVBMbigwhsf5hnf4H_GYp-vJyYVSEausTC7dS+A@mail.gmail.com>
	<CAOi1vP9VShh6CBmqbOV4naiQ6uCcs=ZgUhcSNhpztmyyYEn5TQ@mail.gmail.com>
	<CAGbvivKmDzqu-+6BUpg7mFU5z0H=ShXzqqcNAnRFEna2wbMCag@mail.gmail.com>
	<CAOi1vP9P2-abVw16_vLMd51Emta+PBUz3ee0KBm+o9-BeAGb2g@mail.gmail.com>
	<CAGbviv+UR4c+6me6-ycB49WZhW4_uHjCgfcH7G77e6OmM5c2-A@mail.gmail.com>
	<CAOi1vP-Qyy8fraQP=EJtxyw7=NvK=Cey_cu7McxYN9Nr4ad2UA@mail.gmail.com>
	<CAGbviv+tHJyF0mqeegXzE_q6k6EAhvB_FK2GgUHXpQWzJLnf4Q@mail.gmail.com>
	<CAGbvivLQS3PsJycQD=kpM1_Zo-te1sCFZjdGa_evdznybaHtSA@mail.gmail.com>
	<CAOi1vP8FhX1TMbnax3n5cjx2HZC+q34EXbq-W0=4fruGVBwKWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33170 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbbG1PIY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 11:08:24 -0400
Received: by igbpg9 with SMTP id pg9so140846047igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 08:08:23 -0700 (PDT)
In-Reply-To: <CAOi1vP8FhX1TMbnax3n5cjx2HZC+q34EXbq-W0=4fruGVBwKWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yup, thats the issue.  We have some automated configuration stuff that
added that line, I'll either remove it or add the "single_major=Y" to
it.

Either way, thanks for the help.



On Tue, Jul 28, 2015 at 11:06 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 5:59 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> Interesting to note - /etc/modules contains a line for rbd, which
>> means it gets loaded at boot time and NOT via the rbd cli, so perhaps
>> this is why it is loaded with the flag set to "N".
>
> Yeah, that's probably it - try removing it and reboot.
>
> Thanks,
>
>                 Ilya
