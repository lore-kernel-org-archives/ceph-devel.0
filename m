From: Sage Weil <sage@newdream.net>
Subject: Re: RPM build errors: Bad exit status from /var/tmp/rpm-tmp.s5lEiY
  (%install)
Date: Mon, 2 Aug 2010 09:19:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008020918490.14285@cobra.newdream.net>
References: <AANLkTimdgrE3h+uRbWr+tcu7Ds6O5_Je4Y4ssXacJhwh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48451 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab0HBQQz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 12:16:55 -0400
In-Reply-To: <AANLkTimdgrE3h+uRbWr+tcu7Ds6O5_Je4Y4ssXacJhwh@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2 Aug 2010, Xiaoguang Liu wrote:
> I am building rpm for ceph 0.21 and encountered error as below:
> 
> here is what I did:
> 
> 1.  download 0.21 from http://ceph.newdream.net/download/ceph-0.21.tar.gz
> 2. uncompress
> 3. ./autogen && ./configure
> 4. copy ceph.spec into my SPECS folder
> 5. copy ceph-0.21.tar.gz into SOURCES folder
> 6. rpmbuild -ba ceph.spec
> 
> 
> make[1]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21/man'
> make[1]: Entering directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
> make[2]: Entering directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
> make[2]: Nothing to be done for `install-exec-am'.
> make[2]: Nothing to be done for `install-data-am'.
> make[2]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
> make[1]: Leaving directory `/home/lxg/src/rpm/BUILD/ceph-0.21'
> + find /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64 -type f
> -name '*.la' -exec rm -f '{}' ';'
> + find /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64 -type f
> -name '*.a' -exec rm -f '{}' ';'
> + install -D src/init-ceph
> /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/rc.d/init.d/ceph
> + chmod 0644 /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/ceph/sample.ceph.conf
> + install -m 0644 -D debian/ceph.logrotate
> /home/lxg/src/rpm/BUILDROOT/ceph-0.21-4.fc13.x86_64/etc/logrotate.d/ceph
> install: cannot stat `debian/ceph.logrotate': No such file or directory
> error: Bad exit status from /var/tmp/rpm-tmp.s5lEiY (%install)

Oh, debian/ isn't in the release tarball.  This will be fixed in 0.21.1.  
In the meantime, you can build the rpm from a git checkout.

sage
