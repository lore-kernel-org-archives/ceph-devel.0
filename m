From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: max rbd devices
Date: Tue, 28 Jul 2015 10:46:02 -0400
Message-ID: <CAGbviv+tHJyF0mqeegXzE_q6k6EAhvB_FK2GgUHXpQWzJLnf4Q@mail.gmail.com>
References: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
	<CAOi1vP80S138HcbSb-CXYQoa2-r-z=LDHB5iEVsmNohzGCn=Ug@mail.gmail.com>
	<CAGbvivKR6yJLVBMbigwhsf5hnf4H_GYp-vJyYVSEausTC7dS+A@mail.gmail.com>
	<CAOi1vP9VShh6CBmqbOV4naiQ6uCcs=ZgUhcSNhpztmyyYEn5TQ@mail.gmail.com>
	<CAGbvivKmDzqu-+6BUpg7mFU5z0H=ShXzqqcNAnRFEna2wbMCag@mail.gmail.com>
	<CAOi1vP9P2-abVw16_vLMd51Emta+PBUz3ee0KBm+o9-BeAGb2g@mail.gmail.com>
	<CAGbviv+UR4c+6me6-ycB49WZhW4_uHjCgfcH7G77e6OmM5c2-A@mail.gmail.com>
	<CAOi1vP-Qyy8fraQP=EJtxyw7=NvK=Cey_cu7McxYN9Nr4ad2UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35416 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbbG1OqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 10:46:03 -0400
Received: by igr7 with SMTP id 7so119559063igr.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 07:46:02 -0700 (PDT)
In-Reply-To: <CAOi1vP-Qyy8fraQP=EJtxyw7=NvK=Cey_cu7McxYN9Nr4ad2UA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

 $ cat /sys/module/rbd/parameters/single_major
N

On Tue, Jul 28, 2015 at 10:44 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 5:35 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> OK, I misunderstood. It is not loaded by hand. We have permanent
>> mappings listed in /etc/ceph/rbdmap which then get mapped
>> automatically when the system boots.  So, in that case, shouldn't
>> single_major=Y since it essentially is just calling "rbd map" from an
>> init script?
>
> Let's step back a second.  What is the output of
>
> $ cat /sys/module/rbd/parameters/single_major
>
> right now?
>
> Thanks,
>
>                 Ilya
