From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH 2/5] ceph: allow connecting to mds whose rank >= mdsmap::m_max_mds
Date: Wed, 5 Apr 2017 00:39:43 -0400
Message-ID: <CA+2bHPapuZ6EaC=FYRjEUEot81XEhhBRguDpJp6ghg7Gvdedbw@mail.gmail.com>
References: <20170405013019.5032-1-zyan@redhat.com> <20170405013019.5032-2-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35424 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdDEErJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Apr 2017 00:47:09 -0400
Received: by mail-io0-f180.google.com with SMTP id z13so2771161iof.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Apr 2017 21:47:09 -0700 (PDT)
In-Reply-To: <20170405013019.5032-2-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>

On Tue, Apr 4, 2017 at 9:30 PM, Yan, Zheng <zyan@redhat.com> wrote:
> mdsmap::m_max_mds is the expected count of active mds. It's not the
> max rank of active mds. User can decrease mdsmap::m_max_mds, but does
> not stop mds whose rank >= mdsmap::m_max_mds.

This is related to http://tracker.ceph.com/issues/17259

-- 
Patrick Donnelly
