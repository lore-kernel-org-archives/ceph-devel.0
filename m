From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Still denc warnings in Clang
Date: Thu, 23 Mar 2017 13:10:26 +0100
Message-ID: <3793fc2c-b971-7440-6448-219500e6f2a5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:53157 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753979AbdCWMKl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 08:10:41 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 622BF3CDF5
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 13:10:38 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I thought that all these warnings were eradicated by now?

--WjW

/home/jenkins/workspace/ceph-master/src/include/denc.h:1162:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:1169:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:1236:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
