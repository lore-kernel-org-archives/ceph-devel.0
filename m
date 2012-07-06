From: Gregory Farnum <greg@inktank.com>
Subject: Re: Can I try CEPH on top of the openstack Essex ?
Date: Fri, 6 Jul 2012 09:30:30 -0700
Message-ID: <CAPYLRzhyGQRtPJCMxT0zjqf40acYnysf+e6+oTTv6dYfhvQEBQ@mail.gmail.com>
References: <9743ACA5DB1D1F4A8FBA468F7F143EF0275F2167@ECS-EXG-P-MB06.win.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57489 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab2GFQac (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 12:30:32 -0400
Received: by lbbgm6 with SMTP id gm6so15531699lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 09:30:30 -0700 (PDT)
In-Reply-To: <9743ACA5DB1D1F4A8FBA468F7F143EF0275F2167@ECS-EXG-P-MB06.win.lanl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Hb" <hbchen@lanl.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 6, 2012 at 8:29 AM, Chen, Hb <hbchen@lanl.gov> wrote:
> Hi,
> Can I try CEPH on top of the openstack/Swift Object store (Essex release) ?

Nope! CephFS is heavily dependent on the features provided by the
RADOS object store (and so is RBD, if that's what you're interested
in).
If you wanted to try it out[1] with an OpenStack cluster while only
handling a single pool of storage, you could use RADOS and the RADOS
Gateway, which speaks the Swift APIs.
-Greg
[1]: Though you should remember that CephFS is not production-ready yet.
