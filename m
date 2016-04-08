From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: cephx disable to enable cause kernel bug
Date: Fri, 8 Apr 2016 23:36:18 +0200
Message-ID: <CAOi1vP_zHkU+WA9W7D5MqMHmsnx9AgwSyX5a=ijdTQOqsQxjyA@mail.gmail.com>
References: <BLU436-SMTP13708EF493613240113CA7485910@phx.gbl>
	<CAOi1vP_XpyUDHWvh0TaxuQSHYmkTutEzucaikFEO3Q9K2-yx7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32969 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758975AbcDHVgU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 17:36:20 -0400
Received: by mail-lf0-f53.google.com with SMTP id e190so90547453lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 14:36:19 -0700 (PDT)
In-Reply-To: <CAOi1vP_XpyUDHWvh0TaxuQSHYmkTutEzucaikFEO3Q9K2-yx7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5byg5bmz?= <alan.zhang@linux.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Fri, Apr 8, 2016 at 9:09 PM, Ilya Dryomov <idryomov@gmail.com> wrote=
:
> On Fri, Apr 8, 2016 at 6:11 AM, =E5=BC=A0=E5=B9=B3 <alan.zhang@linux.=
com> wrote:
>> Hi,
>>
>> I change cephx  disable to enable, when restart ceph luster it will =
be cause some osd node host kernel panic.
>> Maybe it is a bug.
>
> Could you please provide the exact commands you used to "change cephx=
 disable
> to enable" and "restart ceph cluster"?

Come to think of it, I think I know what you did and roughly what the
bug is.  I'll fix it up, thanks for the report.

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
