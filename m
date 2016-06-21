From: Michael Wyraz <michael@wyraz.de>
Subject: Problems with cephfs, rsync and xattr because cephfs internal xattrs
 are exposed to clients.
Date: Tue, 21 Jun 2016 22:34:08 +0200
Message-ID: <5769A4C0.70905@wyraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vpsprod2.wyraz.de ([188.68.49.93]:39227 "EHLO mail.wyraz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcFUVAy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jun 2016 17:00:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.wyraz.de (Postfix) with ESMTP id DD8118E5E8
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 22:34:28 +0200 (CEST)
Received: from mail.wyraz.de ([127.0.0.1])
	by localhost (mail.wyraz.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cw4rM915t6Ks for <ceph-devel@vger.kernel.org>;
	Tue, 21 Jun 2016 22:34:09 +0200 (CEST)
Received: from [192.168.1.178] (p57851CFB.dip0.t-ipconnect.de [87.133.28.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.wyraz.de (Postfix) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 22:34:09 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I do rsync based backups against a cephfs. If I do sync xattrs, rsync 
tries to delete ceph-internal xattrs (e.g. ceph.dir.entries) which fails 
with an error. xattrs does not get synchronized in this case.
IMO the problem is, that ceph's internal attributes are exposed to the 
mounted fileystem (I can do "getfattr -n ceph.dir.entries *" on the 
mounted cephfs and get results). So rsync sees these xattrs and tries to 
remove it.

Example output:

    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.entries")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.files")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.subdirs")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rentries")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rfiles")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rsubdirs")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rbytes")
    failed: Operation not supported (95)
    rsync: rsync_xal_set:
    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rctime")
    failed: Operation not supported (95)

Kind regards,
Michael.

