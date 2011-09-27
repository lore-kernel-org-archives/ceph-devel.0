From: Kelly Kane <kelly@hawknetworks.com>
Subject: Re: Authentication error
Date: Tue, 27 Sep 2011 13:42:54 -0700
Message-ID: <CAKfXD0yavfECZ8xmZKTP1odqkkMA3-62g=0rp+=xJVqvr9jhFQ@mail.gmail.com>
References: <CAMiHsJJTrCerY+J71-dMpam081wecCxYLVoc55woVDhfohBpcw@mail.gmail.com>
	<CAMiHsJJitpTZCUZDN21ew0J2+fyYKX2pUDCzuVgwkW54ev5Uow@mail.gmail.com>
	<CAF3hT9DwJQNk6Cqm+umDyz6OXSMnjMqizwt+VuRQ2e5-S5xTJA@mail.gmail.com>
	<CAMiHsJL8LHnKVCcEQLK02KA3qz+Ry6Kscpx7mSvHbyexMP7PJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab1I0Umz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2011 16:42:55 -0400
Received: by fxe4 with SMTP id 4so7528219fxe.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2011 13:42:54 -0700 (PDT)
In-Reply-To: <CAMiHsJL8LHnKVCcEQLK02KA3qz+Ry6Kscpx7mSvHbyexMP7PJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Does the authentication library reject world/group readable keys? Or
is this public key only?

Kelly

On 9/27/11, Atish Kathpal <atish.kathpal@gmail.com> wrote:
> Thanks for your help Gregory. I tried what you suggested, but still
> can't resolve the problem.
>
> I have given 777 privileges to the keyring file and am also able to
> read its contents. Here is a snapshop of what I did:-
>
> atish@atish-virtual-machine:/etc/ceph$ sudo ceph health -k
> /etc/ceph/ceph.keyring
> 2011-09-28 01:16:30.066795 b78746d0 unable to authenticate as client.=
admin
> 2011-09-28 01:16:30.067890 b78746d0 ceph_tool_common_init failed.
> atish@atish-virtual-machine:/etc/ceph$ cat ceph.keyring
> [client.admin]
>         key =3D AQDQynxOCNuXJRAAvt17zqCn70kGovuIhJXEyg=3D=3D
>         auid =3D 18446744073709551615
>
> Even providing the path to the keyring is not helping for some  reaso=
n.
>
> Any way to avoid the keyring/authentication problem I am facing?
>
> Please help.
>
> Thanks
> Atish
>
> On Sun, Sep 25, 2011 at 9:05 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> Looks like it's not able to load the keyring for some reason. Make
>> sure it exists and is readable, then try specifying it on the comman=
d
>> line (-k /path/to/keyring).
>>
>> On Sat, Sep 24, 2011 at 10:22 PM, Atish Kathpal <atish.kathpal@gmail=
=2Ecom>
>> wrote:
>>> Dear developers
>>>
>>> Please let me know if I am doing anything silly here. I am new to C=
eph.
>>>
>>> Thanks and regards
>>> Atish
>>>
>>> On Fri, Sep 23, 2011 at 11:15 PM, Atish Kathpal <atish.kathpal@gmai=
l.com>
>>> wrote:
>>>> Hello
>>>>
>>>> <Ceph usage problem>
>>>>
>>>> I have setup ceph (all components on a single node) successfully,
>>>> however I am not able to use any of the features. There seem to be
>>>> some=C2=A0authentication=C2=A0issue. Please throw some light on ho=
w to rectify
>>>> the same.
>>>>
>>>> Error example1:-
>>>> atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1
>>>> bitmapsppt4.bin
>>>> 2011-09-23 23:06:00.774172 b7865b50 librados: client.admin
>>>> authentication error Operation not permitted
>>>> couldn't connect to cluster! error -1
>>>> Error example2:-
>>>> atish@atish-virtual-machine:/etc/ceph$ ceph -s
>>>> 2011-09-23 23:08:01.525547 b788c6d0 unable to authenticate as
>>>> client.admin
>>>> 2011-09-23 23:08:01.526487 b788c6d0 ceph_tool_common_init failed.
>>>>
>>>> ceph.conf file:-
>>>> [global]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth supported =3D cephx
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyring =3D /etc/ceph/ceph.keyring
>>>> [mon]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon data =3D /ceph_data/mon.$id
>>>> [mds]
>>>> [osd]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd data =3D /ceph_data/osd.$id
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal =3D /ceph_data/osd.$id.jou=
rnal
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 1000
>>>> [mon.alpha]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D atish-virtual-machine
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon addr =3D 10.72.147.207:6789
>>>> [osd.0]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D atish-virtual-machine
>>>> [mds.0]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D atish-virtual-machine
>>>>
>>>> Thanks
>>>> Atish
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
