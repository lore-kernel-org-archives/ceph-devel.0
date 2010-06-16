From: Peter Niemayer <niemayer@isg.de>
Subject: "umount" of ceph filesystem that has become unavailable hangs forever
Date: Wed, 16 Jun 2010 17:35:18 +0200
Message-ID: <hvaqvm$fdp$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37572 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab0FPPf3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 11:35:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OOueF-0000Rz-NW
	for ceph-devel@vger.kernel.org; Wed, 16 Jun 2010 17:35:27 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 17:35:27 +0200
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 17:35:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

trying to "umount" a formerly mounted ceph filesystem that has become
unavailable (osd crashed, then msd/mon were shut down using 
/etc/init.d/ceph stop) results in "umount" hanging forever in
"D" state.

Strangely, "umount -f" started from another terminal reports
the ceph filesystem as not being mounted anymore, which is consistent
with what the mount-table says.

The kernel keeps emitting the following messages from time to time:
> Jun 16 17:25:29 gitega kernel: ceph:  tid 211912 timed out on osd0, will reset osd
> Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 connection failed
> Jun 16 17:26:15 gitega last message repeated 4 times

I would have expected the "umount" to terminate at least after some 
generous timeout.

Ceph should probably support something like the "soft,intr" options
of NFS, because if the only supported way of mounting is one where
a client is more or less stuck-until-reboot when the service fails,
many potential test-configurations involving Ceph are way too dangerous
to try...

Regards,

Peter Niemayer


