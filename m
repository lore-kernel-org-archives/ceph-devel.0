From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 16:28:24 +0200
Message-ID: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50468 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2IKO2Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 10:28:24 -0400
Received: by qcro28 with SMTP id o28so294689qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 07:28:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Every acl operation ending with 403 in PUT.

~# s3 -u test oc
                         Bucket                                  Status
--------------------------------------------------------  -------------=
-------
oc                                                        Access Denied

Anyone know why, and how to enable this bucket ?? Now i have problems
with cluster, because there is no way to upload new file

~# s3 -u getacl oc

ERROR: ErrorAccessDenied


--=20
-----
Regards

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
