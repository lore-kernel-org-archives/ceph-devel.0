From: Yuri Weinstein <yweinste@redhat.com>
Subject: Fwd: [Ceph-qa] Failed to schedule teuthology-2017-10-27_01:15:05-upgrade:hammer-x-jewel-distro-basic-vps
Date: Thu, 26 Oct 2017 18:37:55 -0700
Message-ID: <CAMMFjmF7rXaQSsPy-Gdbqu=aYYF5A-RD_iEph=meGGVtwDN1kQ@mail.gmail.com>
References: <20171027011507.0272665312CE6@teuthology-new.front.sepia.ceph.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:51079 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdJ0Bh5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 21:37:57 -0400
Received: by mail-oi0-f47.google.com with SMTP id q4so8743737oic.7
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 18:37:57 -0700 (PDT)
In-Reply-To: <20171027011507.0272665312CE6@teuthology-new.front.sepia.ceph.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Deza, Alfredo" <adeza@redhat.com>, "Weil, Sage" <sage@redhat.com>

jewel on centos build was failing for several days

https://shaman.ceph.com/builds/ceph/jewel/

"[urllib3.connectionpool][DEBUG ] https://4.chacra.ceph.com:443 "HEAD
/binaries/ceph/jewel/cbaddaeed73b9d1efbd3eb750459e5024556b344/centos/7/x86_64/flavors/default/librados2-10.2.10-14-gcbaddae-0.el7.x86_64.rpm/
HTTP/1.1" 404 0
[chacractl][ERROR ] RuntimeError: HEAD for
https://4.chacra.ceph.com/binaries/ceph/jewel/cbaddaeed73b9d1efbd3eb750459e5024556b344/centos/7/x86_64/flavors/default/librados2-10.2.10-14-gcbaddae-0.el7.x86_64.rpm/
failed: 404 resource does not exist"

https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/11851//consoleFull

---------- Forwarded message ----------
From:  <ceph-qa@ceph.com>
Date: Thu, Oct 26, 2017 at 6:15 PM
Subject: [Ceph-qa] Failed to schedule
teuthology-2017-10-27_01:15:05-upgrade:hammer-x-jewel-distro-basic-vps
To: ceph-qa@ceph.com


Failed to fetch package version from
https://shaman.ceph.com/api/search/?status=ready&project=ceph&flavor=default&distros=centos%2F7%2Fx86_64&sha1=cbaddaeed73b9d1efbd3eb750459e5024556b344
_______________________________________________
Ceph-qa mailing list
Ceph-qa@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
