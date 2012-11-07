From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: SSD journal suggestion
Date: Wed, 7 Nov 2012 13:13:12 +0100
Message-ID: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64672 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2KGMNN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 07:13:13 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so851699eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 04:13:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm evaluating some SSD drives as journal.
Samsung 840 Pro seems to be the fastest in sequential reads and write.

What parameter should I consider for a journal? I think that none of
read benchmark are influent because when dumping journal to disk, the
bottleneck will always be the SAS/SATA write speed. (in this case, the
SSD will never reach it's read best performance)
So, should I evaluate only the write speed when datas are wrote to the
journal ? Sequential or random ?
