From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: The stability of MDS
Date: Wed, 27 Apr 2011 23:22:09 +0800
Message-ID: <BANLkTik8uQeKVD-h2kQiVkdDc+_pf9PYZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34289 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758882Ab1D0PWK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 11:22:10 -0400
Received: by pzk9 with SMTP id 9so1090518pzk.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 08:22:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Dear developers

I am testing the reliability of MDS in Ceph File System.
As we know, the default setting, there are one active MDS and one stand=
by MDS.
I want to test the reliability of MDS.
Here is my testing scenario:
As easy to understand, here I assume the active MDS as mds0 and the
standby one is mds1.
I write  data and  stop the mds0 daemon by "ceph mds stop 0" at the sam=
e time.
Will the standby mds1 change its status to active?
I think the system should be normal and the data should not loss even
though there is just one MDS.
But there are many problem I met....><

(1) I want to know which mds is active and standby.
     But there are different answer when I type different commands.

1. When I type "ceph mds stat".
    It shows: (0=3Dup: active), 1 up: standby
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Does it means mds0
is active and mds1 is standby ?
2.When I type "ceph mds dump -o -"
    It shows:  mds0 is standby and mds1 is active.

My question is: Why there are different status about mds0 and mds1?
Which one is correct?


(2) I want to know the issue about stoping the active mds.
     If the command which  "ceph mds stat" can show the active mds corr=
ectly,
     the active mds must be mds0 and the other mds1 is standby.
     So I type"ceph mds stop 0".
     It shows:  =91telling mds0 192.168.200.185:6800/14819 to stop=92(0=
)
                                                 ^^^^^^^^^^^^^^^^^^ mds=
1's IP.
1. Why it shows the system stoping mds0 but mds1's IP ?

2. When I type "ceph -w", here is the log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mds e43: 1/1/1 up {0=3Dup:active}, 1 up standby
mds e44: 1/1/1 up {0=3Dup:stoping}, 1 up standby
mds e45: 1/1/1 up {0=3Dup:replay}
mds e46: 1/1/1 up {0=3Dup:reconnect}
mds e47: 1/1/1 up {0=3Dup:rejoin}
mds e44: 1/1/1 up {0=3Dup:active}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom the log, which MDS does the system stop?
My command  which is"ceph mds stop 0", but the log should not be {1=3Du=
p:active}?
It really confuse me...

3. When I type"ceph mds dump =96o =96", here is the log:
    4920:   192.168.200.184:6800/30000 =910=92 mds0.12 up:active seq 40=
828
                 ^^^^^^^^^^^^^^^^^^^ mds0's IP
Why does the system leave the mds0?

Please help me solving these problem, I am very confused...
Thanks a lot~~~^^


By the way, this is my testing  environment :
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I set 7 servers which include 3 MONs(host1 host2 host3), 2 MDSs(host4
host5) and 2 OSDes(host6 host7).
The version ceph 0.26 is in my system.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--
Best Regards,
Stefanie Chen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
