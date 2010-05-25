From: Dan Carpenter <error27@gmail.com>
Subject: bug report: potential null dereference
Date: Tue, 25 May 2010 11:42:03 +0200
Message-ID: <20100525094202.GE22515@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36820 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab0EYJms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 05:42:48 -0400
Received: by wwe15 with SMTP id 15so1211145wwe.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 May 2010 02:42:47 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

This is a Smatch thing.

fs/ceph/auth.c +220 ceph_handle_auth_reply(55) error: potential null derefence 'ac->ops'.
   211                  /* set up (new) protocol handler? */
   212                  if (ac->protocol && ac->protocol != protocol) {
   213                          ac->ops->destroy(ac);
   214                          ac->protocol = 0;
   215                          ac->ops = NULL;
                                ^^^^^^^^^^^^^^^
	We set ac->ops to NULL here.

   216                  }
   217                  if (ac->protocol != protocol) {
   218                          ret = ceph_auth_init_protocol(ac, protocol);
   219                          if (ret) {
   220                                  pr_err("error %d on auth method %s init\n",
   221                                         ret, ac->ops->name);
                                                    ^^^^^^^^^^^^^^
	We dereference it here.  ceph_auth_init_protocol() can fail
	before re-assigning it.

   222                                  goto out;
   223                          }
   224                  }

regards,
dan carpenter
