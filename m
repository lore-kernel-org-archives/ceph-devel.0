From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 9 Aug 2012 09:54:46 -0700
Message-ID: <CADvuQRFe+DrQ6thSvj+4DP_g7WCioyveJCVRESME2DtUgNhQ6A@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com> <5023E9FD.2060501@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51486 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab2HIQzM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 12:55:12 -0400
Received: by vbbff1 with SMTP id ff1so163342vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 09:55:07 -0700 (PDT)
In-Reply-To: <5023E9FD.2060501@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 9, 2012 at 9:49 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> And where can I find this new "OSD hotplugging" style init? Is there any
> documentation?

mkcephfs does not use the new style. The Chef cookbooks we have do. If
you use the Juju Charms that Canonical has been working on, those
should also use the new way now.

Here's the installation documents using Chef:
http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/
