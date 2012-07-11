From: "Pascal de Bruijn | Unilogic Networks B.V."
	<pascal@unilogicnetworks.net>
Subject: [PATCH] Robustify ceph-rbdnamer and adapt udev rules
Date: Wed, 11 Jul 2012 15:23:16 +0200
Message-ID: <1342012996.5511.27.camel@clawhammer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:34439 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752628Ab2GKN4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Jul 2012 09:56:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: s.kleijkers@unilogic.nl

Below is a patch which makes the ceph-rbdnamer script more robust and
fixes a problem with the rbd udev rules.

On our setup we encountered a symlink which was linked to the wrong rbd:

  /dev/rbd/mypool/myrbd -> /dev/rbd1

While that link should have gone to /dev/rbd3 (on which a
partition /dev/rbd3p1 was present).

Now the old udev rule passes %n to the ceph-rbdnamer script, the problem
with %n is that %n results in a value of 3 (for rbd3), but in a value of
1 (for rbd3p1), so it seems it can't be depended upon for rbdnaming.

In the patch below the ceph-rbdnamer script is made more robust and it
now it can be called in various ways:

  /usr/bin/ceph-rbdnamer /dev/rbd3
  /usr/bin/ceph-rbdnamer /dev/rbd3p1
  /usr/bin/ceph-rbdnamer rbd3
  /usr/bin/ceph-rbdnamer rbd3p1
  /usr/bin/ceph-rbdnamer 3

Even with all these different styles of calling the modified script, it
should now return the same rbdname. This change "has" to be combined
with calling it from udev with %k though.

With that fixed, we hit the second problem. We ended up with:

  /dev/rbd/mypool/myrbd -> /dev/rbd3p1

So the rbdname was symlinked to the partition on the rbd instead of the
rbd itself. So what probably went wrong is udev discovering the disk and
running ceph-rbdnamer which resolved it to myrbd so the following
symlink was created:

  /dev/rbd/mypool/myrbd -> /dev/rbd3

However partitions would be discovered next and ceph-rbdnamer would be
run with rbd3p1 (%k) as parameter, resulting in the name myrbd too, with
the previous correct symlink being overwritten with a faulty one:

  /dev/rbd/mypool/myrbd -> /dev/rbd3p1

The solution to the problem is in differentiating between disks and
partitions in udev and handling them slightly differently. So with the
patch below partitions now get their own symlinks in the following style
(which is fairly consistent with other udev rules):

  /dev/rbd/mypool/myrbd-part1 -> /dev/rbd3p1

Please let me know any feedback you have on this patch or the approach
used.

Regards,
Pascal de Bruijn
Unilogic B.V.

Signed-off-by: Pascal de Bruijn <pascal@unilogicnetworks.net>

--------------------------------------------------------------------------------
diff --git a/src/ceph-rbdnamer b/src/ceph-rbdnamer
index 49350a7..efb6804 100755
--- a/src/ceph-rbdnamer
+++ b/src/ceph-rbdnamer
@@ -1,8 +1,10 @@
 #!/bin/sh
 
-POOL=`cat /sys/devices/rbd/$1/pool`
-IMAGE=`cat /sys/devices/rbd/$1/name`
-SNAP=`cat /sys/devices/rbd/$1/current_snap`
+DEV=$1
+NUM=`echo $DEV | sed 's#p.*##g' | tr -d 'a-z'`
+POOL=`cat /sys/devices/rbd/$NUM/pool`
+IMAGE=`cat /sys/devices/rbd/$NUM/name`
+SNAP=`cat /sys/devices/rbd/$NUM/current_snap`
 if [ "$SNAP" = "-" ]; then
 	echo -n "$POOL $IMAGE"
 else
diff --git a/udev/50-rbd.rules b/udev/50-rbd.rules
index 07f220f..406c31c 100644
--- a/udev/50-rbd.rules
+++ b/udev/50-rbd.rules
@@ -1 +1,2 @@
-KERNEL=="rbd[0-9]*", PROGRAM="/usr/bin/ceph-rbdnamer %n", SYMLINK+="rbd/%c{1}/%c{2}"
+KERNEL=="rbd[0-9]*", ENV{DEVTYPE}=="disk", PROGRAM="/usr/bin/ceph-rbdnamer %k", SYMLINK+="rbd/%c{1}/%c{2}"
+KERNEL=="rbd[0-9]*", ENV{DEVTYPE}=="partition", PROGRAM="/usr/bin/ceph-rbdnamer %k", SYMLINK+="rbd/%c{1}/%c{2}-part%n"



