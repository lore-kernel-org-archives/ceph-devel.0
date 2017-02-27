From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
Subject: Extend list of known distributions?
Date: Mon, 27 Feb 2017 16:40:05 +0300
Message-ID: <409b9481-4928-c5ea-8b00-ddb739f8ff96@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:45827 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdB0Nln (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 08:41:43 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1RDfFS2030879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 13:41:15 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1RDeEiW011123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 13:40:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v1RDeDRF004898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 13:40:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v1RDeDtc031161
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 13:40:13 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

Is it possible to add Oracle Linux[1] into list of Ceph known distributions?
If so what is correct procedure to do it?

Oracle Linux provide API/ABI compatibility with RHEL so not many changes 
required. Mostly in right distro detection.

[1]https://linux.oracle.com

WBR, Nikita.

