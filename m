From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Missing -lpython2.7 when linking ceph-dencoder
Date: Fri, 26 May 2017 16:12:49 +0200
Message-ID: <8117b0fd-3c3d-c56b-490c-41772fdd2478@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:24290 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdEZOMy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 May 2017 10:12:54 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 74FD942377
        for <ceph-devel@vger.kernel.org>; Fri, 26 May 2017 16:12:51 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Kefu,

This change has happend relatively early in my vacation because all the
build that are left sort of hang on this. ceph-dencoder just misses out
on a large number of Py object that it can not link. And that again
comes from linking boost_python.

Now I remember we had this problem when we reworked the
find_package(python) stuff.
Any suggestions other than starting to bisect this?

--WjW


