From: Xiaoguang Liu <syslxg@gmail.com>
Subject: RPM build errors: Bad exit status from /var/tmp/rpm-tmp.s5lEiY
	(%install)
Date: Mon, 2 Aug 2010 22:12:58 +0800
Message-ID: <AANLkTimdgrE3h+uRbWr+tcu7Ds6O5_Je4Y4ssXacJhwh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49276 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0HBONA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 10:13:00 -0400
Received: by vws3 with SMTP id 3so1984942vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 07:12:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am building rpm for ceph 0.21 and encountered error as below:

here is what I did:

1.  download 0.21 from http://ceph.newdream.net/download/ceph-0.21.tar.gz
2. uncompress
3. ./autogen && ./configure
4. copy ceph.spec into my SPECS folder
5. copy ceph-0.21.tar.gz into SOURCES folder
6. rpmbuild -ba ceph.spec


make[1]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21/man'
make[1]: Entering directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
make[2]: Entering directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
make[1]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
+ find /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64 -type f
-name '*.la' -exec rm -f '{}' ';'
+ find /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64 -type f
-name '*.a' -exec rm -f '{}' ';'
+ install -D src/init-ceph
/home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/rc.d/init.d/ceph
+ chmod 0644 /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/ceph/sample.ceph.conf
+ install -m 0644 -D debian/ceph.logrotate
/home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/logrotate.d/ceph
install: cannot stat `debian/ceph.logrotate': No such file or directory
error: Bad exit status from /var/tmp/rpm-tmp.s5lEiY (%install)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.s5lEiY (%install)
