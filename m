From: Travis Rhoden <trhoden@gmail.com>
Subject: how to monitor journal utilization
Date: Wed, 20 Jun 2012 15:24:04 -0400
Message-ID: <CACkq2mo=3_6QSbeSJvaEdhfkv5A-jQOgnF8UqzEtqfpKXYUKOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63971 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab2FTTYZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 15:24:25 -0400
Received: by bkcji2 with SMTP id ji2so6575338bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 12:24:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is there a way I can monitor the utilization of the OSD journal?  I
would like to know if data is coming in fast enough to fill the
journal, and thus slow down all the subsequent writes.

Once the journal is full, that becomes the bottleneck for writes, no?
(assuming that writes to the journal are faster than the OSD -- such
as with tmpfs or an SSD.  I'm using tmpfs).

Thanks,

Travis
