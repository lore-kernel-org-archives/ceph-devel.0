From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Authentication error
Date: Sun, 25 Sep 2011 08:35:13 -0700
Message-ID: <CAF3hT9DwJQNk6Cqm+umDyz6OXSMnjMqizwt+VuRQ2e5-S5xTJA@mail.gmail.com>
References: <CAMiHsJJTrCerY+J71-dMpam081wecCxYLVoc55woVDhfohBpcw@mail.gmail.com>
	<CAMiHsJJitpTZCUZDN21ew0J2+fyYKX2pUDCzuVgwkW54ev5Uow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38263 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1IYPfO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2011 11:35:14 -0400
Received: by vws1 with SMTP id 1so5157390vws.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2011 08:35:13 -0700 (PDT)
In-Reply-To: <CAMiHsJJitpTZCUZDN21ew0J2+fyYKX2pUDCzuVgwkW54ev5Uow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

Looks like it's not able to load the keyring for some reason. Make
sure it exists and is readable, then try specifying it on the command
line (-k /path/to/keyring).

On Sat, Sep 24, 2011 at 10:22 PM, Atish Kathpal <atish.kathpal@gmail.co=
m> wrote:
> Dear developers
>
> Please let me know if I am doing anything silly here. I am new to Cep=
h.
>
> Thanks and regards
> Atish
>
> On Fri, Sep 23, 2011 at 11:15 PM, Atish Kathpal <atish.kathpal@gmail.=
com> wrote:
>> Hello
>>
>> <Ceph usage problem>
>>
>> I have setup ceph (all components on a single node) successfully,
>> however I am not able to use any of the features. There seem to be
>> some=A0authentication=A0issue. Please throw some light on how to rec=
tify
>> the same.
>>
>> Error example1:-
>> atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1 bitmap=
sppt4.bin
>> 2011-09-23 23:06:00.774172 b7865b50 librados: client.admin
>> authentication error Operation not permitted
>> couldn't connect to cluster! error -1
>> Error example2:-
>> atish@atish-virtual-machine:/etc/ceph$ ceph -s
>> 2011-09-23 23:08:01.525547 b788c6d0 unable to authenticate as client=
=2Eadmin
>> 2011-09-23 23:08:01.526487 b788c6d0 ceph_tool_common_init failed.
>>
>> ceph.conf file:-
>> [global]
>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/ceph.keyring
>> [mon]
>> =A0 =A0 =A0 =A0 mon data =3D /ceph_data/mon.$id
>> [mds]
>> [osd]
>> =A0 =A0 =A0 =A0 osd data =3D /ceph_data/osd.$id
>> =A0 =A0 =A0 =A0 osd journal =3D /ceph_data/osd.$id.journal
>> =A0 =A0 =A0 =A0 osd journal size =3D 1000
>> [mon.alpha]
>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>> =A0 =A0 =A0 =A0 mon addr =3D 10.72.147.207:6789
>> [osd.0]
>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>> [mds.0]
>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>>
>> Thanks
>> Atish
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
