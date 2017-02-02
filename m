From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 12/13] ceph: call update_dentry_lease even when
 r_locked dir is not set
Date: Thu, 02 Feb 2017 06:27:05 -0500
Message-ID: <1486034825.2812.2.camel@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
         <20170201114914.20808-1-jlayton@redhat.com>
         <20170201114914.20808-13-jlayton@redhat.com>
         <9C301416-E09E-43E0-B2A3-427FB5009060@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35029 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdBBL1H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 06:27:07 -0500
Received: by mail-qt0-f171.google.com with SMTP id x49so24164766qtc.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 03:27:07 -0800 (PST)
In-Reply-To: <9C301416-E09E-43E0-B2A3-427FB5009060@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com

On Thu, 2017-02-02 at 16:34 +0800, Yan, Zheng wrote:
> > On 1 Feb 2017, at 19:49, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > We don't really require that the parent be locked in order to update the
> > lease on a dentry. Lease info is protected by the d_lock. In the event
> > that the parent is not locked in ceph_fill_trace, and we have both
> > parent and target info, go ahead and update the dentry lease.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> > fs/ceph/inode.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 15e042a8d71f..87863f962d50 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1345,6 +1345,16 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> > 			goto done;
> > 		}
> > 		req->r_dentry = dn;  /* may have spliced */
> > +	} else if (rinfo->head->is_dentry && rinfo->head->is_target) {
> > +		if ((le32_to_cpu(rinfo->diri.in->cap.caps) & CEPH_CAP_FILE_SHARED) ||
> > +		    le32_to_cpu(rinfo->dlease->duration_ms)) {
> > +			vino.ino = le64_to_cpu(rinfo->diri.in->ino);
> > +			vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
> > +			update_dentry_lease(req->r_dentry, rinfo->dlease,
> > +				session, req->r_request_started, &vino);
> > +		} else {
> > +			dout("%s: no dentry lease or dir cap\n", __func__);
> > +		}
> > 	}
> 
> I think checking rinfo->head->is_target is not needed here, because null dentry can also have lease.
> Besides, I think we need to check if rinfo->head->is_target matches d_really_is_negative(dn) and if
> the target inode matches d_inode(dn).
> 

Yeah, I think you're right here. I'll respin this one.
-- 
Jeff Layton <jlayton@redhat.com>
