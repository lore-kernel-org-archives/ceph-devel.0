From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v3] ceph: add new obj copy OSD Op
Date: Mon, 18 Nov 2019 08:12:39 -0500
Message-ID: <3dc2df0ba5776fb0f7aaac3a099a938823ed0ebf.camel@kernel.org>
References: <20191118120935.7013-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118120935.7013-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2019-11-18 at 12:09 +0000, Luis Henriques wrote:
> Hi,
> 
> Before going ahead with a pull-request for ceph I would like to make sure
> we're all on the same page regarding the final fix for this problem.
> Thus, following this email, I'm sending 2 patches: one for ceph OSDs and
> the another for the kernel client.
> 
> * osd: add new 'copy-from-notrunc' operation
>   This patch shall be applied to ceph master after reverting commit
>   ba152435fd85 ("osd: add flag to prevent truncate_seq copy in copy-from
>   operation").  It adds a new operation that will be exactly the same as
>   the original 'copy-from' operation, but with the extra 2 parameters
>   (truncate_{seq,size})
> 
> * ceph: switch copy_file_range to 'copy-from-notrunc' operation
>   This will make the kernel client use the new OSD op in
>   copy_file_range.  One extra thing that could probably be added is
>   changing the mount options to NOCOPYFROM if the first call to
>   ceph_osdc_copy_from() fails.
> 

I probably wouldn't change the mount options to be different from what
was initially specified. How about just disable copy_file_range
internally for that superblock, and then pr_notice a message that says
that copy_file_range is being autodisabled. If they mount with '-o
nocopyfrom' that will make the warning go away.

> Does this look good, or did I missed something from the previous
> discussion?
> 
> (One advantage of this approach: the OSD patch can be easily backported!)
> 

Yep, I think this looks like a _much_ simpler approach to the problem.
-- 
Jeff Layton <jlayton@kernel.org>
