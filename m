From: Wido den Hollander <wido@pcextreme.nl>
Subject: ceph: get_reply unknown tid
Date: Wed, 21 Apr 2010 11:14:15 +0200
Message-ID: <1271841255.3898.18.camel@wido-desktop>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:49873 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0DUJOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Apr 2010 05:14:18 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id 0EA3F8445A
	for <ceph-devel@vger.kernel.org>; Wed, 21 Apr 2010 11:14:16 +0200 (CEST)
Received: from [192.168.6.32] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id 099D46000083
	for <ceph-devel@vger.kernel.org>; Wed, 21 Apr 2010 11:14:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

H
i,

Last night i kept my Ceph cluster online with bonnie++ running on a
Rados Block Device, this caused some errors on the client (i already
sent Yehuda an e-mail about that), but right now i'm experiencing the
same messages with the Ceph filesystem.

To to a more random I/O test i'm downloading about 500GB of small image=
s
to my Ceph filesystem (about 3 miljon files) to my Ceph filesystem.

The rsync started fine but kept stalling and stalling, while my dmesg
was filling up with the following messages:

[ 1875.923024] ceph: get_reply unknown tid 25902 from osd3
[ 1875.924294] ceph: get_reply unknown tid 25905 from osd3
[ 1875.924316] ceph: get_reply unknown tid 25907 from osd3
=2E.
=2E.
[ 2563.040170] ceph:  tid 40963 timed out on osd3, will reset osd
[ 2623.040071] ceph:  tid 40963 timed out on osd3, will reset osd
=2E.
=2E.
[ 2813.209679] ceph: get_reply unknown tid 41671 from osd3
[ 2813.209792] ceph: get_reply unknown tid 41723 from osd3
[ 2813.210610] ceph: get_reply unknown tid 41763 from osd3

root@ceph-client:~# dmesg |grep osd3|wc -l
1065
root@ceph-client:~#

These lines were produced in less then 10 minutes.

Sage recommended my to use a OSD Journal, so right now all my 5 OSD's
are running with a 5GB OSD journal on /dev/sda8

While my writes are stalling and these messages are appearing, reads ar=
e
doing fine, but any new writes stall to.

The load on osd3 is really high, the I/O wait is about 85%, so that
would suggest that the subsystem can't keep up with the writes.

The local disk is a 500GB S-ATA disk (7200RPM) which easily keeps up
with the speed my rsync is going when writing to his local filesystem
directly.

The other 4 OSD's have the same local disk and are running fine, their
I/O wait is about 3%

In the logfile of "osd3" where no errors to be found.

After stalling i killed my "rsync" processes and ran a sync. The sync
took about 15 minutes to flush the buffers while only 55.000 files were
written with a total size of 2.9GB

Now the sync is done the load of osd3 went back to normal again.

I assume even faster disk subsystems would speed this proces up, but
right now all my OSD's have a single 500GB S-ATA disk, which should be
sufficient for these simple tests.

Reproducing these messages is easy, just start writing a lot of small
files to a Ceph filesystem and the OSD messages will appear after about
5 minutes.

Restarting the OSD has affect for about 10 minutes, but eventually the
messages will come back again.

Right now my osd3 is giving these problems, but last night it was osd4
who gave me the same messages.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl





--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
