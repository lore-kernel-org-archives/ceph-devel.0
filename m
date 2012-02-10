From: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Problem with inconsistent PG
Date: Fri, 10 Feb 2012 08:43:21 +0100
Message-ID: <4F34CA99.6020905@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:60090 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab2BJHnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 02:43:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: oliver.francke@filoo.de

Hi Liste,

today i've got another problem.

ceph -w shows up with an inconsistent PG over night:

2012-02-10 08:38:48.701775    pg v441251: 1982 pgs: 1981 active+clean, 1
active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
GB avail
2012-02-10 08:38:49.702789    pg v441252: 1982 pgs: 1981 active+clean, 1
active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
GB avail

I've identified it with "ceph pg dump - | grep inconsistent

109.6    141    0    0    0    463820288    111780    111780   
active+clean+inconsistent    485'7115    480'7301    [3,4]    [3,4]   
485'7061    2012-02-10 08:02:12.043986

Now I've tried to repair it with: ceph pg repair 109.6

2012-02-10 08:35:52.276325 mon <- [pg,repair,109.6]
2012-02-10 08:35:52.276776 mon.1 -> 'instructing pg 109.6 on osd.3 to
repair' (0)

but i only get the following result:

2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455420 osd.3
10.10.10.8:6801/25980 6913 : [ERR] 109.6 osd.4: soid
1ef398ce/rb.0.0.0000000000bd/headsize 2736128 != known size 3145728
2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455426 osd.3
10.10.10.8:6801/25980 6914 : [ERR] 109.6 scrub 0 missing, 1 inconsistent
objects
2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455799 osd.3
10.10.10.8:6801/25980 6915 : [ERR] 109.6 scrub 1 errors

Can someone please explain me what to do in this case and how to recover
the pg ?

Thanks a lot !

Jens
