From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Mon, 19 Oct 2015 08:52:00 +0200
Message-ID: <20151019065200.GB17460@stefanha-thinkpad.redhat.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
 <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbbJSGwC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Oct 2015 02:52:02 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 3D6ACC0C18A6
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 06:52:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "J. Bruce Fields" <bfields@redhat.com>

On Fri, Oct 16, 2015 at 05:08:17PM -0400, Matt Benjamin wrote:
> One of Sage's possible plans for Manilla integration would use nfs over the new Linux  vmci sockets transport integration in qemu (below) to access Cephfs via an nfs-ganesha server running in the host vm.

Excellent job!  Nice to see you were able to add AF_VSOCK support to
nfs-ganesha so quickly.

I'm currently working on kernel nfsd support and will send the patches
to linux-nfs and CC you.

Stefan
