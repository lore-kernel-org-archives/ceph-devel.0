From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 0/5 v2] Improve Ceph Qemu+RBD support
Date: Fri, 7 Oct 2011 13:17:36 +0100
Message-ID: <20111007121735.GF31228@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
 <1317987590.3149.5.camel@wido-desktop>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab1JGMRp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Oct 2011 08:17:45 -0400
Content-Disposition: inline
In-Reply-To: <1317987590.3149.5.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Oct 07, 2011 at 01:39:50PM +0200, Wido den Hollander wrote:
> Hi,
> 
> On Mon, 2011-09-19 at 21:13 -0700, Sage Weil wrote:
> > The current support for qemu and Ceph RBD (rados block device) has two 
> > main deficiencies: authentication doesn't work, and it relies on 
> > environment variables (which don't work with latest upstream). This 
> > patch set addresses both those problems.
> > 
> 
> Authentication is something that is really needed in the libvirt
> implementation of RBD.
> 
> The interest in RBD is growing rapidly, but without auth support it's
> kind of useless.
> 
> Would like to see this implemented!

Apologies for not reviewing this patch series before now. It accidentally
slipped off my todo list. I'll aim to take a look at in at the start
of next week


Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
