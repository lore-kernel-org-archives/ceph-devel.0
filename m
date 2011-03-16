From: Sylar Shen <kimulaaa@gmail.com>
Subject: Configuration of OSD
Date: Wed, 16 Mar 2011 14:28:38 +0800
Message-ID: <AANLkTim5_ndO0VNeZneEb7PEsHBp=BPr7Bjrf3v2o=n+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44450 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1CPG2j convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 02:28:39 -0400
Received: by bwz15 with SMTP id 15so1247096bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2011 23:28:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I have a question about OSD as follows.
I have a server as OSD which contains 4*1T disks.
Therefore I should set OSDes like this in ceph.conf......
=C2=A0=C2=A0 [osd0]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host=3Dceph1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btrfs devs=3D/dev/sda1
=C2=A0=C2=A0 [osd1]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host=3Dceph1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btrfs devs=3D/dev/sdb1
=C2=A0=C2=A0 [osd2]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host=3Dceph1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btrfs devs=3D/dev/sdc1
=C2=A0=C2=A0 [osd3]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host=3Dceph1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btrfs devs=3D/dev/sdd1
My question is, if I have many servers(maybe larger than 200) and each
server contains 12*1T disks.
Should I set my ceph.conf like this pattern?
I mean, if I have 200 servers, I will have to configure 200*12=3D240
OSDes manually?
That will be a hard work....:p
Can I set like this instead and the system could do the rest for me?
=C2=A0=C2=A0[osd0-osd3]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host=3Dceph1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0btrfs devs=3D/dev/sda1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0btrfs devs=3D/dev/sdb1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0btrfs devs=3D/dev/sdc1
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0btrfs devs=3D/dev/sdd1
I am not sure if this makes sense or not. I just happened to have this
thought....:p
--
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
