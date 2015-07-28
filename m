From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: max rbd devices
Date: Tue, 28 Jul 2015 18:06:00 +0300
Message-ID: <CAOi1vP8FhX1TMbnax3n5cjx2HZC+q34EXbq-W0=4fruGVBwKWw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34294 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbbG1PGB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 11:06:01 -0400
Received: by wibud3 with SMTP id ud3so184990845wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 08:06:00 -0700 (PDT)
In-Reply-To: <CAGbvivLQS3PsJycQD=kpM1_Zo-te1sCFZjdGa_evdznybaHtSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 5:59 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Interesting to note - /etc/modules contains a line for rbd, which
> means it gets loaded at boot time and NOT via the rbd cli, so perhaps
> this is why it is loaded with the flag set to "N".

Yeah, that's probably it - try removing it and reboot.

Thanks,

                Ilya
