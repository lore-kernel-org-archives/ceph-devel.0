From: Willem Jan Withagen <wjw@digiware.nl>
Subject: CLI test for rbd
Date: Sun, 16 Jul 2017 23:25:25 +0200
Message-ID: <59aa8ba0-42e8-feaa-d6aa-ec16131fd062@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:14351 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdGPVZ0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 16 Jul 2017 17:25:26 -0400
Received: from [192.168.11.144] (unknown [192.168.11.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2E08F44E6B
        for <ceph-devel@vger.kernel.org>; Sun, 16 Jul 2017 23:25:24 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

with the creation of rbd-ggate with FreeBSD we have run into a testing 
snag..

Of rbd tehere is a CLI command help test, that verifies that help 
generates help.
But under FreeBSD that help is augmented with some ggate commands.

Do we really want/need that test?
And might I suggest to remove it, as it is IMHO not al that informative.

Otherwise we need to come up with something rather complex to make
run-cli-tests work on FreeBSD as well.

--WjW
