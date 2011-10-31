From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ping_pong test of ceph
Date: Sun, 30 Oct 2011 21:07:41 -0700
Message-ID: <CAF3hT9A=vDB85SC5QXHceN0zkvCY0Oe+yqaysjuHuB+bVodPxw@mail.gmail.com>
References: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
	<CAF3hT9BEhwGVeiud0fDmBscB2KKc1uAJxvAEGQZ2KAW6pWOhTg@mail.gmail.com>
	<CAMwsgzNkgd0gYf_LNELWfB8Fd5e7HP0v=R8wgAOG8jkEXUxG9A@mail.gmail.com>
	<CAF3hT9CkNdi4UFgAPhqy9xzk8s_7Tz6bqG5aTW3k87oxfEEt7g@mail.gmail.com>
	<CAMwsgzM5O1Xx+5WdufJdSUj1g500X36D0mtJizWF+aOSg4vr_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40902 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1JaEHm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 00:07:42 -0400
Received: by iaby12 with SMTP id y12so6731042iab.19
        for <ceph-devel@vger.kernel.org>; Sun, 30 Oct 2011 21:07:42 -0700 (PDT)
In-Reply-To: <CAMwsgzM5O1Xx+5WdufJdSUj1g500X36D0mtJizWF+aOSg4vr_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Not unless you want to hack the code to remove its flock
implementation. I'm not sure why you'd want to, though -- flock is
unlikely to be in the critical path for applications.
(If it is important, you can also use the userspace client -- unlike
the kernel client, it doesn't yet implement distributed flock.)

On Sun, Oct 30, 2011 at 7:18 PM, mowang da <whooya.xxl@gmail.com> wrote=
:
> thanks , if there is only one client, can we use local flock to
> replace flock mds?
>
> 2011/10/31 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> On Sun, Oct 30, 2011 at 6:21 PM, mowang da <whooya.xxl@gmail.com> wr=
ote:
>>> hi all,
>>> this bug has been fixed yet? i can't find any information of it.
>>> thanks for your help.
>>
>> Yes, it was fixed a while ago in our master branch and is fixed in o=
ur
>> last couple of releases. (Our newest is v0.37.)
>> As the problem was in the MDS server, to see this fix you only need =
to
>> upgrade the userspace packages. :)
>> -Greg
>>
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
