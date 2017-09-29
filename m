From: Two Spirit <twospirit6905@gmail.com>
Subject: luminous/dmcrypt/bluestore
Date: Fri, 29 Sep 2017 10:00:21 -0700
Message-ID: <CAKRxpusAymjU9Mcm=69tiSk52ok-YfzgtMQaUzxcODpKe8b=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:52743 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdI2RAY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 13:00:24 -0400
Received: by mail-io0-f182.google.com with SMTP id i197so337273ioe.9
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 10:00:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

It looks like bluestore is now default in luminous, so
if I run 'ceph-deploy prepare', is it already bluestore without
running  'prepare --bluestore' option?

looking at the /var/lib/ceph/osd, also looks like what the docs
describe as bluestore. I'm unfamiliar with the layout prior to
luminous.

so running 'ceph-deploy osd prepare --dmcrypt'  prepares the disk for
encrypted bluestore?
