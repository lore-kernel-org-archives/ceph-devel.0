From: kefu chai <tchaikov@gmail.com>
Subject: "tobe" and "ready" in ceph-disk source
Date: Fri, 22 Sep 2017 20:49:51 +0800
Message-ID: <CAJE9aOOY4Bj-y-fATOeXS3ps5M3mhaypmAUYv=4SaduexN9Znw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37277 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdIVMtw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Sep 2017 08:49:52 -0400
Received: by mail-io0-f195.google.com with SMTP id 93so1467247iol.4
        for <ceph-devel@vger.kernel.org>; Fri, 22 Sep 2017 05:49:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ldachary@redhat.com

hi Loic,

while ready the source of ceph-disk, i found the "tobe" and "ready"
are confusing, why do we need them, instead of just using a single
ptype? why creating some block partition is atomic, while creating
some others is not?

could you please shed some insights on it?

thanks,

-- 
Regards
Kefu Chai
