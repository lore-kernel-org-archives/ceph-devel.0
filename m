From: =?utf-8?Q?Edgaras_Luko=C5=A1evi=C4=8Dius?=
	<edgaras.lukosevicius@gmail.com>
Subject: trimming rbd image does not reclaim free space
Date: Mon, 11 May 2015 14:26:00 +0300
Message-ID: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34269 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbbEKL0E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 07:26:04 -0400
Received: by wgic8 with SMTP id c8so98411577wgi.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 04:26:03 -0700 (PDT)
Received: from [192.168.168.7] ([37.157.144.44])
        by mx.google.com with ESMTPSA id xy5sm22355484wjc.35.2015.05.11.04.26.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 May 2015 04:26:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have ceph pool (size=3D2) and three RBD images (2TB each) and I have =
noticed, that deleting data does not reclaim data on ceph.
What I have done is mount RBD device as a loopback device loop0, mounte=
d it to a filesystem, ran =93fstrim=94 and got response:

/mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed
/mnt/fstrim/: 1 TiB (1125871489024 bytes) trimmed
/mnt/fstrim/: 1.1 TiB (1186485440512 bytes) trimmed

Now that would be almost perfect if not the fact, that space was not re=
claimed on ceph itself. Using =93ceph osd df=94 I still see same usage =
even after waiting few hours and I don=92t see any action.

I=92m using ceph v0.94-2 and kernel 3.10

What is the proper way to reclaim unused space? I had pool size 3, but =
had to lower it to two, to avoid getting my OSDs full.

Thanks.--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
