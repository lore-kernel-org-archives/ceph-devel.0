From: Chris Dunlop <chris@onthe.net.au>
Subject: Simple test system not working
Date: Tue, 1 Feb 2011 06:48:41 +0000 (UTC)
Message-ID: <loom.20110201T072445-567@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51043 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab1BAGsx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Feb 2011 01:48:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkA2m-0002Gu-RJ
	for ceph-devel@vger.kernel.org; Tue, 01 Feb 2011 07:48:52 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 07:48:52 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 07:48:52 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

I'm just starting with ceph and am having trouble getting a test ceph
installation going on debian lenny with a self-compiled 2.6.37. Ceph
itself is latest unstable (73e76723) compiled using dpkg-buildpackage.
The mon, mds and osd are all on the same machine. The ceph base /data
directory is ext2 mounted with user_xattr.  The ceph filesystem is
created using the attached ceph.conf and:

  /sbin/mkcephfs -v -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k
/etc/ceph/keyring.bin

Once ceph has been started, trying a mount on a (separate) client
machine (2.6.37 kernel) hangs before eventually giving an error:

  # mount -t ceph b3:/ /mnt
  mount error 5 = Input/output error

On the server side, it seems that the cmon isn't accepting connections
from the mds or osd. E.g. repeated instances of this in the osd log,
and similar "mark_down"s in the mds log:

  2011-02-01 17:18:47.463897 4a254950 -- 0.0.0.0:6801/7854 mark_down
10.200.63.129:6789/0 -- 0xca8a00
  2011-02-01 17:18:47.463924 4a254950 -- 0.0.0.0:6801/7854 --> mon0
10.200.63.129:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0xcd9800

The mon log (amongst a whole bunch of other stuff) repeats:

  2011-02-01 17:18:51.445785 42c73950 mon.0@0(leader).mds e1 e1: 0/0/1 up
  2011-02-01 17:18:51.445790 42c73950 mon.0@0(leader).osd e1 e1: 0 osds: 0 up, 0 in

The attached logs.zip has the full logs from one attempted start.

Is there something obvious I'm doing wrong?

Thanks for any assistance!

Chris


