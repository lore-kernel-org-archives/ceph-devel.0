From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: /sys/class/rbd does not exist after loading ceph module
Date: Fri, 30 Jul 2010 16:41:51 +0800
Message-ID: <AANLkTikOViq3VCY2fwtut1c1kU8dkM7pRRwqfrYyhEPL@mail.gmail.com>
References: <AANLkTi=r74Q3SBS71+QcditFhNxzUfdCf1F9F18R4Yiy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46579 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab0G3Ilw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 04:41:52 -0400
Received: by vws3 with SMTP id 3so1163310vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 01:41:51 -0700 (PDT)
In-Reply-To: <AANLkTi=r74Q3SBS71+QcditFhNxzUfdCf1F9F18R4Yiy@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

 I would like to try the RBD feature of Ceph. I am following
http://ceph.newdream.net/wiki/Rbd,=A0 but failed at :

 echo "xxx name=3Dadmin rbd foo" > /sys/class/rbd/add


 It was because folder /sys/class/rbd does not exist. But ceph kernel
module is loaded and I can mount -t ceph xxxx:/ /mnt/ceph.

 I am using kernel 2.6.34.1 on fedora 13.

 the following symbols are set in .config while compiling the kernel.

 CONFIG_CEPH_FS=3Dm
 CONFIG_CEPH_FS_PRETTYDEBUG=3Dy

 Ceph 0.20.2 is installed by yum.

 Did I miss anything?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
