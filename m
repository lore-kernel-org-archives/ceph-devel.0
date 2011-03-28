From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: The stability of OSD
Date: Mon, 28 Mar 2011 14:19:02 +0800
Message-ID: <AANLkTinNko9h-qkQ8PgpSrJ1aXn=OhUyrZR5tDAQZukK@mail.gmail.com>
References: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
	<Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63152 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1C1GTE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 02:19:04 -0400
Received: by bwz15 with SMTP id 15so2176184bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2011 23:19:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,
Thanks for your information and let me know at least my hardwares are O=
K...:)
I will upgrade my ceph version to the latest one and see what I can fin=
d.

By the way, could you tell me how to set "osd heartbeat grace" ?
Because I can't find how to do it in the ceph wiki.
Thanks!
--
Best Regards,
Sylar Shen

2011/3/28 Sage Weil <sage@newdream.net>:
> On Mon, 28 Mar 2011, Sylar Shen wrote:
>> Hi,
>> I set an environment of 20 servers which include 2 MDSs, 3 MONs and =
18
>> OSDes(3 monitors on 18 OSDes)
>> My version is 0.24.3 and OS is Fedora 14.
>> There's a problem when I was doing the writing tests.
>> Whether I was writing the data or not, some OSDes were randomly mark=
ed
>> down and out one by one after a period of time.
>> And when that happened, the whole performance soon got worse and wor=
se.
>> I checked the /var/log/ceph/osd.log but found nothing.
>> So I am curious that is there anyone who has the same problem with m=
e?
>> Or maybe it's just a problem of my hardware......><
>
> Hi Sylar,
>
> This is/was a known problem. =C2=A0There's a long thread from a coupl=
e weeks
> back with Jim Schutt debugging the issue. =C2=A0We've fixed a few dif=
ferent
> things that have significantly improved the situation, but the heartb=
eats
> are still failing from time to time.
>
> I suspect using a more recent release will be sufficient at your scal=
e,
> either 0.25.2 or the latest 'next' branch from git (there are autobui=
lt
> debs for that too). =C2=A0You can also increase the 'osd heartbeat gr=
ace' to
> make the system less sensitive to the transient hangs that are preven=
ting
> the heartbeats from going out.
>
> Please let us know what you find, either here or on #ceph.
>
> Thanks!
> sage
>
>
>
>



--=20
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
