From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] enable mds rejoin with active inodes' old parent xattrs
Date: Fri, 23 Aug 2013 13:11:14 -0700
Message-ID: <CAPYLRzjHPbRe-AKnzqb-M+jO78u9vMYdru+8kLGWmVEPNanfqA@mail.gmail.com>
References: <orvc2ytei1.fsf@livre.home>
	<CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
	<orppt4k6ys.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33581 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab3HWULQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 16:11:16 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so925331wgg.4
        for <ceph-devel@vger.kernel.org>; Fri, 23 Aug 2013 13:11:14 -0700 (PDT)
In-Reply-To: <orppt4k6ys.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 23, 2013 at 4:00 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Aug 22, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:
>
>> This is not bug. Only the tail entry of the path encoded in the parent xattrs
>> need to be updated. (the entry for inode's parent directory)
>
> Why store the others, if they're not usable, then?  IMHO it just
> introduces a risk of their being accidentally misused.

We want to write a correct path whenever we touch the file, but we
don't want to have to go out to each file's object in order to
complete a directory rename. So for a given file object we consider
only the immediate parent to be authoritative, but keep around the
full path for disaster recovery. This is why each path is versioned.
If we are touching the file's ancestor xattr and not updating the
whole thing, that would be a bug, but I don't think that's what you're
describing?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
