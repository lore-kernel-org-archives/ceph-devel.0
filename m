From: Ravi Pinjala <pstatic@gmail.com>
Subject: Re: [ceph-commit] can't read the superblock
Date: Mon, 17 Jan 2011 20:15:05 -0800
Message-ID: <AANLkTikCwq-9bv=ktKaPX5hBvdu+YmZJf7Z7jfG4DTrV@mail.gmail.com>
References: <201101151157560394466@gmail.com>
	<AANLkTinQbvvij5xAojnBHCq+9B-hqp4L2Ci_BRG+Kfdp@mail.gmail.com>
	<AANLkTimaKfZVhP375+7RVBs+AMjNjCSiQ6GbT_p9TW+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52458 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab1AREPH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jan 2011 23:15:07 -0500
Received: by bwz15 with SMTP id 15so3021189bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jan 2011 20:15:06 -0800 (PST)
In-Reply-To: <AANLkTimaKfZVhP375+7RVBs+AMjNjCSiQ6GbT_p9TW+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's a pretty generic error message - that's what I got when my cmds
was crashing. I think it happens if you can't connect to cmds for some
reason, or if the mds isn't responding.

--Ravi

On Mon, Jan 17, 2011 at 10:13 AM, Brian Chrisman <brchrisman@gmail.com>=
 wrote:
> Make sure IP tables are turned off.
> What you've said here isn't really sufficient to isolate the cause,
> but that's an error message I received while leaving stock firewall
> on.
>
> On Mon, Jan 17, 2011 at 10:09 AM, Gregory Farnum <gregf@hq.newdream.n=
et> wrote:
>> Forwarding this to ceph-devel rather than ceph-commit.
>>
>> As for your issues, there are many possibilities. It would be easier
>> to help you if you could provide more information about what your
>> system looks like and what steps you've taken to set it up.
>>
>> On Fri, Jan 14, 2011 at 7:57 PM, Qian Wei <hzqianwei@gmail.com> wrot=
e:
>>> Thanks for your advice, I have resolve the problem of "keyring.bin"=
, and I
>>> finish the process of "install". But, now the client still can't mo=
unt the
>>> system, the error message is "can't=C2=A0read=C2=A0the=C2=A0superbl=
ock=C2=A0".Moreover, I can
>>> use "init-ceph" command to start the system,and the=C2=A0 "cosd cmo=
n cmds" is on
>>> process table(so I think the system is running), but I can't=C2=A0 =
use =E2=80=9Cceph=E2=80=9D
>>> command to administrate the system,
>>> =E2=80=9C2011-01-13=C2=A013:27:05.800552=C2=A0b5f41b70=C2=A0--=C2=A0=
:/4555=C2=A0>>=C2=A0192.168.178.160:0/0=C2=A0pipe(0x8429c48=C2=A0sd=3D3=
=C2=A0pgs=3D0=C2=A0cs=3D0=C2=A0l=3D0).fault=C2=A0first=C2=A0fault
>>> =E2=80=9D is the error message.Do you know what's wrong may cause t=
hese problems?
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Thank you !!!
>>>
>>> 2011-01-15
>>> ________________________________
>>> Qian Wei
>>> _______________________________________________
>>> Ceph-commit mailing list
>>> Ceph-commit@lists.ceph.newdream.net
>>> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdre=
am.net
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
