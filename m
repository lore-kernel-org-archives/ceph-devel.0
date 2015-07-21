From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: upstream/firefly exporting the same snap 2 times results in different
 exports
Date: Tue, 21 Jul 2015 14:29:46 +0200
Message-ID: <55AE3B3A.2040902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52888 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbGUM3s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 08:29:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i remember there was a bug before in ceph not sure in which release
where exporting the same rbd snap multiple times results in different
raw images.

Currently running upstream/firefly and i'm seeing the same again.


# rbd export cephstor/disk-116@snap dump1
# sleep 10
# rbd export cephstor/disk-116@snap dump2

# md5sum -b dump*
b89198f118de59b3aa832db1bfddaf8f *dump1
f63ed9345ac2d5898483531e473772b1 *dump2

Can anybody help?

Greets,
Stefan
