From: Travis Rhoden <trhoden@gmail.com>
Subject: possible to recover a deleted RBD?
Date: Mon, 10 Sep 2012 16:55:10 -0400
Message-ID: <CACkq2moAQhOoSYw2+=d3G7xy-CuKdNFWMirH9KzuwRr7piefGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63835 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab2IJUzb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 16:55:31 -0400
Received: by qcro28 with SMTP id o28so1435489qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 13:55:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I sheepishly must ask -- is there any way to recover a deleted RBD?

The RBD was created using the Linux 3.2 kernel client, running 0.48.1.
 Removed with "rbd rm -p rbd <name>".

I expect the answer to be no, but wanted to check for sure!

Thanks,

Travis
