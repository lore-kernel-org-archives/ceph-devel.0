From: Xiaoguang Liu <syslxg@gmail.com>
Subject: ceph.spec.in problem in unstable ceph
Date: Wed, 4 Aug 2010 17:18:27 +0800
Message-ID: <AANLkTikzSGtffR3oZAwVNsa5RNtkFXx9HvazFBhf501L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42568 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab0HDJS2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Aug 2010 05:18:28 -0400
Received: by vws3 with SMTP id 3so3922828vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Aug 2010 02:18:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rpmbuild fails at this line:

chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/sample.ceph.conf

I think this is becuase sample.ceph.conf is no longer in /etc/ceph,
but %{_docdir}/,  in unstable .

If I remove this line from spec file, rpmbuild fails at:


RPM build errors:
    File not found:
/root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/sample.ceph.conf
    File not found:
/root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/sample.fetch_config

You may want to fix these two issues.
