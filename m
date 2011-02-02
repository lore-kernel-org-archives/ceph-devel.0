From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Simple test system not working
Date: Wed, 2 Feb 2011 02:39:20 +0000 (UTC)
Message-ID: <loom.20110202T021600-867@post.gmane.org>
References: <loom.20110201T072445-567@post.gmane.org> <4D4890C3.3060408@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53206 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab1BBCje (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Feb 2011 21:39:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkSd3-0005rh-Kz
	for ceph-devel@vger.kernel.org; Wed, 02 Feb 2011 03:39:33 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 03:39:33 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 03:39:33 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Samuel Just <samuelj <at> hq.newdream.net> writes:
> From the logs, it looks like the osd and mds are failing to bind to
> an address.  Perhaps b3 is not a valid host name?

Thanks!

That wasn't it (b3 is valid), but you started me looking at the
networking side of things again (for the nth time) and this time
around I noticed there was no loopback interface on the box. That in
itself was odd, although it didn't immediately spring to mind that the
lack of a loopback would stop ceph working. But I added a loopback
anyway on the basis of "avoid oddness" and that got it all going. I
still don't know why a loopback is required for ceph, but apparently
it is!

FYI, with it working, the osd and mds are still bound to the wildcard
address rather than to a specific address (as they were before the
loopback was installed).  Without loopback:

# lsof -n -i | egrep 'COMMAND|cmon|cmds|cosd'
COMMAND    PID    USER   FD   TYPE DEVICE SIZE NODE NAME
cmon      3321    root    5u  IPv4   8451       TCP 10.200.63.129:6789 (LISTEN)
cmds      3357    root    4u  IPv4   8465       TCP *:6800 (LISTEN)
cmds      3357    root    5u  IPv4  10044       TCP
10.200.63.129:59480->10.200.63.129:6789 (SYN_SENT)
cosd      3466    root    3u  IPv4   8548       TCP *:6801 (LISTEN)
cosd      3466    root    5u  IPv4   8549       TCP *:6802 (LISTEN)
cosd      3466    root    6u  IPv4   8550       TCP *:6803 (LISTEN)
cosd      3466    root   13u  IPv4  10046       TCP
10.200.63.129:59481->10.200.63.129:6789 (SYN_SENT)

Note that the DEVICE number for the SYN_SENT connections keeps
changing in this situation.

With the loopback:

# lsof -n -i | egrep 'COMMAND|cmon|cmds|cosd'
COMMAND    PID    USER   FD   TYPE DEVICE SIZE NODE NAME
cmon      6633    root    5u  IPv4  13277       TCP 10.200.63.129:6789 (LISTEN)
cmon      6633    root    6u  IPv4  14353       TCP
10.200.63.129:6789->10.200.63.129:32884 (ESTABLISHED)
cmon      6633    root    7u  IPv4  13367       TCP
10.200.63.129:6789->10.200.63.129:32883 (ESTABLISHED)
cmds      6669    root    4u  IPv4  13294       TCP *:6800 (LISTEN)
cmds      6669    root    5u  IPv4  13366       TCP
10.200.63.129:32883->10.200.63.129:6789 (ESTABLISHED)
cmds      6669    root   10u  IPv4  13456       TCP
10.200.63.129:41828->10.200.63.129:6801 (ESTABLISHED)
cosd      6741    root    3u  IPv4  14350       TCP *:6801 (LISTEN)
cosd      6741    root    5u  IPv4  14351       TCP *:6802 (LISTEN)
cosd      6741    root    6u  IPv4  14352       TCP *:6803 (LISTEN)
cosd      6741    root   13u  IPv4  13401       TCP
10.200.63.129:32884->10.200.63.129:6789 (ESTABLISHED)
cosd      6741    root   14u  IPv4  14467       TCP
10.200.63.129:6801->10.200.63.129:41828 (ESTABLISHED)




Cheers,

Chris.


