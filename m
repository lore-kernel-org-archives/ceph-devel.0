From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: rbd image snapshot timestamps?
Date: Thu, 4 Jan 2018 09:51:16 -0500
Message-ID: <CAGbviv+MXNSaFdQ6oWmDVEvE0gRNmjmNT=+7Tpkcrsj_w_+VhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:45424 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeADOvR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 09:51:17 -0500
Received: by mail-io0-f174.google.com with SMTP id e20so2431498iof.12
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 06:51:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Is there any way to find out when an RBD image snapshot was created?
None of the query tools ("rbd info pool/image@snapshot") appear to
return any timestamp related information.

-Wyllys Ingersoll
 Keeper Technology, LLC
