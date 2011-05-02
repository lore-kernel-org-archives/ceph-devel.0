From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: Re: The stability of MDS
Date: Mon, 2 May 2011 11:35:36 +0800
Message-ID: <BANLkTim6yAcM-3q6pRCjd95b6DDyxGQWkQ@mail.gmail.com>
References: <BANLkTik8uQeKVD-h2kQiVkdDc+_pf9PYZQ@mail.gmail.com>
	<Pine.LNX.4.64.1104270858300.27415@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47143 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab1EBDfh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 May 2011 23:35:37 -0400
Received: by pzk9 with SMTP id 9so2881591pzk.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 May 2011 20:35:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104270858300.27415@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph <ceph-devel@vger.kernel.org>

Thanks for your help!^^
I am very appreciate.


2011/4/28 Sage Weil <sage@newdream.net>:
> On Wed, 27 Apr 2011, doki74216@gmail.com wrote:
>> Dear developers
>>
>> I am testing the reliability of MDS in Ceph File System.
>> As we know, the default setting, there are one active MDS and one st=
andby MDS.
>> I want to test the reliability of MDS.
>> Here is my testing scenario:
>> As easy to understand, here I assume the active MDS as mds0 and the
>> standby one is mds1.
>> I write =A0data and =A0stop the mds0 daemon by "ceph mds stop 0" at =
the same time.
>> Will the standby mds1 change its status to active?
>> I think the system should be normal and the data should not loss eve=
n
>> though there is just one MDS.
>> But there are many problem I met....><
>>
>> (1) I want to know which mds is active and standby.
>> =A0 =A0 =A0But there are different answer when I type different comm=
ands.
>>
>> 1. When I type "ceph mds stat".
>> =A0 =A0 It shows: (0=3Dup: active), 1 up: standby
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^ Does it means mds0
>
> Right, the 0 means mds0.
>
>> is active and mds1 is standby ?
>> 2.When I type "ceph mds dump -o -"
>> =A0 =A0 It shows: =A0mds0 is standby and mds1 is active.
>>
>> My question is: Why there are different status about mds0 and mds1?
>> Which one is correct?
>
> It sounds like you named the MDS's with numeric identifiers. =A0You s=
hould
> use non-numeric names to avoid this confusion, like mds.a and mds.b. =
=A0The
> numeric role/rank (mds0, mds1) is assigned to cmds instances dynamica=
lly
> based on who is up and needed in which role at the time.
>
>> (2) I want to know the issue about stoping the active mds.
>> =A0 =A0 =A0If the command which =A0"ceph mds stat" can show the acti=
ve mds correctly,
>> =A0 =A0 =A0the active mds must be mds0 and the other mds1 is standby=
=2E
>> =A0 =A0 =A0So I type"ceph mds stop 0".
>> =A0 =A0 =A0It shows: =A0?telling mds0 192.168.200.185:6800/14819 to =
stop?(0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^ mds1's IP.
>> 1. Why it shows the system stoping mds0 but mds1's IP ?
>
> The 'stop' command takes the dynamic role, not the name.
>
> Hope this clears it up!
> sage
>
>
>>
>> 2. When I type "ceph -w", here is the log:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> mds e43: 1/1/1 up {0=3Dup:active}, 1 up standby
>> mds e44: 1/1/1 up {0=3Dup:stoping}, 1 up standby
>> mds e45: 1/1/1 up {0=3Dup:replay}
>> mds e46: 1/1/1 up {0=3Dup:reconnect}
>> mds e47: 1/1/1 up {0=3Dup:rejoin}
>> mds e44: 1/1/1 up {0=3Dup:active}
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >From the log, which MDS does the system stop?
>> My command =A0which is"ceph mds stop 0", but the log should not be {=
1=3Dup:active}?
>> It really confuse me...
>>
>> 3. When I type"ceph mds dump ?o ?", here is the log:
>> =A0 =A0 4920: =A0 192.168.200.184:6800/30000 ?0? mds0.12 up:active s=
eq 40828
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^^ mds0's IP
>> Why does the system leave the mds0?
>>
>> Please help me solving these problem, I am very confused...
>> Thanks a lot~~~^^
>>
>>
>> By the way, this is my testing =A0environment :
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> I set 7 servers which include 3 MONs(host1 host2 host3), 2 MDSs(host=
4
>> host5) and 2 OSDes(host6 host7).
>> The version ceph 0.26 is in my system.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --
>> Best Regards,
>> Stefanie Chen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
