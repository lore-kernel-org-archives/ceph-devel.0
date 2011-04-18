From: Christoph Raible <c.raible@science-computing.de>
Subject: Re: mount.ceph: modprobe failed, exit status 127
Date: Mon, 18 Apr 2011 11:50:51 +0000 (UTC)
Message-ID: <loom.20110418T134530-94@post.gmane.org>
References: <4DA82A9E.5010504@science-computing.de> <4DA8409E.9000808@provocation.net> <20110415164315.GA31400@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45589 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab1DRLvH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2011 07:51:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QBmyt-0006vK-A4
	for ceph-devel@vger.kernel.org; Mon, 18 Apr 2011 13:51:03 +0200
Received: from HSI-KBW-095-208-113-104.hsi5.kabel-badenwuerttemberg.de ([95.208.113.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 13:51:03 +0200
Received: from c.raible by HSI-KBW-095-208-113-104.hsi5.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 13:51:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:

> 
> On Fri, Apr 15, 2011 at 02:57:02PM +0200, Zenon Panoussis wrote:
> > > Now when I want to mount a Ceph filesystem with
> > >     mount -t ceph 10.1.9.46:/ /mnt/ceph
> > > I got following error:
> > >     "mount.ceph: modprobe failed, exit status 127"
> > 
> > Since ceph and libceph are already in the kernel, it seems logical that
 loading
> > them would fail; after all, there are no modules to be loaded. Then again,
 it
> > doesn't make sense that mount tries to load them anyway and fails.
> 
> If modprobe didn't find the module, he'd be getting exit status 1.
> 
> If ceph was built-in to the kernel, modprobe would see that and claim
> success.
> 
> Exit status 127 means the command was not found; for some reason, the
> executable "modprobe" is not in PATH when mount.ceph is run.
> 
> Are you perhaps trying to mount as non-root? That's not going to work.
> 


Hi I tried both with root and with a "normal" user.

Both had the same fault. My PATH-Variable looks like this:

/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:
/bin:/usr/sbin:/usr/bin:/root/bin

Is there something missing? When I do "modprobe ceph"  this works fine...

Is it possible that my ceph.conf has an error? 

http://pastebin.com/bhk1EvWm


Best regards,

Christoph


