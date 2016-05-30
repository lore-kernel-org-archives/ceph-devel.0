From: Tim Serong <tserong@suse.com>
Subject: Does calamari-crush-location do anything useful?
Date: Tue, 31 May 2016 00:29:23 +1000
Message-ID: <574C4E43.6050203@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:56406 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbcE3O3n (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 30 May 2016 10:29:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I've got some alleged errors during OSD startup:

ceph-osd-prestart.sh[29360]: ERROR:calamari_osd_location:Error 2 running
ceph config-key get:'Error ENOENT: error obtaining
'daemon-private/osd.0/v1/calamari/osd_crush_location': (2) No such file
or directory'

The above appears twice, but doesn't seem to actually cause any harm
(the OSD starts fine).  Manually invoking
`/usr/bin/calamari-crush-location --id 0 --type osd` gives the same
errors, but *does* print "host=ses2-1" (the default host in my case) to
STDOUT.

The errors are there because
"daemon-private/osd.0/v1/calamari/osd_crush_location" was never set by
anything, so can't be found by `ceph config-key get`.  AFAICT the only
time this *would* be set is if someone has used the calamari REST API to
move an OSD in the CRUSH map (this functionality doesn't seem to be
exposed in Romana), and then only if they were operating on the
immediate parent node of an OSD (or some OSDs).

So, my question is, what's the point?  `calamari-crush-location` will
only return data from
"daemon-private/osd.$ID/v1/calamari/osd_crush_location" if the stored
location is on the current host, but under what real-world circumstances
would "daemon-private/osd.0/v1/calamari/osd_crush_location" exist and
include anything other than a hostname anyway?  I'm obviously missing
something, but it looks like the whole thing essentially amounts to a
NOOP with some annoying error messages :)

Thanks,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
