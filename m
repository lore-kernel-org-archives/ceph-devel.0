From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Tue, 26 Jul 2016 20:11:25 +0200
Message-ID: <CAOi1vP-4ua0y=XAraG-wfGaj-5Y9tZ+XnExza3pt_oWceL-eGQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com>
 <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
 <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
 <CAOi1vP_7dHOVnxTHEhfYsiXQGvd+e8ecsPf10cg0s33Ry4Vt9Q@mail.gmail.com>
 <CAOi1vP_X=60SHQzJ4v2yZ4JypYgXm+r3GNHn0_7tZkRcte-v3w@mail.gmail.com> <CAE2NFgXj0PpX0uN6RGNuXquwkmBncr7KHANaSK6c8SAVTWUVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37539 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbcGZSL3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 14:11:29 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so28569870wmg.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2016 11:11:29 -0700 (PDT)
In-Reply-To: <CAE2NFgXj0PpX0uN6RGNuXquwkmBncr7KHANaSK6c8SAVTWUVLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McLean <patrickm@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Victor Payno <vpayno@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

On Tue, Jul 26, 2016 at 7:58 PM, Patrick McLean <patrickm@gaikai.com> wrote:
> Hi Ilya,
>
> We discovered this weekend that enabling lockdep in the kernel makes the
> issue go away. We are working on reproducing without lockdep, and isolating
> the issue in the OSD logs. We should be have OSD debug logs this week.

I'm going to need the "cat /sys/kernel/debug/ceph/*/osdc" output, the
osd log for the osd from that output, and the output of "echo w" and
"echo t" to /proc/sysrq-trigger.

Thanks,

                Ilya
