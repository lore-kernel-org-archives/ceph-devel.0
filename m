From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: CephFS and the next infernalis release v9.2.1
Date: Fri, 12 Feb 2016 13:06:51 +0530
Message-ID: <CAP3mxSwYvhDwi8Bzd3DSUAph+7Cchmtjw-QqtsDgkoN-CBkAjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34107 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcBLHgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Feb 2016 02:36:53 -0500
Received: by mail-lb0-f173.google.com with SMTP id uq3so4854486lbc.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Feb 2016 23:36:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gfarnum@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi Greg,

The next infernalis release as found at
https://github.com/ceph/ceph/tree/infernalis passed most of the CephFS
suite ( http://tracker.ceph.com/issues/13750#note-19 ) except for 1
failure, which was not seen at a later run (
http://tracker.ceph.com/issues/13750#note-26 ). Do you think the
infernalis branch is ready for QE to start their own round of testing
?

Thanks
Abhishek
