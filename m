From: Loic Dachary <loic@dachary.org>
Subject: Accelerating crush with SIMD
Date: Sun, 28 Aug 2016 19:59:58 +0200
Message-ID: <57C3269E.7010102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33874 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755742AbcH1SAE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Aug 2016 14:00:04 -0400
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.139])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 6DDF2FB8A0
        for <ceph-devel@vger.kernel.org>; Sun, 28 Aug 2016 20:00:01 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter10-d.gandi.net (mfilter10-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id xZ6khq92shGg for <ceph-devel@vger.kernel.org>;
        Sun, 28 Aug 2016 20:00:00 +0200 (CEST)
Received: from [192.168.43.58] (unknown [176.4.91.218])
        (Authenticated sender: loic@dachary.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DAAA1FB8A1
        for <ceph-devel@vger.kernel.org>; Sun, 28 Aug 2016 19:59:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Could we significantly accelerate crush with SIMD instructions ? I don't remember the idea being discussed but maybe I missed it.

Cheers
-- 
Loïc Dachary, Artisan Logiciel Libre
