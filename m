From: John Spray <jspray@redhat.com>
Subject: Re: hammer 0.94.10
Date: Mon, 23 Jan 2017 12:24:14 +0000
Message-ID: <CALe9h7enb3335br=WEyJGhMQ4jan2=F+DbyC4GUNKTxvP7AuWQ@mail.gmail.com>
References: <1908e8d0-141d-3f7e-f3d1-b9c223f597a8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35803 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdAWMYg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 07:24:36 -0500
Received: by mail-oi0-f42.google.com with SMTP id j15so78849150oih.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 04:24:35 -0800 (PST)
In-Reply-To: <1908e8d0-141d-3f7e-f3d1-b9c223f597a8@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 20, 2017 at 11:02 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi John:
>
> Three cephfs-related bugfixes were backported to hammer. For the first two,
> see [1]. These have passed an fs suite and have been merged. A third fix -
> http://tracker.ceph.com/issues/18602 - is still pending but should be merged
> very soon.
>
> Do you think it's OK for QE to start their own round of testing?

Yep!

John

>
> Cheers,
> Nathan
>
> [1]
> http://tracker.ceph.com/projects/cephfs/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
