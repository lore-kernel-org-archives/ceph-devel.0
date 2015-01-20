From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: Enable Data Compression when Requesting Data from OSD over WAN
Date: Tue, 20 Jan 2015 12:43:44 -0500
Message-ID: <83069610-11CB-4E06-8B56-7583E4FC4A37@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:59659 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbATRns convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 12:43:48 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so10292928igd.4
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 09:43:47 -0800 (PST)
Received: from pal-nat184-042-112.itap.purdue.edu ([128.211.165.1])
        by mx.google.com with ESMTPSA id mi3sm3259482igb.13.2015.01.20.09.43.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 09:43:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph,

I am thinking of passing an extra =E2=80=9Ccompression=E2=80=9D flag to=
 OSD when client requesting data. When seeing such flag, OSD send compr=
essed  data to client and client decompress it transparently. It would =
be beneficial it OSD and client are connected over WAN.

Can anyone share some hints on how should start to plan/implement this =
feature?

Thanks in advance!
Cheng--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
