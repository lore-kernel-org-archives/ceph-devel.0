From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] ceph: Fix oops when mounting cephfs with non-existing path
Date: Fri, 17 Aug 2012 09:01:18 -0700
Message-ID: <CADvuQREFhe1CGz1HPEXCMLRi78LjmTcspQjKDWtnk6r_yWLWbQ@mail.gmail.com>
References: <1345182959-6486-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1208170850380.26904@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41318 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab2HQQBk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 12:01:40 -0400
Received: by lbbgj3 with SMTP id gj3so2205249lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 09:01:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208170850380.26904@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Fri, Aug 17, 2012 at 8:54 AM, Sage Weil <sage@inktank.com> wrote:
>> req->r_locked_dir is NULL if the request was created by
>> open_root_dentry(). ceph_fill_trace() lacks check for this case.
>> It causes oops when mounting cephfs with non-existing path.
> This is actually an MDS bug.  The problem is that the client is issuing a

It's also a kernel bug -- there's no excuse for an oops, even if the
server spoke pig latin.
