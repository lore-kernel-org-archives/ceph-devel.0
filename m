From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Re: Re: thanks gregf,question about ceph
Date: Mon, 17 Jan 2011 22:18:38 -0800
Message-ID: <AANLkTimEbEw4pfjzQyZ9WHBRqocx+8WQ1g++mGEkP3vq@mail.gmail.com>
References: <1b70d2f.20f3.12d6a85a669.Coremail.yueluck@163.com>
	<AANLkTik4mLKZkdG21xgeJFHwi61jgrD+ABB9B-C0FrN9@mail.gmail.com>
	<d6ed3a.147e1.12d836b90b0.Coremail.yueluck@163.com>
	<AANLkTik2zL4B_fis6uCGLv5HDY13jaA9ZfFarTf85NEw@mail.gmail.com>
	<74db6f32.240b.12d87d91566.Coremail.yueluck@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42960 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1ARGSk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 01:18:40 -0500
Received: by eye27 with SMTP id 27so3029076eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jan 2011 22:18:39 -0800 (PST)
In-Reply-To: <74db6f32.240b.12d87d91566.Coremail.yueluck@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yueluck <yueluck@163.com>, ceph-devel@vger.kernel.org

Sorry I didn't get to this very quickly -- in future if you keep your
questions on the list, rather than to a single person, you will get
faster responses.

2011/1/14 yueluck <yueluck@163.com>:
> because ceph is not stable now, my xen-disk store on ceph.
> so=C2=A0 i can not use ceph in my product!!!
> you do not have much experence here? you are developper,i think?
Yes, I am a developer on Ceph. I have limited experience with other
storage systems, though, especially those targeted at Xen node
storage.

