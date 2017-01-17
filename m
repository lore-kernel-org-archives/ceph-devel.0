From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 0/4] ceph: endianness fixes and sparse warning fixes
Date: Tue, 17 Jan 2017 19:26:05 +0100
Message-ID: <20170117192605.144022a7@suse.de>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
        <alpine.DEB.2.11.1701121623290.5745@piezo.novalocal>
        <1484310965.2616.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60433 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdAQTDr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Jan 2017 14:03:47 -0500
In-Reply-To: <1484310965.2616.7.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 13 Jan 2017 07:36:05 -0500, Jeff Layton wrote:

> Thanks. Should we send this series to stable? I'm not sure how common
> kcephfs mounts are on BE arches, but these bugs would likely prevent it
> from working.

Please do, Jeff. I hit the [PATCH 4/4] bug on first CephFS I/O with
s390x (BE):
[ 2691.805255] ceph: mds parse_reply err -5
[ 2691.805256] ceph: mdsc_handle_reply got corrupt reply mds0(tid:5)

Cheers, David
