From: Ken Dreyer <kdreyer@redhat.com>
Subject: excluding /var/lib/ceph in updatedb.conf
Date: Wed, 20 May 2015 16:33:41 -0600
Message-ID: <555D0BC5.7030403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbbETWdo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 May 2015 18:33:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,

I watched your OpenStack Summit conference where you talked about
excluding /var/lib/ceph from /etc/updatedb.conf.

Did you open any bugs for that? That change seems like something we
should get into the distros.

- Ken
