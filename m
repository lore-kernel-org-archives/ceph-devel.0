From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RFC PATCH] ceph: add acl for cephfs
Date: Fri, 18 Oct 2013 10:10:47 -0700
Message-ID: <CAPYLRzi5XMc0uadx7n+8nqKbfhw8yAcBu6wiX_0-NBN0DXGkBA@mail.gmail.com>
References: <1381998446-30085-1-git-send-email-lucienchao@gmail.com>
	<525FDA9E.8030304@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:39631 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab3JRRKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 13:10:48 -0400
Received: by mail-we0-f169.google.com with SMTP id q58so4120446wes.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 10:10:47 -0700 (PDT)
In-Reply-To: <525FDA9E.8030304@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Guangliang Zhao <lucienchao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>

Isn't the UID/GID mismatch a generic problem when using CephFS? ;)

I've got this patch in my queue as well if nobody else beats me to it.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Oct 17, 2013 at 5:39 AM, Li Wang <liwang@ubuntukylin.com> wrote:
> Hi,
>   I did not take a careful look at the code. But it seems to me that for
> Ceph, the same directory could be mounted to different clients with totally
> different uid/gid, not aware of each other. The ACL won't make much sense
> and may not work properly.
