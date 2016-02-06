From: Wido den Hollander <wido@42on.com>
Subject: RBD image usage with librbd (rbd du)
Date: Sat, 6 Feb 2016 08:57:23 +0100 (CET)
Message-ID: <1015683166.2791.c431756f-cd7a-42e0-b485-4e1bed922f21.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:60252 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcBFH51 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Feb 2016 02:57:27 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 5EEBF7618A
	for <ceph-devel@vger.kernel.org>; Sat,  6 Feb 2016 08:57:24 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm working on libvirt again and for volumes libvirt has a 'capacity' and
'allocation'.

Until recently both were set to the size of the RBD image since it was not
possible to fetch the allocation of a image.

We now have 'rbd du' and this uses a librbd call to fetch the real usage of a
image.

What is the best way to fetch the 'allocation' of a RBD image using librbd (C)?
rbd_stat() won't tell and looking through librbd.h I don't know which function
to use.

Thanks,

Wido
