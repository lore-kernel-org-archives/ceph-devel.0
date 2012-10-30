From: hemant surale <hemant.surale@gmail.com>
Subject: Unable to Start Ceph service
Date: Tue, 30 Oct 2012 18:29:24 +0530
Message-ID: <CAGfy=6m7yJwVzVuFCZrHqe8tvcnYvkU7w7rieZuo4s7duQV5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37951 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab2J3M7Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 08:59:25 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so225465vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 05:59:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,
   I am building ceph from sourcecode availavle from site. I executeed
all steps for building it , executed "mkcephfs" as well the only
problem is as shown below.


------------------------------------------------------------------------------------------------------------
root@atish-virtual-machine:~/ceph# service ceph start
=== mon.alpha ===
Starting Ceph mon.alpha on atish-virtual-machine...
bash: /usr/bin/ceph-mon: Is a directory
failed: ' /usr/bin/ceph-mon -i alpha --pid-file
/var/run/ceph/mon.alpha.pid -c /etc/ceph/ceph.conf '
-----------------------------------------------------------------------------------------------------------------------



Can you please guide me .

-
Hemant Surale.
