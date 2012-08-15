From: John Axel Eriksson <john@insane.se>
Subject: What's the default data dir for radosgw?
Date: Wed, 15 Aug 2012 12:21:58 +0200
Message-ID: <CAMmJxtL24JkuYUNo5SPRArXoq0yF=i6Gkzu0SXjP=z+5W_CO=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52851 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2HOKV7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 06:21:59 -0400
Received: by vcbfk26 with SMTP id fk26so1289453vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Aug 2012 03:21:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I found somewhere that it's supposed to be
/var/lib/ceph/radosgw/ceph-$id. Ok in my case I guess that would mean:
/var/lib/ceph/radosgw/ceph-client.radosgw.gateway would that be
correct? Since I need to store the keyring in that directory for
example and I want to use the defaults.

John
