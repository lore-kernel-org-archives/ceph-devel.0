From: Jeff Layton <jlayton@kernel.org>
Subject: Re: Help understanding xfstest generic/467 failure
Date: Tue, 12 May 2020 11:33:13 -0400
Message-ID: <ef6459452ab8156d69e2b41b35f3d388d7a3197c.camel@kernel.org>
References: <878shx190r.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgELPdP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 May 2020 11:33:15 -0400
In-Reply-To: <878shx190r.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 2020-05-12 at 16:13 +0100, Luis Henriques wrote:
> Hi Jeff,
> 
> I've been looking at xfstest generic/467 failure in cephfs, and I simply
> can not decide if it's a genuine bug on ceph kernel code.  Since you've
> recently been touching the ceph_unlink code maybe you could help me
> understanding what's going on.
> 
> generic/467 runs a couple of tests using src/open_by_handle, but the one
> failing can be summarized with the following:
> 
> - get a handle to /cephfs/myfile using name_to_handle_at(2)
> - open(2) file /cephfs/myfile
> - unlink(2) /cephfs/myfile
> - drop caches
> - open_by_handle_at(2) => returns -ESTALE
> 
> This test succeeds opening the handle with other (local) filesystems
> (maybe I should run it with other networked filesystem such as NFS).
> 
> The -ESTALE is easy to trace to __fh_to_dentry, where inode->i_nlink is
> checked against 0.  My question is: should we really be testing the
> i_nlink here?  We dropped the name, but the file may still be there (as in
> this case).
> 
> I guess I'm missing something, but hopefully you'll be able to shed some
> light on this.  Thanks in advance for any help you may provide!

Yeah, I took a brief look at this a while back and never got back to
looking at it again. I think cephfs's behavior is wrong here. We should
be able to look up an open-but-unlinked file by filehandle.

That said those checks went in via commit 570df4e9c23f8, and it looks
like it was deliberately added to __fh_to_dentry. I'm unclear as to why.
It may be interesting to remove the i_nlink checks and see whether it
breaks anything?

-- 
Jeff Layton <jlayton@kernel.org>
