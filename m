From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Latest 0.56.3 and qemu-1.4.0 and cloned VM-image producing massive fs-corruption, not crashing
Date: Fri, 22 Mar 2013 20:09:19 +0100
Message-ID: <76476E24-8C91-4ADB-B0CC-1EC0B218089E@filoo.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:45992 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab3CVTTx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 15:19:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "josh.durgin@inktank.com Durgin" <josh.durgin@inktank.com>

Hi Josh, all,

I did not want to hijack the thread dealing with a crashing VM, but per=
haps there are some common things.

Today I installed a fresh cluster with mkephfs, went fine, imported a "=
master" debian 6.0 image with "format 2", made a snapshot, protected it=
, and made some clones.
Clones mounted with qemu-nbd, fiddled a bit with IP/interfaces/hosts/ne=
t.rules=85etc and cleanly unmounted, VM started, took 2 secs and the VM=
 was up n running. Cool.

Now an ordinary shutdown was performed, made a snapshot of this image. =
Started again, did some "apt-get update=85 install s/t=85".
Shutdown -> rbd rollback -> startup again -> login -> install s/t else=85=
 filesystem showed "many" ex3-errors, fell into read-only mode, massive=
 corruption.

qemu config was with ":rbd_cache=3Dfalse" if it matters. Above scenario=
 is reproducible, and as I stated out, no crash detected.

Perhaps it is in the same area as in the crash-thread, otherwise I will=
 provide logfiles as needed.

Kind regards,

Oliver.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
