From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: Authentication error
Date: Wed, 28 Sep 2011 01:19:53 +0530
Message-ID: <CAMiHsJL8LHnKVCcEQLK02KA3qz+Ry6Kscpx7mSvHbyexMP7PJQ@mail.gmail.com>
References: <CAMiHsJJTrCerY+J71-dMpam081wecCxYLVoc55woVDhfohBpcw@mail.gmail.com>
 <CAMiHsJJitpTZCUZDN21ew0J2+fyYKX2pUDCzuVgwkW54ev5Uow@mail.gmail.com> <CAF3hT9DwJQNk6Cqm+umDyz6OXSMnjMqizwt+VuRQ2e5-S5xTJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52693 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1I0TuO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2011 15:50:14 -0400
Received: by bkbzt4 with SMTP id zt4so7299785bkb.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2011 12:50:13 -0700 (PDT)
In-Reply-To: <CAF3hT9DwJQNk6Cqm+umDyz6OXSMnjMqizwt+VuRQ2e5-S5xTJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks for your help Gregory. I tried what you suggested, but still
can't resolve the problem.

I have given 777 privileges to the keyring file and am also able to
read its contents. Here is a snapshop of what I did:-

atish@atish-virtual-machine:/etc/ceph$ sudo ceph health -k
/etc/ceph/ceph.keyring
2011-09-28 01:16:30.066795 b78746d0 unable to authenticate as client.ad=
min
2011-09-28 01:16:30.067890 b78746d0 ceph_tool_common_init failed.
atish@atish-virtual-machine:/etc/ceph$ cat ceph.keyring
[client.admin]
        key =3D AQDQynxOCNuXJRAAvt17zqCn70kGovuIhJXEyg=3D=3D
        auid =3D 18446744073709551615

Even providing the path to the keyring is not helping for some  reason.

Any way to avoid the keyring/authentication problem I am facing?

Please help.

Thanks
Atish

On Sun, Sep 25, 2011 at 9:05 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> Looks like it's not able to load the keyring for some reason. Make
> sure it exists and is readable, then try specifying it on the command
> line (-k /path/to/keyring).
>
> On Sat, Sep 24, 2011 at 10:22 PM, Atish Kathpal <atish.kathpal@gmail.=
com> wrote:
>> Dear developers
>>
>> Please let me know if I am doing anything silly here. I am new to Ce=
ph.
>>
>> Thanks and regards
>> Atish
>>
>> On Fri, Sep 23, 2011 at 11:15 PM, Atish Kathpal <atish.kathpal@gmail=
=2Ecom> wrote:
>>> Hello
>>>
>>> <Ceph usage problem>
>>>
>>> I have setup ceph (all components on a single node) successfully,
>>> however I am not able to use any of the features. There seem to be
>>> some=A0authentication=A0issue. Please throw some light on how to re=
ctify
>>> the same.
>>>
>>> Error example1:-
>>> atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1 bitma=
psppt4.bin
>>> 2011-09-23 23:06:00.774172 b7865b50 librados: client.admin
>>> authentication error Operation not permitted
>>> couldn't connect to cluster! error -1
>>> Error example2:-
>>> atish@atish-virtual-machine:/etc/ceph$ ceph -s
>>> 2011-09-23 23:08:01.525547 b788c6d0 unable to authenticate as clien=
t.admin
>>> 2011-09-23 23:08:01.526487 b788c6d0 ceph_tool_common_init failed.
>>>
>>> ceph.conf file:-
>>> [global]
>>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/ceph.keyring
>>> [mon]
>>> =A0 =A0 =A0 =A0 mon data =3D /ceph_data/mon.$id
>>> [mds]
>>> [osd]
>>> =A0 =A0 =A0 =A0 osd data =3D /ceph_data/osd.$id
>>> =A0 =A0 =A0 =A0 osd journal =3D /ceph_data/osd.$id.journal
>>> =A0 =A0 =A0 =A0 osd journal size =3D 1000
>>> [mon.alpha]
>>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>>> =A0 =A0 =A0 =A0 mon addr =3D 10.72.147.207:6789
>>> [osd.0]
>>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>>> [mds.0]
>>> =A0 =A0 =A0 =A0 host =3D atish-virtual-machine
>>>
>>> Thanks
>>> Atish
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
