From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: radosgw: shadow objects
Date: Fri, 30 Sep 2011 11:17:41 +0800
Message-ID: <CANExM-P2ZPSW4g2D59=0W4NSqdSZmF4Mt9H=GafbZvs5GTa+og@mail.gmail.com>
References: <CANExM-MPCAj9pzZUSciMrSxg+r=VJ9J9GUH88U-MvzDsyZJp7A@mail.gmail.com>
	<CAC-hyiHzFympqYkYgNvs+1UJ78588QCgMZje7P-340hirNEteA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57193 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1I3DRm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 23:17:42 -0400
Received: by iaqq3 with SMTP id q3so1350582iaq.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 20:17:41 -0700 (PDT)
In-Reply-To: <CAC-hyiHzFympqYkYgNvs+1UJ78588QCgMZje7P-340hirNEteA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I see the reason now, but is the "period" configurable?
Another question is: it seems the shadow object is to prevent racing
between concurrent r/w. Why do we need to keep those objects so long?

Henry

2011/9/30 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> Instead of removing the shadow objects, we add an intent entry to the
> intent log. This is done, so that an object read that happens while
> doing a write to the object can complete successfully, while returnin=
g
> the original object. A separate process then have to remove those
> entries, but only after a long period (e.g., a couple of days). The
> radosgw-admin utility can handle that.
>
> On Thu, Sep 29, 2011 at 9:14 AM, Henry C Chang <henry.cy.chang@gmail.=
com> wrote:
>> Hi,
>>
>> With radosgw, I noticed that after the actual objects are deleted, t=
he
>> shadow objects still remains. I am wondering when the shadow object
>> will be deleted. Is it a bug or on purpose?
>> My used data size keeps growing...
>>
>> Henry
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
