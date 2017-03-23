From: Ning Yao <zay11022@gmail.com>
Subject: run-rbd-tests not in 'make check'?
Date: Fri, 24 Mar 2017 01:10:43 +0800
Message-ID: <CALZt5jwF4dk_ivpm1XKCYGGxGi0ZN_auiiDNz30xS+EC=gVftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:34865 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdCWRKp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 13:10:45 -0400
Received: by mail-it0-f42.google.com with SMTP id y18so44239976itc.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 10:10:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

Why run-rbd-tests now is not involved into "make check" to verify the
rbd cli now? So how could we test rbd cli now?


Regards
Ning Yao
