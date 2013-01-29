From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph Production Environment Setup and Configurations?
Date: Tue, 29 Jan 2013 07:40:23 -0600
Message-ID: <5107D147.5020708@inktank.com>
References: <CAPhYxPwK+wM1pBpaf7zXM-L6PagcKiQ_v07MXypRGrxj4oQZtw@mail.gmail.com> <CAPhYxPwrqS9ahnn+D2JgjO8HKdorQaOeo6teEP5=+K23iNodKg@mail.gmail.com> <CAJH6TXiBo9byu5apLdGWS7g2X5OG7a-VKvGS6OS=WmdnxHfthA@mail.gmail.com> <6F3FA899187F0043BA1827A69DA2F7CC5E93B4@SHSMSX102.ccr.corp.intel.com> <5107B3D8.8060504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:36964 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3A2Nk0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 08:40:26 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so557454iaz.16
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 05:40:25 -0800 (PST)
In-Reply-To: <5107B3D8.8060504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, femi anjorin <femi.anjorin@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ross Turk <ross@inktank.com>

On 01/29/2013 05:34 AM, Joao Eduardo Luis wrote:
> On 01/29/2013 11:25 AM, Chen, Xiaoxi wrote:
>> [The following views only behalf of myself, not relate with Intel..]
>> Looking forward for the performance data on Atom.
>> Atom perform badly in Swift, but since Ceph is slightly efficient th=
an Swift, it must be better.
>> I have some concern about weather Atom can support such high through=
put( you have 16 disks, assuming 50MB/s per disk, you would like to hav=
e 50*16 *2(include journal write)=3D1600MB/s ,together with correspondi=
ng network throughput, say 10GbE. The total IO throughput seems too hig=
h for Atom. Baidu (www.baidu.com) use Arm based storage node(not using =
ceph,but their own DFS), a node with a quad-core Arm together with 4 di=
sks, and a 2U box can put up to 6 nodes, the 6 nodes share a 10Gb NIC. =
Although Atom is different with Arm, but you can take Baidu as a refere=
nce.
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of Gandalf Corvotempesta
>> Sent: 2013=C4=EA1=D4=C229=C8=D5 17:25
>> To: femi anjorin
>> Cc: ceph-devel@vger.kernel.org; Ross Turk
>> Subject: Re: Ceph Production Environment Setup and Configurations?
>>
>> 2013/1/29 femi anjorin <femi.anjorin@gmail.com>:
>>> CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz
>>
>> Atom? For which kind of role ?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at  http://vger.kernel.org/majordomo-info.html
>> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=81=7F=7F)=
=DE=BA{.n=81=7F=7F+=89=B7=9Cz=98]z=F7=A5=8A{ay=81=7F=7F=1D=CA=87=DA=99=81=
=7F=7F,j=07=AD=A2f=A3=A2=B7h=9A=8B=E0z=81=7F=7F=1E=AEw=A5=A2=81=7F=7F=0C=
=A2=B7=A6j:+v=89=A8=8Aw=E8j=D8m=B6=9F=81=7F=7F=81=7F=7F=07=AB=91=EA=E7z=
Z+=83=F9=9A=8E=8A=DD=A2j"=9D=FA!tml=3D
>>
>=20
>=20
> FWIW, Wido had been testing Ceph on Atoms a while back.  I don't know
> what conclusions he reached, or even if he has already reached any
> conclusions at all.  I, for one, would be really interested in knowin=
g
> how well (or how poorly) Atoms deal with Ceph.
>=20
> Maybe Wido can share some thoughts on this one? :-)
>=20
>    -Joao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Just FYI, I don't expect you'll be able to get anywhere close to 10GbE
performance on the Atom.  You'll almost certainly be CPU bound long
before that.  I actually would be curious how much throughput you could
push to those disks just doing straight fio tests and how much CPU
overhead you'd see.  I imagine you could max out the CPU without even
having Ceph involved.

I'm guessing you probably are going to be limited to about 0.75-1 OSD
per atom core, and that's assuming that your network and SAS controller=
s
aren't CPU hogs.

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
