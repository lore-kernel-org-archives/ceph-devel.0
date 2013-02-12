From: Chris Dunlop <chris@onthe.net.au>
Subject: slow requests, hunting for new mon
Date: Tue, 12 Feb 2013 18:28:15 +1100
Message-ID: <20130212072815.GA17655@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:51937 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab3BLHfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 02:35:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id EBA6C61258
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 18:28:16 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYW-remsImSa for <ceph-devel@vger.kernel.org>;
	Tue, 12 Feb 2013 18:28:15 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id A31FC60E8F
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 18:28:15 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 3F1012ABDA5
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 18:28:59 +1100 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

What are likely causes for "slow requests" and "monclient: hunting for new
mon" messages? E.g.:

2013-02-12 16:27:07.318943 7f9c0bc16700  0 monclient: hunting for new mon
...
2013-02-12 16:27:45.892314 7f9c13c26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.383883 secs
2013-02-12 16:27:45.892323 7f9c13c26700  0 log [WRN] : slow request 30.383883 seconds old, received at 2013-02-12 16:27:15.508374: osd_op(client.9821.0:122242 rb.0.209f.74b0dc51.000000000120 [write 921600~4096] 2.981cf6bc) v4 currently no flag points reached
2013-02-12 16:27:45.892328 7f9c13c26700  0 log [WRN] : slow request 30.383782 seconds old, received at 2013-02-12 16:27:15.508475: osd_op(client.9821.0:122243 rb.0.209f.74b0dc51.000000000120 [write 987136~4096] 2.981cf6bc) v4 currently no flag points reached
2013-02-12 16:27:45.892334 7f9c13c26700  0 log [WRN] : slow request 30.383720 seconds old, received at 2013-02-12 16:27:15.508537: osd_op(client.9821.0:122244 rb.0.209f.74b0dc51.000000000120 [write 1036288~8192] 2.981cf6bc) v4 currently no flag points reached
2013-02-12 16:27:45.892338 7f9c13c26700  0 log [WRN] : slow request 30.383684 seconds old, received at 2013-02-12 16:27:15.508573: osd_op(client.9821.0:122245 rb.0.209f.74b0dc51.000000000122 [write 1454080~4096] 2.fff29a9a) v4 currently no flag points reached
2013-02-12 16:27:45.892341 7f9c13c26700  0 log [WRN] : slow request 30.328986 seconds old, received at 2013-02-12 16:27:15.563271: osd_op(client.9821.0:122246 rb.0.209f.74b0dc51.000000000122 [write 1482752~4096] 2.fff29a9a) v4 currently no flag points reached

I have a ceph 0.56.2 system with 3 boxes: two boxes have both mon and a
single osd, and the 3rd box has just a mon - see ceph.conf below. The boxes
are running an eclectic mix of self-compiled kernels: b2 is linux-3.4.6, b4
is linux-3.7.3 and b5 is linux-3.6.10.

On b5 / osd.1 the 'hunting' message appears in the osd log regularly, e.g.
190 times yesterday. The message does't appear at all on b4 / osd.0.

Both osd logs show the 'slow requests' messages. Generally these come in
waves, with 30-50 of the associated individual 'slow request' messages
coming in just after the initial 'slow requests' message. Each box saw
around 30 waves yesterday, with no obvious time correlation between the two.

The osd disks are generally cruising along at around 400-800 KB/s, with
occasional spikes up to 1.2-2 MB/s, with a mostly write load.

The gigabit network interfaces (2 per box for public vs cluster) are
also cruising, with the busiest interface at less than 5% utilisation.

CPU utilisation is likewise small, with 90% or more idle and less then 3%
wait for io. There's plenty of free memory, 19 GB on b4 and 6 GB on b5.

Cheers,

Chris

----
ceph.conf
----
[global]
        auth supported = cephx
[mon]
[mon.b2]
        host = b2
        mon addr = 10.200.63.130:6789
[mon.b4]
        host = b4
        mon addr = 10.200.63.132:6789
[mon.b5]
        host = b5
        mon addr = 10.200.63.133:6789
[osd]
        osd journal size = 1000
        public network = 10.200.63.0/24
        cluster network = 192.168.254.0/24
[osd.0]
        host = b4
        public addr = 10.200.63.132
        cluster addr = 192.168.254.132
[osd.1]
        host = b5
        public addr = 10.200.63.133
        cluster addr = 192.168.254.133
----
