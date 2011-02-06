From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: mkcephfs: clean up temp files, honor $TEMPDIR
Date: Mon, 7 Feb 2011 02:33:54 +1300
Message-ID: <AANLkTimDUUKq4EAEQdu4E6PKAvp4VP4NEK3GJ20ttnty@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:8045 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab1BFNd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Feb 2011 08:33:59 -0500
Received: by vxb37 with SMTP id 37so1239332vxb.19
        for <ceph-devel@vger.kernel.org>; Sun, 06 Feb 2011 05:33:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Colin McCabe <cmccabe@alumni.cmu.edu>

Hi all:

commit 09c38e8edadb3a5bf470ff9b0409172e0c61e012
About introducing the new tmp directory.

TDIR=`mktemp -d -t mkcephfs.XXXXXXXXXX` || exit 1
trap "rm -rf ${TDIR}; exit" INT TERM EXIT

I think this works if running all on the same nodes.
but other nodes don't know this directory name as they don't yet have
this newly (and randomly) created directory.

e.g., while mkcephfs output
=== osd.0 ===
scp: /tmp/mkcephfs.BIvhX1RQOG/osdmap.4176: No such file or directory
scp: /tmp/mkcephfs.BIvhX1RQOG/monmap.4176: No such file or directory
...
so it will fail. A quick fix is to create the directory before scping to osds.

diff mkcephfs /usr/local/sbin/mkcephfs

193,194c193,194
< 	scp -q $osdmap $host:$osdmap
< 	scp -q $monmap $host:$monmap
---
> 	ssh $host mkdir -p $TDIR; scp -q $osdmap $host:$osdmap
> 	ssh $host mkdir -p $TDIR; scp -q $monmap $host:$monmap

I initially thought that the below statement further down the line
if [ "$type" = "osd" ]; then
... scp $TDIR/keyring.osd.$id $user@$host:$keyring ...

caused the $TDIR to be missing, but the missing tmp directory was
alerted back in the line 193.
(It seems the script is able to be started on any nodes, but I'm a bit confused)

Also, in the line 193, scp -q $conf $host:$conf
I don't think we check whether nodes have config directory, e.g., for
-c /etc/ceph/ceph.conf, we don't check /etc/ceph directory?
and so the other custom directory would also fail, too I think.

Thanks
