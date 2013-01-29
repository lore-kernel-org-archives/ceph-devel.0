From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Ceph Production Environment Setup and Configurations?
Date: Tue, 29 Jan 2013 11:34:48 +0000
Message-ID: <5107B3D8.8060504@inktank.com>
References: <CAPhYxPwK+wM1pBpaf7zXM-L6PagcKiQ_v07MXypRGrxj4oQZtw@mail.gmail.com> <CAPhYxPwrqS9ahnn+D2JgjO8HKdorQaOeo6teEP5=+K23iNodKg@mail.gmail.com> <CAJH6TXiBo9byu5apLdGWS7g2X5OG7a-VKvGS6OS=WmdnxHfthA@mail.gmail.com> <6F3FA899187F0043BA1827A69DA2F7CC5E93B4@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36513 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3A2LfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 06:35:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so592013lbj.17
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 03:35:09 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5E93B4@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, femi anjorin <femi.anjorin@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ross Turk <ross@inktank.com>

On 01/29/2013 11:25 AM, Chen, Xiaoxi wrote:
> [The following views only behalf of myself, not relate with Intel..]
> Looking forward for the performance data on Atom.
> Atom perform badly in Swift, but since Ceph is slightly efficient tha=
n Swift, it must be better.
> I have some concern about weather Atom can support such high throughp=
ut( you have 16 disks, assuming 50MB/s per disk, you would like to have=
 50*16 *2(include journal write)=3D1600MB/s ,together with correspondin=
g network throughput, say 10GbE. The total IO throughput seems too high=
 for Atom. Baidu (www.baidu.com) use Arm based storage node(not using c=
eph,but their own DFS), a node with a quad-core Arm together with 4 dis=
ks, and a 2U box can put up to 6 nodes, the 6 nodes share a 10Gb NIC. A=
lthough Atom is different with Arm, but you can take Baidu as a referen=
ce.
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Gandalf Corvotempesta
> Sent: 2013=C4=EA1=D4=C229=C8=D5 17:25
> To: femi anjorin
> Cc: ceph-devel@vger.kernel.org; Ross Turk
> Subject: Re: Ceph Production Environment Setup and Configurations?
>=20
> 2013/1/29 femi anjorin <femi.anjorin@gmail.com>:
>> CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz
>=20
> Atom? For which kind of role ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=81=7F)=DE=BA=
{.n=81=7F+=89=B7=9Cz=98]z=F7=A5=8A{ay=81=7F=1D=CA=87=DA=99=81=7F,j=07=AD=
=A2f=A3=A2=B7h=9A=8B=E0z=81=7F=1E=AEw=A5=A2=81=7F=0C=A2=B7=A6j:+v=89=A8=
=8Aw=E8j=D8m=B6=9F=81=7F=81=7F=07=AB=91=EA=E7zZ+=83=F9=9A=8E=8A=DD=A2j"=
=9D=FA!tml=3D
>=20


=46WIW, Wido had been testing Ceph on Atoms a while back.  I don't know
what conclusions he reached, or even if he has already reached any
conclusions at all.  I, for one, would be really interested in knowing
how well (or how poorly) Atoms deal with Ceph.

Maybe Wido can share some thoughts on this one? :-)

  -Joao
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
