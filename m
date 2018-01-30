From: sbezverk <sbezverk@gmail.com>
Subject: CSI Ceph support for mounting a volume on same node  by multiple
 workloads
Date: Tue, 30 Jan 2018 08:56:42 -0500
Message-ID: <9F12F1D1-AECD-448C-988E-8836FB568195@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40719 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeA3N4r (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jan 2018 08:56:47 -0500
Received: by mail-qt0-f196.google.com with SMTP id s39so17273321qth.7
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jan 2018 05:56:47 -0800 (PST)
Received: from [10.117.94.148] ([173.38.117.91])
        by smtp.gmail.com with ESMTPSA id z140sm9158387qkb.51.2018.01.30.05.56.45
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 05:56:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Apologies for wide distribution. It concerns only folks interested in running CEPH CSI plugin in kubernetes or other COs.
 
Currently CSI spec explicitly disallow attaching  same volume on the same node by multiple workloads (pods). It looks like a limitation, as kubernetes already supports this functionality.
There is issue filed at CSI Spec repo and we need your help if you need this feature in CSI spec. Please share in  the issue your use cases and/or express if you need this feature in CSI. It will help us to re-evaluate previous decision to not allow this feature.
Here is the link to the issue;
https://github.com/container-storage-interface/spec/issues/178
 
Thank you
Serguei


