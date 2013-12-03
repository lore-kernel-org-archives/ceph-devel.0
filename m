From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Osd magic detection failure in master
Date: Tue, 03 Dec 2013 15:42:48 +1300
Message-ID: <529D4528.3050901@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51944 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab3LCCmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Dec 2013 21:42:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 4EFD96780A
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:42:50 +1300 (NZDT)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tl7AbhXCUHNV for <ceph-devel@vger.kernel.org>;
	Tue,  3 Dec 2013 15:42:48 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:222:4dff:fe88:a586] (unknown [IPv6:2404:130:0:1000:222:4dff:fe88:a586])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 36AF867816
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:42:48 +1300 (NZDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I just updated master (a5eda4fcc34461dbc0fcc47448f8456097de15eb), and am 
seeing OSDs failing to start:

2013-12-03 15:37:01.291200 7f488e1157c0 -1 OSD magic  != my ceph osd 
volume v026
failed: 'ulimit -n 32768;  /usr/bin/ceph-osd -i 0 --pid-file 
/var/run/ceph/osd.0.pid -c /etc/ceph/ceph.conf '

Now it appears that the magic is not being read. It is however there and 
seemingly ok:

$ cat /var/lib/ceph/osd/ceph-0/magic
ceph osd volume v026

Looking at src/osd/OSD.cc I wonder if something like this is needed (as 
it seems that magic is being assigned to an empty val otherwise):

--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -731,7 +731,7 @@ int OSD::peek_meta(ObjectStore *store, std::string& 
magic,
  {
    string val;

-  int r = store->read_meta("magic", &magic);
+  int r = store->read_meta("magic", &val);
    if (r < 0)
      return r;
    magic = val;


This makes the osd's start ok, but the mon does not detect  them 
(possibly another issue or my patch is wrong). I'll keep looking :-)

Cheers

Mark
