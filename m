From: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Subject: rados_clone_range for different pgs
Date: Fri, 2 Aug 2013 15:53:30 +0300
Message-ID: <CA+CdmLbW+Tb2Wz1+DNJ4yFZ7-gDG1XsPfvKGZ-H5iJZQJ=QvZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f194.google.com ([209.85.128.194]:64893 "EHLO
	mail-ve0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab3HBMxb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 08:53:31 -0400
Received: by mail-ve0-f194.google.com with SMTP id 15so308124vea.5
        for <ceph-devel@vger.kernel.org>; Fri, 02 Aug 2013 05:53:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi

I have asked this question in ceph-users, but did not get any
response, so I'll test my luck again, but with ceph-devel =)

Is there any way to copy part of one object into another one if they
reside in different pgs?
There is rados_clone_range, but it requires both objects to be inside one pg.

Thanks!
