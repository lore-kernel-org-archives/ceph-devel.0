From: Samuel Just <sjust@redhat.com>
Subject: hammer mon failure
Date: Tue, 5 Jan 2016 11:55:38 -0800
Message-ID: <CAN=+7FVaMHKft1F1qcAw_s9oDTBWMAPj4LJRWYLpBcTz6MrquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33751 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcAETzi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jan 2016 14:55:38 -0500
Received: by mail-ig0-f175.google.com with SMTP id z14so15028475igp.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jan 2016 11:55:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: joao@suse.de
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/14236

New hammer mon failure in the nightlies (missing a map apparently?),
can you take a look?
-Sam
