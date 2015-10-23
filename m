From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Re: [PATCH] mark rbd requiring stable pages
Date: Fri, 23 Oct 2015 21:06:46 +0200
Message-ID: <CAOi1vP_wXm0OvuGSOEPJUgx49j31f9y1Lxwi5i_Pb0uVt3EB2w@mail.gmail.com>
References: <201510151850.48348.ronny.hegewald@online.de>
	<562860F2.8070208@cs.wisc.edu>
	<CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
	<201510222356.58184.ronny.hegewald@online.de>
	<CAOi1vP-nEmqUTR5ouMEfWiVY_zc2j6-Vf4T9u=eNa0erehmoxw@mail.gmail.com>
	<trinity-bd8d28a8-eb31-4d51-a40a-9cb6baa3d514-1445626837983@3capp-1and1-bs05>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32892 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbJWTGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 15:06:48 -0400
Received: by wijp11 with SMTP id p11so90430471wij.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 12:06:46 -0700 (PDT)
In-Reply-To: <trinity-bd8d28a8-eb31-4d51-a40a-9cb6baa3d514-1445626837983@3capp-1and1-bs05>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ronny.hegewald@online.de" <ronny.hegewald@online.de>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Fri, Oct 23, 2015 at 9:00 PM, ronny.hegewald@online.de
<ronny.hegewald@online.de> wrote:
>> Could you share the entire log snippet for those 10 minutes?
>
> Thats all in the logs.  But if more information would be useful tell me which logs
> to activate and i will give it another run. At least this part is easy to reproduce.
>
>> Which kernel was this on?
>
> The latest kernel i used which produced the corruption was 3.19.8.
> The earliest one was 3.11.

No need for now, I'll poke around and report back.

Thanks,

                Ilya
