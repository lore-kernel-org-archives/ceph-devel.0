From: Leander Yu <leander.yu@gmail.com>
Subject: Re: Feature request: "max mon" setting
Date: Tue, 8 Nov 2011 05:03:14 +0800
Message-ID: <CAA9wQNdQNpNzx+JxTMQBkXqk+PveZa85Hnym9t11ce=es0O8zg@mail.gmail.com>
References: <201111031302.51236.a.ott@m-privacy.de>
	<CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
	<201111040912.14250.a.ott@m-privacy.de>
	<CAF3hT9AoUL63hZeiFXdXON1H8nE=mQTcuE7Tkam8M7gRF__TBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51902 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1KGVDO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 16:03:14 -0500
Received: by iage36 with SMTP id e36so6272204iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 13:03:14 -0800 (PST)
In-Reply-To: <CAF3hT9AoUL63hZeiFXdXON1H8nE=mQTcuE7Tkam8M7gRF__TBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Amon Ott <a.ott@m-privacy.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,
Will there be any performance impact if there are too many mons?

Regards,
Leander Yu.

On Sat, Nov 5, 2011 at 1:02 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Fri, Nov 4, 2011 at 1:12 AM, Amon Ott <a.ott@m-privacy.de> wrote:
>> I agree that our needs are special. We want to be able to start with=
 2 and
>> extend as customer needs grow, or start with 20 and shut some of the=
m down if
>> load gets low. I now understand that we should start with at least t=
hree
>> nodes.
> It's not so special a usage case, you're just thinking of it wrong.
> Adding a new daemon of each type for every physical box you add is th=
e
> wrong way to expand. You want to add OSDs for every box in order to
> take advantage of the storage; you CAN add an MDS for each box, but
> you should really be scaling them according to how much metadata
> activity you need to support; and the monitors need to be handled
> carefully in order to keep a strict majority of them alive at all
> times (and aside from durability the system doesn't much care about
> how many there are).
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
