From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Not starting a OSD journal
Date: Sun, 29 Jan 2017 13:38:41 +0100
Message-ID: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:16206 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdA2MpE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 29 Jan 2017 07:45:04 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 8E2A5372EB
        for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2017 13:38:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

I'm rummaging thru the options, but I do not really see an option to
fully disable journaling?

One of the reasons for testing that is that ZFS already has very good
journaling functionality. So I'd like to see what kind of performance
difference that makes.

Or is this like setting journal-size to 0 or the path to /dev/null?

--WjW


