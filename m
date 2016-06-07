From: "Willem Jan Withagen (EcoRacks)" <wjw@ecoracks.nl>
Subject: Not getting coverage out of ceph-disk/run-tox.sh
Date: Tue, 7 Jun 2016 12:09:39 +0200
Message-ID: <0dbc78c6-8b0a-32b5-a55d-c6ee5eb6ba70@ecoracks.nl>
Reply-To: wjw@ecoracks.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:33901 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbcFGKaW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jun 2016 06:30:22 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 9FE9C153401
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2016 12:20:30 +0200 (CEST)
Received: from smtp.digiware.nl ([127.0.0.1])
	by rack1.digiware.nl (rack1.digiware.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBSgnk2M-2aQ for <ceph-devel@vger.kernel.org>;
	Tue,  7 Jun 2016 12:20:20 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2] (unknown [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 2882D15340D
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2016 12:09:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

My testrun on FreeBSD delivers:
====
tests/ceph-disk.sh:438: run:  status=0
tests/ceph-disk.sh:439: run:  set +x
py27 runtests: commands[3] | coverage report --omit=*test*,*tox*
--show-missing
Name    Stmts   Miss  Cover   Missing
-------------------------------------
No data to report.
ERROR: InvocationError:
'/usr/srcs/Ceph/work.wip-wjw-freebsd-tests-2/ceph/src/ceph-disk/.tox/py27/bin/coverage
report --omit=*test*,*tox* --show-missing'
___________________________________ summary
____________________________________
  flake8: commands succeeded
ERROR:   py27: commands failed
FAIL ceph-disk/run-tox.sh (exit status: 1)
====

So the script went fine, except for coverage getting its info. And thus
the final result is ERROR.
Why is coverage not generating the stats?
It says no data to report... but why?

thanx,
--WjW

This is what it should look like....
tests/ceph-disk.sh:412: run:  status=0
tests/ceph-disk.sh:413: run:  set +x
py27 runtests: commands[3] | coverage report --omit=*test*,*tox*
--show-missing
Name                    Stmts   Miss  Cover   Missing
-----------------------------------------------------
ceph_disk/__init__.py       0      0   100%
ceph_disk/main.py        2299    994    57%   121, 156, 233, 237,
326-330, 337-340, 349-358, 366, 394-396, 447-448, 452-472, 508-511,
515-521, 546-548, 567, 581-590, 594-599, 613-627, 640, 646-650, 654-663,
670-675, 682-694, 698-699, 703-704, 708-713, 720-738, 750, 756, 764-784,
794-809, 822, 825, 844, 848-849, 897, 899, 907, 934-935, 955-960, 964,
973-978, 982, 1000-1003, 1028-1029, 1034, 1038, 1062-1063, 1080,
1094-1099, 1107-1132, 1143-1208, 1214-1226, 1246, 1320-1321, 1331-1361,
1395-1414, 1425-1457, 1461-1483, 1503-1506, 1531, 1533-1536, 1544-1550,
1559, 1639, 1653-1655, 1658-1659, 1665, 1668-1673, 1688, 1694, 1781,
1793, 1801, 1824, 1863, 1869-1873, 1878, 1883-1889, 1896, 1933, 1935,
1939, 1942-1944, 1948-1960, 1964, 1966, 1970, 1973-1987, 1990-2078,
2092, 2106-2112, 2129-2133, 2175-2181, 2205-2210, 2213, 2230-2236,
2239-2252, 2255-2282, 2285-2292, 2295-2309, 2322, 2325, 2328-2355,
2358-2360, 2387, 2435, 2446, 2450, 2455, 2459, 2467-2470, 2474-2519,
2522-2525, 2528-2534, 2537-2550, 2553-2608, 2617, 2620-2624, 2630,
2633-2637, 2720-2736, 2740-2741, 2755-2779, 2794-2854, 2868, 2878-2879,
2890-2897, 2908, 2914-2926, 2930-2934, 2938-2950, 2969-3083, 3093,
3109-3113, 3120-3121, 3135, 3142-3145, 3151-3153, 3167, 3178, 3212,
3247, 3250-3251, 3257-3271, 3282, 3298, 3308-3312, 3316-3321, 3472,
3509-3529, 3537-3538, 3544-3554, 3614-3617, 3628-3658, 3662-3701,
3708-3755, 3766, 3771, 3776-3780, 3793-3794, 3800-3807, 3811, 3815,
3819-3835, 3875-3896, 3900-3905, 3930, 4008-4011, 4137-4147, 4155,
4176-4182, 4186-4195, 4199-4215, 4219, 4223, 4232-4355, 4366, 4917,
4926-4931, 4941-4954, 4967-4968
-----------------------------------------------------
TOTAL                    2299    994    57%
___________________________________ summary
____________________________________
  flake8: commands succeeded
  py27: commands succeeded
  congratulations :)

