From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Are we ready for 10.2.8 - rgw
Date: Mon, 12 Jun 2017 11:59:46 -0700
Message-ID: <CADRKj5T_B0Rsva7--OnNehV3-8tYYRfv_V=rAOc-pyWZh7MycA@mail.gmail.com>
References: <ef00f025-27ea-6efa-80db-2ebb15d5b819@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33166 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdFLS7s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 14:59:48 -0400
Received: by mail-qt0-f180.google.com with SMTP id u12so138371736qth.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 11:59:47 -0700 (PDT)
In-Reply-To: <ef00f025-27ea-6efa-80db-2ebb15d5b819@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think so. I do see a large list of issues  with backport set to
jewel. Some of these were already backported but we didn't resolve the
tracker. I think that we can probably cut 10.2.8 now, and maybe plan
on early 10.2.9?

Yehuda

On Fri, Jun 9, 2017 at 9:17 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yehuda:
>
> The following rgw backports have been merged into the jewel branch in
> preparation for the 10.2.8 release.
>
> http://tracker.ceph.com/projects/rgw/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=537&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
>
> Do you think it's time for QE to do its testing?
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
