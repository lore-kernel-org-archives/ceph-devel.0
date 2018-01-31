From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 1/1] quota: report root dir quota usage in statfs
Date: Wed, 31 Jan 2018 09:38:58 +0000
Message-ID: <20180131093858.zlu6nf7x3lps5t2n@hermes.olymp>
References: <20180130114530.26266-1-lhenriques@suse.com>
 <20180130114530.26266-2-lhenriques@suse.com>
 <76B7F300-DCB5-434A-944F-3EA6BFF03E72@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbeAaJi6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:38:58 -0500
Content-Disposition: inline
In-Reply-To: <76B7F300-DCB5-434A-944F-3EA6BFF03E72@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:00:51PM +0800, Yan, Zheng wrote:
> > +	if (fsc->mount_options->flags & CEPH_MOUNT_OPT_NOQUOTADF ||
> 
>  if ((fsc->mount_options->flags & CEPH_MOUNT_OPT_NOQUOTADF) ||

Ok, fair enough.

> > +	    !ceph_quota_update_statfs(fsc, buf)) {
> > +		buf->f_blocks = le64_to_cpu(st.kb) >> (CEPH_BLOCK_SHIFT-10);
> > +		buf->f_bfree = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
> > +		buf->f_bavail = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
> > +	}
> > 
> > 	buf->f_files = le64_to_cpu(st.num_objects);
> > 	buf->f_ffree = -1;
> > @@ -151,6 +160,7 @@ enum {
> > 	Opt_acl,
> > #endif
> > 	Opt_noacl,
> > +	Opt_noquotadf,
> 
> please also add quotadf option  

Hmm.. ok.  Since the default behaviour (with this patch) is to show
quota stats when running 'df' I assumed this wouldn't be required.  But
yeah, I guess I can add an option that explicitly does a

	fsopt->flags &= ~CEPH_MOUNT_OPT_NOQUOTADF;

I'll send out a v2.

Cheers,
--
Luís
