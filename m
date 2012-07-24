From: Josh Durgin <josh.durgin@inktank.com>
Subject: creating rbd snapshots via sysfs
Date: Tue, 24 Jul 2012 14:22:11 -0700
Message-ID: <500F1203.9050605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60616 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab2GXVWO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 17:22:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so203230pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 14:22:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Right now the kernel still has one piece of rbd management duplicated
from the rbd command line tool: snapshot creation. There's nothing
special about snapshot creation that makes it advantageous to do
from the kernel, so I'd like to remove the create_snap sysfs interface.
That is, /sys/bus/rbd/devices/<id>/create_snap would be removed.

Does anyone rely on the sysfs interface for creating rbd snapshots?
If so, how hard would it be to replace with:

   rbd snap create pool/image@snap

Is there any benefit to the sysfs interface that I'm missing?

Josh
