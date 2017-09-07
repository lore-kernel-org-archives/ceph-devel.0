From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Are we ready for Jewel v10.2.10?
Date: Thu, 7 Sep 2017 07:32:26 -0400
Message-ID: <CA+aFP1ArGCV5GyUvrVYbPxyrCV=L-UCH8J_0_D3ms5DRVbxWYQ@mail.gmail.com>
References: <b0dc8c09-b2d3-6b38-8afd-2cf2ae48c2e9@suse.cz>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33894 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbdIGLc1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Sep 2017 07:32:27 -0400
Received: by mail-yw0-f171.google.com with SMTP id r85so14365227ywg.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Sep 2017 04:32:27 -0700 (PDT)
In-Reply-To: <b0dc8c09-b2d3-6b38-8afd-2cf2ae48c2e9@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>

RBD should be good-to-go.

Thanks.

On Thu, Sep 7, 2017 at 5:13 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Josh, Patrick, Yehuda, Jason:
>
> A number of backports have been merged for Jewel v10.2.10:
>
> http://tracker.ceph.com/projects/ceph/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=543&f%5B%5D=&c%5B%5D=tracker&c%5B%5D=relations&c%5B%5D=cf_2&c%5B%5D=subject&c%5B%5D=assigned_to&group_by=project&t%5B%5D=
>
> All the last-minute backports people asked for should already be listed, or
> are undergoing testing right now in the current integration branch:
>
> http://tracker.ceph.com/issues/20613#note-47
>
> Please take a look and let me know if you think we can hand v10.2.10 over to
> QE after the present integration round.
>
> Thanks!
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
