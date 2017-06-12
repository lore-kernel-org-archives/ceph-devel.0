From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Are we ready for 10.2.8 - rbd
Date: Mon, 12 Jun 2017 12:14:53 -0400
Message-ID: <CA+aFP1At5Cxhana94NizFdDyN1eB41LQa-fZwTsDZeh8MN5PDA@mail.gmail.com>
References: <7d45e4c4-105d-4613-d43b-c7d25bd0b635@suse.cz>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:35364 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdFLQOy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 12:14:54 -0400
Received: by mail-yb0-f180.google.com with SMTP id f192so27948431yba.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 09:14:54 -0700 (PDT)
In-Reply-To: <7d45e4c4-105d-4613-d43b-c7d25bd0b635@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sounds good to me.

On Fri, Jun 9, 2017 at 12:15 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Jason:
>
> The following rbd backports have been merged into the jewel branch in
> preparation for the 10.2.8 release.
>
> http://tracker.ceph.com/projects/rbd/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=537&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
>
> Do you think it's time for QE to do its testing?
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
