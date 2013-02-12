From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: slow requests, hunting for new mon
Date: Tue, 12 Feb 2013 19:15:56 +1100
Message-ID: <20130212081556.GA18957@onthe.net.au>
References: <20130212072815.GA17655@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:50145 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab3BLIP7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 03:15:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id BFEF260E8F
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 19:15:57 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+ORzl-giWPA for <ceph-devel@vger.kernel.org>;
	Tue, 12 Feb 2013 19:15:57 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 24A4A60DE6
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 19:15:57 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id D1E932AB74F
	for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 19:16:40 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20130212072815.GA17655@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, Feb 12, 2013 at 06:28:15PM +1100, Chris Dunlop wrote:
> Hi,
> 
> What are likely causes for "slow requests" and "monclient: hunting for new
> mon" messages? E.g.:
> 
> 2013-02-12 16:27:07.318943 7f9c0bc16700  0 monclient: hunting for new mon
> ...
> 2013-02-12 16:27:45.892314 7f9c13c26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.383883 secs
> 2013-02-12 16:27:45.892323 7f9c13c26700  0 log [WRN] : slow request 30.383883 seconds old, received at 2013-02-12 16:27:15.508374: osd_op(client.9821.0:122242 rb.0.209f.74b0dc51.000000000120 [write 921600~4096] 2.981cf6bc) v4 currently no flag points reached
> 2013-02-12 16:27:45.892328 7f9c13c26700  0 log [WRN] : slow request 30.383782 seconds old, received at 2013-02-12 16:27:15.508475: osd_op(client.9821.0:122243 rb.0.209f.74b0dc51.000000000120 [write 987136~4096] 2.981cf6bc) v4 currently no flag points reached
> 2013-02-12 16:27:45.892334 7f9c13c26700  0 log [WRN] : slow request 30.383720 seconds old, received at 2013-02-12 16:27:15.508537: osd_op(client.9821.0:122244 rb.0.209f.74b0dc51.000000000120 [write 1036288~8192] 2.981cf6bc) v4 currently no flag points reached
> 2013-02-12 16:27:45.892338 7f9c13c26700  0 log [WRN] : slow request 30.383684 seconds old, received at 2013-02-12 16:27:15.508573: osd_op(client.9821.0:122245 rb.0.209f.74b0dc51.000000000122 [write 1454080~4096] 2.fff29a9a) v4 currently no flag points reached
> 2013-02-12 16:27:45.892341 7f9c13c26700  0 log [WRN] : slow request 30.328986 seconds old, received at 2013-02-12 16:27:15.563271: osd_op(client.9821.0:122246 rb.0.209f.74b0dc51.000000000122 [write 1482752~4096] 2.fff29a9a) v4 currently no flag points reached

Sorry, I forgot to add what lead me to look into this in the first place...

The b2 machine is running a number of libvirt / kvm virtuals on rbd via
librados:

    <disk type='network' device='disk'>
      <driver name='qemu' type='raw'/>
      <auth username='xxxxxx'>
        <secret type='ceph' uuid='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'/>
      </auth>
      <source protocol='rbd' name='rbd/foo:rbd_cache=1'/>
      <target dev='vdb' bus='virtio'/>
      <alias name='virtio-disk1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </disk>

Around the time the "slow requests" messages pop up, the virtual machines experience
a spike in disk latency, e.g. from inside one of the virtuals:

                    load %user %nice  %sys  %iow  %stl %idle  dev rrqm/s wrqm/s    r/s    w/s    rkB/s    wkB/s arq-sz aqu-sz  await  rwait wwait %util
2013-02-12-18:55:23  1.7   0.3   0.0   0.9  42.2   0.0  18.5  vdb    0.0   25.8    0.0    9.6     0.00   136.53  28.44   1.34 139.56   0.00 139.6  70.7
2013-02-12-18:55:38  1.5   0.9   0.0   0.4  35.8   0.0  42.8  vdb    0.0   26.6    0.0   10.8     0.00   143.20  26.52   0.46  41.98   0.00  42.0  40.0
2013-02-12-18:55:53  1.4   0.7   0.0   0.4  38.0   0.0  51.7  vdb    0.0    7.5    0.0    6.8     0.00    53.33  15.69   0.46  68.08   0.00  68.1  38.8
2013-02-12-18:56:10  2.2   0.0   0.0   0.1   8.0   0.0  15.8  vdb    0.0    2.1    0.0    0.2     0.00     9.18  78.00   0.98 4164.00   0.00 4164.0  70.6
2013-02-12-18:56:32  3.7   0.0   0.0   0.1   0.0   0.0   0.0  vdb    0.0    0.1    0.0    0.8     0.00     3.27   8.00  24.12 14519.78   0.00 14519.8 100.0
2013-02-12-18:56:47  5.1   0.5   0.0   0.6   0.0   0.0   0.0  vdb    0.0   11.5    0.0    5.4     0.00    65.87  24.40   1.60 3620.15   0.00 3620.1  88.4
2013-02-12-18:57:03  5.2   0.6   0.0   1.1   3.5   0.0   0.0  vdb    0.0   19.6    0.0    6.9     0.00   101.25  29.19   1.13 162.41   0.00 162.4  87.4
2013-02-12-18:57:20  5.2   0.6   0.0   0.9   9.7   0.0   0.0  vdb    0.0   44.6    0.0    9.7     0.00   214.82  44.27   2.41 248.22   0.00 248.2  85.3
2013-02-12-18:57:36  4.4   0.4   0.0   0.5  28.7   0.0  46.5  vdb    0.0   17.6    0.0    5.2     0.00    87.50  33.33   0.56 107.14   0.00 107.1  48.5

...corresponding to this in the b5 / osd.1 log:

2013-02-12 18:52:08.812880 7f9c0bc16700  0 monclient: hunting for new mon
2013-02-12 18:55:18.851791 7f9c0bc16700  0 monclient: hunting for new mon
2013-02-12 18:56:25.414948 7f9c13c26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.372124 secs
2013-02-12 18:56:25.414958 7f9c13c26700  0 log [WRN] : slow request 30.372124 seconds old, received at 2013-02-12 18:55:55.042767: osd_op(client.9821.0:144779 rb.0.209f.74b0dc51.000000000023 [write 1593344~4096] 2.1882ddb7) v4 currently no flag points reached
...
2013-02-12 18:57:13.427008 7f9c13c26700  0 log [WRN] : slow request 40.721769 seconds old, received at 2013-02-12 18:56:32.705190: osd_op(client.9821.0:146756 rb.0.209f.74b0dc51.000000000128 [write 819200~8192] 2.b4390173) v4 currently commit sent
2013-02-12 18:59:43.886517 7f9c0bc16700  0 monclient: hunting for new mon
2013-02-12 19:02:53.911641 7f9c0bc16700  0 monclient: hunting for new mon


Cheers,

Chris.
