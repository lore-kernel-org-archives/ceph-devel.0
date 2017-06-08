From: Jos Collin <jcollin@redhat.com>
Subject: Re: run-tox-ceph-disk
Date: Thu, 8 Jun 2017 16:38:58 +0530
Message-ID: <3a4cc839-97c9-bb08-b946-a07da30d6b04@redhat.com>
References: <062dfae7-eb33-9eb3-b2ad-34497bc0c1c2@redhat.com>
 <e7901bfc-9e21-e226-fa6c-eabfee817ce8@dachary.org>
 <CALBbquH=BWGej5OKj0cQT=0Pa+e5jM5sJ7Ji5zoT6tyzkqrUrQ@mail.gmail.com>
 <2661a852-65a9-05e3-a621-81cbda974a2d@dachary.org>
 <eacabba5-899e-6a28-b871-d1d6063d49a9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36026 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHLJE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 07:09:04 -0400
Received: by mail-pf0-f174.google.com with SMTP id x63so16059737pff.3
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jun 2017 04:09:04 -0700 (PDT)
In-Reply-To: <eacabba5-899e-6a28-b871-d1d6063d49a9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Looks like it is already fixed:

commit 91d36b64f3a1000e38aa620cddfdf3fe1866ad85
Author: Willem Jan Withagen <wjw@digiware.nl>
Date:   Fri Jun 2 16:53:43 2017 +0200

     ceph-disk: use system modules if needed

      - prettytable usage was introduced in:
             https://github.com/ceph/ceph/commit/3fa8bb1
        It is in the install-deps.sh file to be installed, but
        it is not per default installed in the testenvironment
        So allow tox tests to use "external" modules

     Signed-off-by: Willem Jan Withagen <wjw@digiware.nl>

