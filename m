From: Ken Dreyer <kdreyer@redhat.com>
Subject: firewall questions
Date: Wed, 20 May 2015 14:07:46 -0600
Message-ID: <555CE992.10703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbbETUHs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 May 2015 16:07:48 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4KK7lTO030460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 16:07:47 -0400
Received: from mbp.ktdreyer.com (vpn-62-178.rdu2.redhat.com [10.10.62.178])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4KK7lX1015568
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 16:07:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It would be really convenient to have human-readable firewalld service
definitions for Ceph, so that users could do things like:

  firewall-cmd --add-service=ceph-mon

or

  firewall-cmd --add-service=ceph

... instead of having to know specific port numbers to open.

In order to submit service definitions to firewalld upstream, I had a
couples questions:

1. In April there was a mailing list thread about the IANA #821110
ticket Sage filed for ceph-mon. Did anything come of that? I filed
http://tracker.ceph.com/issues/11689 to track this in Redmine.

2. I talked recently with Sam about the possible ports an OSD could use,
and our conversation made me think that our firewall docs for OSDs and
MDSs might need to be updated: http://tracker.ceph.com/issues/11688

Currently the docs say "calculate the number of OSDs or MDSs you're
running and that will tell you what ports to open". That makes it hard
to write a service definition for firewalld, since those are just a list
of static ports.

3. Lastly, on a scale of "yeah, sounds do-able" to "everything will come
to a grinding halt", how hard would it be to run with firewalls enabled
in our sepia and typica labs that are running Teuthology? :) Do our
Teuthology tests use TCP ports outside of 80, 6789, and 6800-7300 ?

- Ken
