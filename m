From: hemant surale <hemant.surale@gmail.com>
Subject: Mapping between PG & OSD
Date: Tue, 28 Aug 2012 12:20:52 +0530
Message-ID: <CAGfy=6=6uuw=eGLxTO7Uk_uFi=1FzyhToMXUN8izXjRyHWEWmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64731 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2H1Gux (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 02:50:53 -0400
Received: by vcbfk26 with SMTP id fk26so5438969vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 23:50:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All ,
      I was unable to figure out how we can direct the ceph to store
data based on host needs i.e. Host A wants to keep frequently used
data on its own local OSD. So my question is about how we can direct
such write/read requests to local OSD than on network? Is it possible
?
      Any help is appreciated .


Regards,
Hemant Surale.
