From: Ken Dreyer <kdreyer@redhat.com>
Subject: jerasure packaging and Ceph
Date: Fri, 7 Aug 2015 11:25:48 -0600
Message-ID: <55C4EA1C.3080601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419AbbHGRZw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Aug 2015 13:25:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,

I was looking through Ceph's bundled libraries recently and I was
wondering why Ceph bundles its own copy of jerasure.

Could you give some background on that? Why don't we link to an separate
system package?

- Ken
