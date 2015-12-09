From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: RBD Kernel: write_same_max_bytes and SCSI XCOPY
Date: Wed, 9 Dec 2015 10:08:28 +0300
Message-ID: <CAGqmi77oh71KZN75Ti4k7uzp=0eujrg5vWKgLnbMvhirXuDN-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34730 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbLIHJJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 02:09:09 -0500
Received: by lbbcs9 with SMTP id cs9so24416854lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 23:09:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi list,
As i found write_same_max_bytes are equal to zero
if i understand correctly, it's means what RBD not support offloading
copy operations

Is this possible to add this feature, as example for LIO with SCSI XCOPY?
-- 
Have a nice day,
Timofey.
