From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: journal discard -> punch hole on fs
Date: Tue, 8 Dec 2015 23:37:23 +0300
Message-ID: <CAGqmi76-7SWKAsojgMPntdke5qKFsQC9B9Njr2-UrQwvgcPjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33983 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbLHUiF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 15:38:05 -0500
Received: by lbbcs9 with SMTP id cs9so18005028lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 12:38:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi list,
i've find option to enable journal discard for ssd datastore
May be it's have a sense to provide punch hole support on btrfs?

As i understand it's can not only free space, but also can speedup writ=
es:
=E2=9E=9C  ~  ioping -i 0 -w 5 -q -WWWD ./zeroed
--- ./zeroed ( ) ioping statistics ---
143 requests completed in 5.01 s, 28 iops, 114.4 KiB/s
min/avg/max/mdev =3D 21.3 ms / 35.0 ms / 66.4 ms / 7.71 ms
=E2=9E=9C  ~  ioping -i 0 -w 5 -q -WWWD ./truncated
--- ./truncated ( ) ioping statistics ---
167 requests completed in 5.03 s, 33 iops, 133.0 KiB/s
min/avg/max/mdev =3D 21.5 ms / 30.1 ms / 66.4 ms / 8.39 ms

Thanks
--=20
Have a nice day,
Timofey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
