From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 10:25:19 -0400
Message-ID: <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
 <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com> <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64766 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877Ab2FFOZl convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 10:25:41 -0400
Received: by lahd3 with SMTP id d3so4683506lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 07:25:40 -0700 (PDT)
In-Reply-To: <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sam.zaydel@inktank.com

Sorry for the re-post.=C2=A0 First attempt got eaten by the mailing lis=
t
because it wasn't plain text.=C2=A0 My first attempt!

> With CephFS not quite ready for production, what would be the recomme=
nded way for sharing Ceph to older operating systems?=C2=A0 Specificall=
y, I want to share a file system (i.e. mount a common directory) on sev=
eral CentOS5 and CentOS6 nodes.=C2=A0 I don't think I can mount an RBD =
from more than one node, so what is my best bet?
>
> Mount an RBD on a file "head" and export it via NFS?
>
> I feel like that is the only sane choice, but wanted to ask in case I=
 am missing something better.

 =C2=A0- Travis
>
>
> On Wed, Jun 6, 2012 at 9:58 AM, Sam Zaydel <sam.zaydel@inktank.com> w=
rote:
>>
>> I think you will be able to build from source the client bits that y=
ou
>> need, but I saw this from an earlier similar discussion mentioning
>> Python version, so I would make sure that python > 2.5 is used,
>> realistically 2.6 should be the norm today.
>>
>> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/5717
>>
>> On Tue, Jun 5, 2012 at 6:16 PM, =C2=A0<Eric_YH_Chen@wiwynn.com> wrot=
e:
>> > Dear All:
>> >
>> >=E3=80=80=E3=80=80 My ceph cluster is installed on Ubuntu 12.04 wit=
h kernel 3.2.0.
>> >
>> >=E3=80=80=E3=80=80 =C2=A0=C2=A0But I have a situation that I may ne=
ed to mount cephfs on centos 5.7, which with kernel 2.6.18.
>> >
>> > =C2=A0 =C2=A0(that is to say , I only need to execute mount.ceph o=
n the centos 5.7, not the whole ceph system)
>> >
>> > =C2=A0 =C2=A0I want to find a solution that can provide reliable a=
nd high availability share file system.
>> >
>> > =C2=A0 =C2=A0Is it possible to do this? Or any other recommend way=
? =C2=A0Ex: =C2=A0export NFS=E2=80=A6
>> >
>> > =C2=A0 =C2=A0Thanks!
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>
>>
>>
>> --
>> Inked by Sam Zaydel
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
