From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: [ceph-commit] can't read the superblock
Date: Mon, 17 Jan 2011 10:13:24 -0800
Message-ID: <AANLkTimaKfZVhP375+7RVBs+AMjNjCSiQ6GbT_p9TW+Q@mail.gmail.com>
References: <201101151157560394466@gmail.com>
	<AANLkTinQbvvij5xAojnBHCq+9B-hqp4L2Ci_BRG+Kfdp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51072 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1AQSNY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jan 2011 13:13:24 -0500
Received: by qyj19 with SMTP id 19so2206338qyj.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jan 2011 10:13:24 -0800 (PST)
In-Reply-To: <AANLkTinQbvvij5xAojnBHCq+9B-hqp4L2Ci_BRG+Kfdp@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Qian Wei <hzqianwei@gmail.com>, ceph-devel@vger.kernel.org

Make sure IP tables are turned off.
What you've said here isn't really sufficient to isolate the cause,
but that's an error message I received while leaving stock firewall
on.

On Mon, Jan 17, 2011 at 10:09 AM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> Forwarding this to ceph-devel rather than ceph-commit.
>
> As for your issues, there are many possibilities. It would be easier
> to help you if you could provide more information about what your
> system looks like and what steps you've taken to set it up.
>
> On Fri, Jan 14, 2011 at 7:57 PM, Qian Wei <hzqianwei@gmail.com> wrote=
:
>> Thanks for your advice, I have resolve the problem of "keyring.bin",=
 and I
>> finish the process of "install". But, now the client still can't mou=
nt the
>> system, the error message is "can't=A0read=A0the=A0superblock=A0".Mo=
reover, I can
>> use "init-ceph" command to start the system,and the=A0 "cosd cmon cm=
ds" is on
>> process table(so I think the system is running), but I can't=A0 use =
=93ceph=94
>> command to administrate the system,
>> =932011-01-13=A013:27:05.800552=A0b5f41b70=A0--=A0:/4555=A0>>=A0192.=
168.178.160:0/0=A0pipe(0x8429c48=A0sd=3D3=A0pgs=3D0=A0cs=3D0=A0l=3D0).f=
ault=A0first=A0fault
>> =94 is the error message.Do you know what's wrong may cause these pr=
oblems?
>> =A0=A0=A0=A0 Thank you !!!
>>
>> 2011-01-15
>> ________________________________
>> Qian Wei
>> _______________________________________________
>> Ceph-commit mailing list
>> Ceph-commit@lists.ceph.newdream.net
>> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdrea=
m.net
>>
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
