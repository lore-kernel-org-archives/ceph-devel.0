From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by ktime_get_real_ts()
Date: Wed, 03 Feb 2016 22:27:02 +0100
Message-ID: <3267742.ulDeDOimis@wuerfel>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com> <CAAM7YAm6enhGMJd+BMDAuAzXCMxVwb24Ch951A3_ygGUhXivxQ@mail.gmail.com> <20160203161720.GA9546@deepa-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:61733 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbcBCV1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 16:27:14 -0500
In-Reply-To: <20160203161720.GA9546@deepa-ubuntu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wednesday 03 February 2016 08:17:23 Deepa Dinamani wrote:
> On Wed, Feb 03, 2016 at 10:34:00PM +0800, Yan, Zheng wrote:
> > On Wed, Feb 3, 2016 at 2:07 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -1721,7 +1721,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
> > >         init_completion(&req->r_safe_completion);
> > >         INIT_LIST_HEAD(&req->r_unsafe_item);
> > >
> > > -       req->r_stamp = CURRENT_TIME;
> > > +       ktime_get_real_ts(&req->r_stamp);
> > 
> > I think we should use current_fs_time() here. I have squash the change
> > into another patch
> 
> Ok. I missed this commit b8e69066d8afa8d2670dc697252ff0e5907aafad
> earlier which says that the r_stamp is used as ctime now.
> I had assumed that this is a message timestamp.
> 
> I was not able to find any documentation on what the server does
> with the message sent by the client. Where can I find that?
> 
> So, this should actually look like
> 
> req->r_stamp = current_fs_time(mdsc->fsc->sb);
> 
> Let me know if you want me to resend.

I see that the timestamp is sent using

	ceph_encode_copy(&p, &req->r_stamp, sizeof(req->r_stamp));

What happens with the timestamp across reboots if we change the
type? I assume the data will not be used across reboots, if it
does, we already have a problem on machines that can boot
both big-endian and little-endian kernels, or that can boot
both 32-bit and 64-bit kernels.

	Arnd
