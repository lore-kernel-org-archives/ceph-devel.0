From: Marcin Szukala <szukala.marcin@gmail.com>
Subject: Ceph version 0.56.1, data loss on power failure
Date: Thu, 10 Jan 2013 14:54:47 +0100
Message-ID: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:53907 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3AJNyt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 08:54:49 -0500
Received: by mail-la0-f44.google.com with SMTP id fr10so607439lab.3
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 05:54:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I hava a ubuntu 12.10 host with image mapped with rbd module. The
problem is that when this host
face a power failure all data on the mapped image is lost. If I unmap
the image via the rbd unmap command, the data is preserved. I've
noticed this problem also in version 0.56

Best regards,
Marcin
