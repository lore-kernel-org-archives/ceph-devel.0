From: Maciej Bonin <maciej.bonin@m247.com>
Subject: Re: Flapping osd / continuously reported as failed
Date: Fri, 24 Jan 2014 12:29:48 +0000 (UTC)
Message-ID: <loom.20140124T132806-603@post.gmane.org>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet> <CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com> <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet> <CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com> <0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet> <ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet> <CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com> <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet> <CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com> <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9F0@MXMBON06.grupa.onet> <CAPYLRzjTmLG_DY4EbmDwndSg5x6ZBznbavxOoU_+Wxh1q8OcYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40769 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbaAXMfI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jan 2014 07:35:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1W6fyR-0007rc-Ei
	for ceph-devel@vger.kernel.org; Fri, 24 Jan 2014 13:35:03 +0100
Received: from office-gw.m247.com ([89.238.157.212])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jan 2014 13:35:03 +0100
Received: from maciej.bonin by office-gw.m247.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jan 2014 13:35:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Gregory Farnum <greg@...> writes:

> 
> On Mon, Aug 19, 2013 at 3:09 PM, Mostowiec Dominik
> <Dominik.Mostowiec@...> wrote:
> > Hi,
> >> Yes, it definitely can as scrubbing takes locks on the PG, which will 
prevent reads or writes while the
> message is being processed (which will involve the rgw index being 
scanned).
> > It is possible to tune scrubbing config for eliminate slow requests and 
marking osd down when large rgw
> bucket index is scrubbing?
> 
> Unfortunately not, or we would have mentioned it before. :/ There are
> some proposals for sharding bucket indexes that would ameliorate this
> problem, and on Cuttlefish or Dumpling the OSD won't get marked down,
> but it will still block incoming requests on that object (ie, requests
> to access the bucket) while the scrubbing is in place.
> That said, that improvement might be sufficient since you haven't
> actually shown us how long the object scrub takes.
> -Greg
> Software Engineer #42  <at>  http://inktank.com | http://ceph.com
> 


Hello Guys,

I just wanted to share that we've had a similar problem and we had solved it 
by borrowing sensible kernel option defaults from a radosgw patch iirc.
net.ipv4.ip_local_port_range = 1024 65535
net.core.netdev_max_backlog = 30000
net.core.somaxconn = 4096
net.ipv4.tcp_max_syn_backlog = 252144
net.ipv4.tcp_max_tw_buckets = 360000
net.ipv4.tcp_fin_timeout = 3
net.ipv4.tcp_max_orphans = 262144
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2


Regards,
Maciej Bonin
Systems Engineer
m247.com
ISO 27001 Data Protection Classification: A - Public

