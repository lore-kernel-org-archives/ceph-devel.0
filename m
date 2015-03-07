From: Daniel Swarbrick <daniel.swarbrick@gmail.com>
Subject: Re: Prioritize Heartbeat packets
Date: Sun, 08 Mar 2015 00:23:02 +0100
Message-ID: <mdg18n$gsj$1@ger.gmane.org>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>	<ltmnkp$tod$1@ger.gmane.org> <CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40399 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbbCGXZJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 7 Mar 2015 18:25:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YUO5g-0002HT-GC
	for ceph-devel@vger.kernel.org; Sun, 08 Mar 2015 00:25:04 +0100
Received: from f053014240.adsl.alicedsl.de ([78.53.14.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2015 00:25:04 +0100
Received: from daniel.swarbrick by f053014240.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2015 00:25:04 +0100
In-Reply-To: <CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@lists.ceph.com

Judging by the commit, this ought to do the trick:

osd heartbeat use min delay socket = true

On 07/03/15 01:20, Robert LeBlanc wrote:
> I see that Jian Wen has done work on this for 0.94. I tried looking
> through the code to see if I can figure out how to configure this new
> option, but it all went over my head pretty quick.
>
> Can I get a brief summary on how to set the priority of heartbeat
> packets or where to look in the code to figure it out?
>
> Thanks,
>
> On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
> <daniel.swarbrick@profitbricks.com
> <mailto:daniel.swarbrick@profitbricks.com>> wrote:
>
>     On 28/08/14 02:56, Sage Weil wrote:
>     > I seem to remember someone telling me there were hooks/hints you could
>     > call that would tag either a socket or possibly data on that socket with a
>     > label for use by iptables and such.. but I forget what it was.
>     >
>
>     Something like setsockopt() SO_MARK?
>
>             *SO_MARK *(since Linux 2.6.25)
>                    Set the mark for each packet sent through this socket
>     (similar
>                    to the netfilter MARK target but socket-based).
>     Changing the
>                    mark can be used for mark-based routing without
>     netfilter or
>                    for packet filtering.  Setting this option requires the
>                    *CAP_NET_ADMIN *capability.
>
>     Alternatively, directly set IP_TOS options on the socket, or SO_PRIORITY
>     which sets the IP TOS bits as well.
>
>
>     _______________________________________________
>     ceph-users mailing list
>     ceph-users@lists.ceph.com
>     <mailto:ceph-users@lists.ceph.com>
>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


