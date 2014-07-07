From: Luis Pabon <lpabon@redhat.com>
Subject: Cache tier READ_FORWARD transition
Date: Mon, 07 Jul 2014 12:29:55 -0400
Message-ID: <53BACB03.5010603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbaGGQ34 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jul 2014 12:29:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s67GTuJi015576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Mon, 7 Jul 2014 12:29:56 -0400
Received: from localhost.localdomain (vpn-61-233.rdu2.redhat.com [10.10.61.233])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s67GTtNn027776
	for <ceph-devel@vger.kernel.org>; Mon, 7 Jul 2014 12:29:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,
     I am working on OSDMonitor.cc:5325 and wanted to confirm the 
following read_forward cache tier transition:

     readforward -> forward || writeback || (any && num_objects_dirty == 0)
     forward -> writeback || readforward || (any && num_objects_dirty == 0)
     writeback -> readforward || forward

Is this the correct cache tier state transition?

- Luis
