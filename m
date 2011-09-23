From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Authentication error
Date: Fri, 23 Sep 2011 23:15:44 +0530
Message-ID: <CAMiHsJJTrCerY+J71-dMpam081wecCxYLVoc55woVDhfohBpcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab1IWRqG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 13:46:06 -0400
Received: by bkbzt4 with SMTP id zt4so3725309bkb.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2011 10:46:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello

<Ceph usage problem>

I have setup ceph (all components on a single node) successfully,
however I am not able to use any of the features. There seem to be
some=A0authentication=A0issue. Please throw some light on how to rectif=
y
the same.

Error example1:-
atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1 bitmapspp=
t4.bin
2011-09-23 23:06:00.774172 b7865b50 librados: client.admin
authentication error Operation not permitted
couldn't connect to cluster! error -1
Error example2:-
atish@atish-virtual-machine:/etc/ceph$ ceph -s
2011-09-23 23:08:01.525547 b788c6d0 unable to authenticate as client.ad=
min
2011-09-23 23:08:01.526487 b788c6d0 ceph_tool_common_init failed.

ceph.conf file:-
[global]
=A0 =A0 =A0 =A0 auth supported =3D cephx
=A0 =A0 =A0 =A0 keyring =3D /etc/ceph/ceph.keyring
[mon]
=A0 =A0 =A0 =A0 mon data =3D /ceph_data/mon.$id
[mds]
[osd]
=A0 =A0 =A0 =A0 osd data =3D /ceph_data/osd.$id
=A0 =A0 =A0 =A0 osd journal =3D /ceph_data/osd.$id.journal
=A0 =A0 =A0 =A0 osd journal size =3D 1000
[mon.alpha]
=A0 =A0 =A0 =A0 host =3D atish-virtual-machine
=A0 =A0 =A0 =A0 mon addr =3D 10.72.147.207:6789
[osd.0]
=A0 =A0 =A0 =A0 host =3D atish-virtual-machine
[mds.0]
=A0 =A0 =A0 =A0 host =3D atish-virtual-machine

Thanks
Atish
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
