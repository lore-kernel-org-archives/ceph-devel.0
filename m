From: Christian Brunner <chb@muc.de>
Subject: CEPH_OSD_TMAP_SET in librados.h
Date: Thu, 27 May 2010 20:46:20 +0200
Message-ID: <AANLkTinw76aIGD2pH67r-KDxSScAWJ7cRvrPliDnYl09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63343 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914Ab0E0SqW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 May 2010 14:46:22 -0400
Received: by wyb29 with SMTP id 29so241206wyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 May 2010 11:46:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

while preparing the next qemu patch I realized that you need
ceph-unstable now to build the qemu-rbd driver.

This is because CEPH_OSD_TMAP_SET is only defined in librados.h
unstable. Could you please apply the patch in testing, too?

I guess I'm to late for 0.20.2, but I would like to state in my mail
to the qemu list that it will work with 0.20.3.

Regards,
Christian
