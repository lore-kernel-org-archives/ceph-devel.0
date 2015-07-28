From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: max rbd devices
Date: Tue, 28 Jul 2015 14:58:38 +0300
Message-ID: <CAOi1vP9VShh6CBmqbOV4naiQ6uCcs=ZgUhcSNhpztmyyYEn5TQ@mail.gmail.com>
References: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
	<CAOi1vP80S138HcbSb-CXYQoa2-r-z=LDHB5iEVsmNohzGCn=Ug@mail.gmail.com>
	<CAGbvivKR6yJLVBMbigwhsf5hnf4H_GYp-vJyYVSEausTC7dS+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36741 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbG1L6j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 07:58:39 -0400
Received: by wicgb10 with SMTP id gb10so153157492wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 04:58:38 -0700 (PDT)
In-Reply-To: <CAGbvivKR6yJLVBMbigwhsf5hnf4H_GYp-vJyYVSEausTC7dS+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 2:55 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
>
> We are on 3.16 and Ceph 0.94.2, so I will try that parameter out and see how

In this case, rbd map should have loaded the module with single_major=Y
for you.  Did you by any chance load it by hand?

Thanks,

                Ilya