Beyond that, there isn't a single "best" solution to this kind of
problem. It depends a great deal on your individual needs, and I don't
know what they are except that you want to store images. So, I can
recommend that you *look at* RBD, which is a part of Ceph but
considerably less complicated (and more stable) than the Ceph
POSIX-compliant filesystem, and I can recommend that you *look at*
Sheepdog, which is designed precisely and only for storing VM images
(although I think it's focused on KVM). Determining which of these (or
other alternatives that I'm unaware of) is best for you is something
you have to do on your own. It will require a lot of work no matter
what solution you pick -- if it was an easy problem to solve, somebody
would have done so already.
-Greg

> i=C2=A0 am read source code=C2=A0depend on=C2=A0logs, know outline, b=
ut not details.
> do you=C2=A0read code ?
>
> -----------------------------------
> At=C2=A02011-01-15=C2=A001:18:56=EF=BC=8C"Gregory=C2=A0Farnum"=C2=A0<=
gregf@hq.newdream.net>=C2=A0wrote:
>
>>I=C2=A0don't=C2=A0have=C2=A0much=C2=A0experience=C2=A0here,=C2=A0but=C2=
=A0if=C2=A0Ceph's=C2=A0own=C2=A0RBD=C2=A0doesn't
>>satisfy=C2=A0your=C2=A0needs=C2=A0I=C2=A0guess=C2=A0I'd=C2=A0look=C2=A0=
at=C2=A0Sheepdog.
>>
>>2011/1/13=C2=A0yueluck=C2=A0<yueluck@163.com>:
>>>=C2=A0can=C2=A0you=C2=A0Recommend=C2=A0me=C2=A0other=C2=A0dfs,like=C2=
=A0ceph.=C2=A0you=C2=A0know=C2=A0or=C2=A0have=C2=A0experence=C2=A0on=C2=
=A0it.
>>>=C2=A0i=C2=A0will=C2=A0store=C2=A0xen-disk=C2=A0on=C2=A0it.=C2=A0=C2=
=A0=C2=A0it=C2=A0should=C2=A0=C2=A0stable,multi=C2=A0nodes,good=C2=A0Th=
roughput
>>>
>>>
>>>
>>>=C2=A0thanks
>>>=C2=A0------------------------------------------------------
>>>
>>>=C2=A0At=C2=A02011-01-10=C2=A002:05:52=EF=BC=8C"Gregory=C2=A0Farnum"=
=C2=A0<gregf@hq.newdream.net>=C2=A0wrote:
>>>
>>>>Moving=C2=A0this=C2=A0to=C2=A0the=C2=A0list=C2=A0where=C2=A0it=C2=A0=
belongs.
>>>>
>>>>2011/1/9=C2=A0yueluck=C2=A0<yueluck@163.com>:
>>>>>=C2=A01.ceph-client-standalone.git=C2=A0,ceph-client.git
>>>>>=C2=A0what=C2=A0is=C2=A0the=C2=A0different=C2=A0of=C2=A0the=C2=A0c=
lient.git???i=C2=A0know=C2=A0ceph-client-standalone.git
>>>>>=C2=A0is=C2=A0for=C2=A0ceph.ko,
>>>>>=C2=A0what=C2=A0ceph-client.git=C2=A0do?
>>>>ceph-client.git=C2=A0is=C2=A0the=C2=A0branch=C2=A0we=C2=A0do=C2=A0a=
ll=C2=A0our=C2=A0in-kernel=C2=A0development=C2=A0on.
>>>>ceph-client-standalone=C2=A0is=C2=A0the=C2=A0fs/ceph=C2=A0tree=C2=A0=
of=C2=A0ceph-client=C2=A0with
>>>>additional=C2=A0#ifdefs=C2=A0for=C2=A0backporting.=C2=A0If=C2=A0pos=
sible=C2=A0you=C2=A0should=C2=A0be=C2=A0using
>>>>ceph-client=C2=A0as=C2=A0it's=C2=A0more=C2=A0tested=C2=A0and=C2=A0u=
p-to-date.
>>>>
>>>>>=C2=A02.=C2=A0what=C2=A0is=C2=A0different=C2=A0of=C2=A0scsi-osd,ra=
dos?
>>>>>=C2=A0scsi-osd=C2=A0is=C2=A0in=C2=A0SCSI=C2=A0Architecture=C2=A0Mo=
del,=C2=A0they=C2=A0are=C2=A0object-based=C2=A0storage?=C2=A0if
>>>>>=C2=A0rados=C2=A0depend=C2=A0on=C2=A0scsi-osd(osd.ko,libosd.ko....=
=2E)?
>>>>Ceph=C2=A0OSDs=C2=A0are=C2=A0Object=C2=A0Storage=C2=A0Devices/Daemo=
ns.=C2=A0They=C2=A0are=C2=A0conceptually
>>>>similar=C2=A0to=C2=A0SCSI=C2=A0OSDs=C2=A0but=C2=A0are=C2=A0not=C2=A0=
at=C2=A0all=C2=A0the=C2=A0same=C2=A0thing.
>>>>
>>>>>=C2=A03.do=C2=A0you=C2=A0have=C2=A0ceph=C2=A0call=C2=A0flow,docume=
nt(except=C2=A0wiki),let=C2=A0me=C2=A0know=C2=A0ceph
>>>>>=C2=A0architecture=C2=A0quickly.
>>>>Unfortunately,=C2=A0no.=C2=A0However,=C2=A0Sage's=C2=A0thesis=C2=A0=
(which=C2=A0is=C2=A0available=C2=A0on=C2=A0the
>>>>Ceph=C2=A0website)=C2=A0has=C2=A0a=C2=A0pretty=C2=A0good=C2=A0descr=
iption=C2=A0of=C2=A0the=C2=A0protocols,=C2=A0if=C2=A0not
>>>>the=C2=A0module=C2=A0architecture.=C2=A0You=C2=A0can=C2=A0check=C2=A0=
that=C2=A0out=C2=A0for=C2=A0a=C2=A0lot=C2=A0more
>>>>information=C2=A0than=C2=A0is=C2=A0on=C2=A0the=C2=A0wiki.=C2=A0:)
>>>>-Greg
>>>
>>>
>>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
