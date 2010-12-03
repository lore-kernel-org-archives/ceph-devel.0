From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Odd "data used" reporting behavior by ceph -w
Date: Fri, 3 Dec 2010 14:39:59 -0700
Message-ID: <1291412399.4879.288.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:42360 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0LCVkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 16:40:12 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1A45947EFD2
	for <ceph-devel@vger.kernel.org>; Fri,  3 Dec 2010 14:40:05 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm seeing some odd behavior that suggests that space doesn't
get released back to the storage pool unless a file is
truncated - unlinking it doesn't seem do it.  This is based on
the data use reported by ceph -w.

Maybe I don't understand what I'm seeing below,
or what is supposed to happen?

Steps to reproduce:

1) create/start/mount a new file system; ceph -w reports:

2010-12-03 13:14:34.027320    pg v52: 3432 pgs: 3432 active+clean; 162 KB data, 54252 KB used, 2986 GB / 3013 GB avail
(lots of scrub activity)
2010-12-03 13:19:38.379998    pg v164: 3432 pgs: 3432 active+clean; 162 KB data, 41728 KB used, 2986 GB / 3013 GB avail

2) create 64 files with a total of 4096 MiB data; ceph -w reports:

2010-12-03 13:21:42.645536    pg v262: 3432 pgs: 3432 active+clean; 4096 MB data, 6383 MB used, 2980 GB / 3013 GB avail
2010-12-03 13:21:47.615336    pg v263: 3432 pgs: 3432 active+clean; 4096 MB data, 6401 MB used, 2980 GB / 3013 GB avail
(lots of scrub activity)
2010-12-03 13:27:41.818799    pg v499: 3432 pgs: 3432 active+clean; 4096 MB data, 8259 MB used, 2978 GB / 3013 GB avail

3) truncate above files to zero length 
(e.g. for f in $flist; do echo -n "" > /mnt/ceph/$f; done)
ceph -w reports:

2010-12-03 13:28:57.909734    pg v552: 3432 pgs: 3432 active+clean; 1018 KB data, 8280 MB used, 2978 GB / 3013 GB avail
(lots of scrub activity)
2010-12-03 13:34:05.856985    pg v602: 3432 pgs: 3432 active+clean; 1018 KB data, 3167 MB used, 2983 GB / 3013 GB avail

Maybe I should have waited longer, for more scrubbing,
to see the used space drop further?

4) recreate files, same size/name as step 2);

Note that this step takes _much_ longer: 1448 sec vs. 41 sec.
Maybe redirecting stdout onto a file from an echo of nothing
is a really stupid way to truncate a file, but still...
seems like something might not be right?

At the end, ceph -w reports:

2010-12-03 13:59:18.031146    pg v3902: 3432 pgs: 3432 active+clean; 4097 MB data, 8574 MB used, 2978 GB / 3013 GB avail
(lots of scrub activity)
2010-12-03 14:05:33.016532    pg v3971: 3432 pgs: 3432 active+clean; 4097 MB data, 8595 MB used, 2978 GB / 3013 GB avail

5) rm all files; ceph -w reports:

2010-12-03 14:06:08.287086    pg v3993: 3432 pgs: 3432 active+clean; 4033 MB data, 8596 MB used, 2978 GB / 3013 GB avail
(lots of scrub activity)
2010-12-03 14:12:29.090263    pg v4139: 3432 pgs: 3432 active+clean; 4033 MB data, 8520 MB used, 2978 GB / 3013 GB avail

Should the space reported as used here get returned
to the available pool eventually?  Should I have
waited longer?

6) unmount file system on all clients; ceph -w reports:

(lots of scrub activity)
2010-12-03 14:15:04.119015    pg v4232: 3432 pgs: 3432 active+clean; 1730 KB data, 4213 MB used, 2982 GB / 3013 GB avail


7) remount file system on all clients; ceph -w reports:

2010-12-03 14:16:28.238805    pg v4271: 3432 pgs: 3432 active+clean; 1754 KB data, 1693 MB used, 2985 GB / 3013 GB avail


Hopefully the above is useful.  They were
generated on unstable (63fab458f625) + rc (378d13df9505)
+ testing (1a4ad835de66) branches.

-- Jim



