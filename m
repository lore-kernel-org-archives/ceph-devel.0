From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Re: thanks gregf,question about ceph
Date: Fri, 14 Jan 2011 09:18:56 -0800
Message-ID: <AANLkTik2zL4B_fis6uCGLv5HDY13jaA9ZfFarTf85NEw@mail.gmail.com>
References: <1b70d2f.20f3.12d6a85a669.Coremail.yueluck@163.com>
	<AANLkTik4mLKZkdG21xgeJFHwi61jgrD+ABB9B-C0FrN9@mail.gmail.com>
	<d6ed3a.147e1.12d836b90b0.Coremail.yueluck@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62638 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab1ANRS6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jan 2011 12:18:58 -0500
Received: by eye27 with SMTP id 27so1534233eye.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jan 2011 09:18:56 -0800 (PST)
In-Reply-To: <d6ed3a.147e1.12d836b90b0.Coremail.yueluck@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yueluck <yueluck@163.com>
Cc: ceph-devel@vger.kernel.org

I don't have much experience here, but if Ceph's own RBD doesn't
satisfy your needs I guess I'd look at Sheepdog.

2011/1/13 yueluck <yueluck@163.com>:
> can you Recommend me other dfs,like ceph. you know or have experence =
on it.
> i will store xen-disk on it.=C2=A0=C2=A0 it should=C2=A0 stable,multi=
 nodes,good Throughput
>
>
>
> thanks
> ------------------------------------------------------
>
> At=C2=A02011-01-10=C2=A002:05:52=EF=BC=8C"Gregory=C2=A0Farnum"=C2=A0<=
gregf@hq.newdream.net>=C2=A0wrote:
>
>>Moving=C2=A0this=C2=A0to=C2=A0the=C2=A0list=C2=A0where=C2=A0it=C2=A0b=
elongs.
>>
>>2011/1/9=C2=A0yueluck=C2=A0<yueluck@163.com>:
>>>=C2=A01.ceph-client-standalone.git=C2=A0,ceph-client.git
>>>=C2=A0what=C2=A0is=C2=A0the=C2=A0different=C2=A0of=C2=A0the=C2=A0cli=
ent.git???i=C2=A0know=C2=A0ceph-client-standalone.git
>>>=C2=A0is=C2=A0for=C2=A0ceph.ko,
>>>=C2=A0what=C2=A0ceph-client.git=C2=A0do?
>>ceph-client.git=C2=A0is=C2=A0the=C2=A0branch=C2=A0we=C2=A0do=C2=A0all=
=C2=A0our=C2=A0in-kernel=C2=A0development=C2=A0on.
>>ceph-client-standalone=C2=A0is=C2=A0the=C2=A0fs/ceph=C2=A0tree=C2=A0o=
f=C2=A0ceph-client=C2=A0with
>>additional=C2=A0#ifdefs=C2=A0for=C2=A0backporting.=C2=A0If=C2=A0possi=
ble=C2=A0you=C2=A0should=C2=A0be=C2=A0using
>>ceph-client=C2=A0as=C2=A0it's=C2=A0more=C2=A0tested=C2=A0and=C2=A0up-=
to-date.
>>
>>>=C2=A02.=C2=A0what=C2=A0is=C2=A0different=C2=A0of=C2=A0scsi-osd,rado=
s?
>>>=C2=A0scsi-osd=C2=A0is=C2=A0in=C2=A0SCSI=C2=A0Architecture=C2=A0Mode=
l,=C2=A0they=C2=A0are=C2=A0object-based=C2=A0storage?=C2=A0if
>>>=C2=A0rados=C2=A0depend=C2=A0on=C2=A0scsi-osd(osd.ko,libosd.ko.....)=
?
>>Ceph=C2=A0OSDs=C2=A0are=C2=A0Object=C2=A0Storage=C2=A0Devices/Daemons=
=2E=C2=A0They=C2=A0are=C2=A0conceptually
>>similar=C2=A0to=C2=A0SCSI=C2=A0OSDs=C2=A0but=C2=A0are=C2=A0not=C2=A0a=
t=C2=A0all=C2=A0the=C2=A0same=C2=A0thing.
>>
>>>=C2=A03.do=C2=A0you=C2=A0have=C2=A0ceph=C2=A0call=C2=A0flow,document=
(except=C2=A0wiki),let=C2=A0me=C2=A0know=C2=A0ceph
>>>=C2=A0architecture=C2=A0quickly.
>>Unfortunately,=C2=A0no.=C2=A0However,=C2=A0Sage's=C2=A0thesis=C2=A0(w=
hich=C2=A0is=C2=A0available=C2=A0on=C2=A0the
>>Ceph=C2=A0website)=C2=A0has=C2=A0a=C2=A0pretty=C2=A0good=C2=A0descrip=
tion=C2=A0of=C2=A0the=C2=A0protocols,=C2=A0if=C2=A0not
>>the=C2=A0module=C2=A0architecture.=C2=A0You=C2=A0can=C2=A0check=C2=A0=
that=C2=A0out=C2=A0for=C2=A0a=C2=A0lot=C2=A0more
>>information=C2=A0than=C2=A0is=C2=A0on=C2=A0the=C2=A0wiki.=C2=A0:)
>>-Greg
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
