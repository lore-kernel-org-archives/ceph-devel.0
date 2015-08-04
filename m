From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Civetweb and mg_set_http_status
Date: Tue, 4 Aug 2015 17:11:07 -0600
Message-ID: <20150804171107.171dec7c@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbHDXLI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 19:11:08 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id CBEBE19F22C
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2015 23:11:08 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@redhat.com, ceph-devel@vger.kernel.org

I did a "git pull" today and now the build breaks like this:

  CXX      rgw/libcivetweb_la-rgw_civetweb.lo
rgw/rgw_civetweb.cc: In member function 'virtual int RGWMongoose::send_status(const char*, const char*)':
rgw/rgw_civetweb.cc:147:38: error: 'mg_set_http_status' was not declared in this scope
   mg_set_http_status(conn, status_num);
                                      ^
It comes from this:

commit b8e28ab9f914bf48c9ba4f0def9a0deb9dbb93bc
Author: Yehuda Sadeh <yehuda@redhat.com>
Date:   Wed Jul 22 10:01:00 2015 -0700

    rgw: set http status in civetweb
    
    Need to set the http status in civetweb so that we report it correctly.
    Fixes: #12432
    
    Signed-off-by: Yehuda Sadeh <yehuda@redhat.com>

I suspect my civetweb may be obsolete. The "cd src/civetweb && git tag -l"
returns v1.5. Do I need a magic git incantation to refresh submodules?

Thanks in advance,
-- Pete
