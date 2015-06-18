From: David Zafman <dzafman@redhat.com>
Subject: rsyslogd
Date: Thu, 18 Jun 2015 16:13:07 -0700
Message-ID: <55835083.9040908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbbFRXNJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Jun 2015 19:13:09 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 49C22319839
	for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 23:13:09 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel@vger.kernel.org


Greg,

Have you changed anything (log rotation related?) that would uninstall 
or  cause rsyslog to not be able to start?

I'm sometimes seeing machines fail with this error probably in 
teuthology/nuke.py reset_syslog_dir().

CommandFailedError: Command failed on plana94 with status 1: 'sudo rm -f 
-- /etc/rsyslog.d/80-cephtest.conf && sudo service rsyslog restart'


David



