From: Willem Jan Withagen <wjw@digiware.nl>
Subject: UID/GID for ceph user and group
Date: Thu, 16 Feb 2017 16:46:55 +0100
Message-ID: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43335 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbdBTAke (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 19 Feb 2017 19:40:34 -0500
Received: from [192.168.101.50] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 6E7953759D
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 16:47:00 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Is there a typical uid/gid that is selected on oterh platforms to assign
to ceph:ceph?

On my centos7 box they are not defined when I installed the ceph package?

--WjW
