From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Missing prettytable during ceph-disk runs
Date: Fri, 2 Jun 2017 12:42:35 +0200
Message-ID: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25697 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdFBKmh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 06:42:37 -0400
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 58A7A42F56
        for <ceph-devel@vger.kernel.org>; Fri,  2 Jun 2017 12:42:34 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

During run-tox tests, ceph-disk complains that it is missing prettytable.
It is however installed on my system, and I can load it. So that part
works. But one way or another it is not loaded into the tox environment.

How or what are all other dependancies loaded?
Is there a config file where I need to add that this test needs prettytable?

--WjW
