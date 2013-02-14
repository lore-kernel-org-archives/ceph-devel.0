From: Martin Mailand <martin@tuxadero.com>
Subject: osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
Date: Thu, 14 Feb 2013 16:08:15 +0100
Message-ID: <511CFDDF.6080406@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:45230 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759358Ab3BNPIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 10:08:17 -0500
Received: from [172.24.1.68] (yian-ho01.nir.cronon.net [192.166.201.94] (may be forged))
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id r1EF8Fc6022838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 16:08:15 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

I get reproducible this assertion, how can I help to debug it?


-martin

(Lese Datenbank ... 52246 Dateien und Verzeichnisse sind derzeit
installiert.)
Vorbereitung zum Ersetzen von linux-firmware 1.79 (durch
=2E../linux-firmware_1.79.1_all.deb) ...
Ersatz f=FCr linux-firmware wird entpackt ...
osdc/ObjectCacher.cc: In function 'void
ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
tid_t, int)' thread 7f72b7fff700 time 2013-02-14 16:04:48.867285
osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
 ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
 1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned long=
,
unsigned long, int)+0xd68) [0x7f72d4050848]
 2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f72d405742b]
 3: (Context::complete(int)+0xa) [0x7f72d400f9ba]
 4: (librbd::C_Request::finish(int)+0x85) [0x7f72d403f145]
 5: (Context::complete(int)+0xa) [0x7f72d400f9ba]
 6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f72d40241b7]
 7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f72d33db16d]
 8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f72d3444e50]
 9: (()+0x7e9a) [0x7f72d03c7e9a]
 10: (clone()+0x6d) [0x7f72d00f4cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
Aborted
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
