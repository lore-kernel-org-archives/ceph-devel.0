From: Amon Ott <a.ott@m-privacy.de>
Subject: OSD deadlock with cephfs client and OSD on same machine
Date: Tue, 29 May 2012 09:44:33 +0200
Message-ID: <201205290944.33983.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:58545 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868Ab2E2Hoo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 03:44:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id B212E62541
	for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:44:39 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 28360-09 for <ceph-devel@vger.kernel.org>;
 Tue, 29 May 2012 09:44:32 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 8431862540
	for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:44:32 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 08FB1202C9
	for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:44:34 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello again!

On Linux, if you run OSD on ext4 filesystem, have a cephfs kernel clien=
t mount=20
on the same system and no syncfs system call (as to be expected with li=
bc6 <=20
2.14 or kernel < 2.6.39), OSD deadlocks in sys_sync(). Only reboot reco=
vers=20
the system.

After some investigation in the code, this is what I found:
In src/common/sync_filesystem.h, the function sync_filesystem() first t=
ries a=20
syncfs() (not available), then a btrfs ioctrl sync (not available with=20
non-btrfs), then finally a sync(). sys_sync tries to sync all filesyste=
ms,=20
including the journal device, the osd storage area and the cephfs mount=
=2E=20
Under some load, when OSD calls sync(), cephfs sync waits for the local=
 osd,=20
which already waits for its storage to sync, which the kernel wants to =
do=20
after the cephfs sync. Deadlock.

The function sync_filesystem() is called by FileStore::sync_entry() in=20
src/os/FileStore.cc, but only on non-btrfs storage and if=20
filestore_fsync_flushes_journal_data is false. After forcing this to tr=
ue in=20
OSD config, our test cluster survived three days of heavy load (and sti=
ll=20
running fine) instead of deadlocking all nodes within an hour. Reproduc=
ed=20
with 0.47.2 and kernel 3.2.18, but the related code seems unchanged in=20
current master.

Conclusion: If you want to run OSD and cephfs kernel client on the same=
 Linux=20
server and have a libc6 before 2.14 (e.g. Debian's newest in experiment=
al is=20
2.13) or a kernel before 2.6.39, either do not use ext4 (but btrfs is s=
till=20
unstable) or risk data loss by missing syncs through the workaround of=20
forcing filestore_fsync_flushes_journal_data to true.

Please consider putting out a fat warning at least at build time, if sy=
ncfs()=20
is not available, e.g. "No syncfs() syscall, please expect a deadlock w=
hen=20
running osd on non-btrfs together with a local cephfs mount." Even bett=
er=20
would be a quick runtime test for missing syncfs() and storage on non-b=
trfs=20
that spits out a warning, if deadlock is possible.

As a side effect, the experienced lockup seems to be a good way to repr=
oduce=20
the long standing bug 1047 - when our cluster tried to recover, all MDS=
=20
instances died with those symptoms. It seems that a partial sync of jou=
rnal=20
or data partition causes that broken state.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
