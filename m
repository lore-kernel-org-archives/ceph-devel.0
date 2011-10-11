From: Sage Weil <sage@newdream.net>
Subject: Re: osd deployment affects samba read performance
Date: Tue, 11 Oct 2011 08:34:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110110830050.20977@cobra.newdream.net>
References: <CABAwU-afNz4NDyKAGz+9OiFH57WQ0AsPi4HCOTM6B+OjAnsoYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46845 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1JKPeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 11:34:03 -0400
In-Reply-To: <CABAwU-afNz4NDyKAGz+9OiFH57WQ0AsPi4HCOTM6B+OjAnsoYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 11 Oct 2011, huang jun wrote:
> hi,all
> Recently, we test the samba read performance,and find something strange.
> there are two groups to test:
> the cluster include 1 MON and 1 MDS,and
> 1) 2 OSDs on the same machine
> 2) 2 OSDs on the different machine
> when we use samba to test read,
> in the first condition  it is about 110MB/s, but in the second
> condition it is only 60MB/s.
> 
> we anlysed it from the debug log /var/log/ceph/osd.*.log,
> in the condition 1), the OSD spends about 7~8ms (from sending
> osd_op_reply to getting the next client read request)
> but in 2) we spends about 12~14ms.

The osd_op_reply message shows up in the osd log when the message is 
queued.  Since these are reads, the messages are large (they carry the 
data payload), and will take more time to send over the wire when passing 
over the network.

It sounds like the problem is that only a single read is being issued at a 
time (i.e. readahead isn't working).  Are you using the kernel client or 
libceph/cfuse?  Readahead was only recently fixed in the kernel client.  
The patches are in the master branch of ceph-client.git, but are not yet 
upstream; they should be merged in 3.2-rc1 in the upcoming merge window.

sage
