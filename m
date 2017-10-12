From: Alfredo Deza <adeza@redhat.com>
Subject: major infrastructure outage
Date: Thu, 12 Oct 2017 07:24:52 -0400
Message-ID: <CAC-Np1xnrr-RXUV3m87bJ6QP-b-xV7KtQrQud5HckEgBQ-fDDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:51122 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbdJLLYy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 07:24:54 -0400
Received: by mail-oi0-f46.google.com with SMTP id q4so7882509oic.7
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 04:24:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, David Galloway <dgallowa@redhat.com>

We are currently going through a severe outage. All critical
infrastructure services are currently unavailable.

This includes the following:

* Both Jenkins masters (one is for Ceph the other one for ceph-ansible)
* Anything in Shaman
* All build nodes
* All repositories (anything *chacra.ceph.com)

Some services are up, like docs.ceph.com, tracker, and download.ceph.com

We are currently trying to determine the reason why these are
completely unreachable with the service provider.

We will keep updating once we have anything to report.
