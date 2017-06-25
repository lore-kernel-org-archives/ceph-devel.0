From: Oleg Kolosov <olekol@gmail.com>
Subject: undefined symbol when running new erasure code
Date: Sun, 25 Jun 2017 21:36:10 +0300
Message-ID: <CAODUPsEFD27_aDbOx7qjnwummu6JimhYszA3dABm00_r1OQ1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:33847 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdFYSgM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Jun 2017 14:36:12 -0400
Received: by mail-ot0-f171.google.com with SMTP id r67so56658242ota.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jun 2017 11:36:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I've written an erasure code for my research purposes. I've built ceph
successfully however when setting up a virtual cluster and running
"bin/ceph osd erasure-code-profile set" I get the following error:
Error EIO: load dlopen(/home/ubuntu/ceph/build/lib/libec_optlrc.so):
/home/ubuntu/ceph/build/lib/libec_optlrc.so: undefined symbol:
_ZN4ceph11ErasureCode17minimum_to_decodeERKSt3setIiSt4lessIiESaIiEES7_PS5_


I'm working on master branch. ./run-make-check.sh also ran successfully.
I'm wondering how to approach this error.

Thanks
