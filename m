From: Potapov Sergey <s.potapov@rambler-co.ru>
Subject: Memory usage of librados
Date: Tue, 24 Dec 2013 06:36:48 +0000
Message-ID: <409CEB1649811749B2E36961BEE2DDBC2936D908@MBX2.rambler.ramblermedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailrelay1.rambler.ru ([81.19.66.239]:64133 "EHLO
	mailrelay1.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab3LXGlz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Dec 2013 01:41:55 -0500
Received: from esx3.rambler.ramblermedia.com (unknown [81.19.73.86])
	by mailrelay1.rambler.ru (Postfix) with ESMTP id 3dpSQ91368zJ7F
	for <ceph-devel@vger.kernel.org>; Tue, 24 Dec 2013 10:36:49 +0400 (MSK)
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi!

I`am accessing to Ceph cluster via librados and found that memory usage (VSZ in ps) is extremely increases on writing/reading/removing objects. If I successively write+read+remove the object with the same name, then memory usage is not increased, but if I do the same operations with the different object names then VSZ increases up to 4G and stops at this level. It seems that some internal buffering is enabled, can I configure the maximum size of them? Memory usage is very critical for me and I want to reduce it as much as possible.

Operations write+read+stat+remove in loop with different object names:
lion@kubuntu-12:~$ ps aux | grep RADOS
lion      7890  0.2  0.0 4289264 3988 ?        Sl   10:28   0:00 /home/lion/Projects/RMS/TestRADOS/TestRADOS

Operations write+read+stat+remove in loop with one object name:
lion@kubuntu-12:~$ ps aux | grep RADOS
lion      8149  0.1  0.0 556424  3520 ?        Sl   10:30   0:00 /home/lion/Projects/RMS/TestRADOS/TestRADOS

Listing of test program: http://pastebin.com/idqt1PEv

