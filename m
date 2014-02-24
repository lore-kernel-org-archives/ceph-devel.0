From: Jean-Charles LOPEZ <jc.lopez@inktank.com>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 12:59:13 -0800
Message-ID: <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46981 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbaBXU7Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 15:59:16 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so1728417pbb.28
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 12:59:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Weil Sage <sage@inktank.com>
Cc: LOPEZ Jean-Charles <jc.lopez@inktank.com>, ceph-devel@vger.kernel.org

Hi Sage,

I think this is a great idea.

However, I would recommend that two options to be available:
1) First options is a standalone package as you describe it
2) Second option is a prepackaged VM in OVA format people can just download and import using VirtualBox, Fusion or VMWarePlayer.

I can take care of the second option and prepare an OVA for you using the base I already have.

JC
jc.lopez@inktank.com


On Feb 23, 2014, at 12:30, Sage Weil <sage@inktank.com> wrote:

> One idea kicking around is to create a simple ceph-standalone package that 
> is meant to make it really easy to play around with Ceph.  It would:
> 
> - depend on all the relevant ceph packages
> - install a simple, generic ceph.conf for use on localhost (or perhaps 
> whatever /etc/hosts has for our hostname)
> - mkfs and start up a mon
> - start up an osd (or two?) in /var/lib/ceph (no dedicated disk/volume)
> - start an mds
> - add an apache2 site in /etc/apache2/sites-available (or whatever)
> 
> The idea would be to do
> 
> $ sudo apt-get install ceph-standalone
> $ ceph -s
> [...]
> 
> and have a usable mini-cluster.  That makes it really easy for users to 
> play with the basics, like:
> 
> $ mkdir /mnt/ceph
> $ sudo ceph-fuse /mnt/ceph
> 
> $ rbd create ...
> $ rbd map ...
> 
> $ curl http://localhost:8000/
> <more rgw stuff>
> 
> Does this sound useful?  Any takers?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

