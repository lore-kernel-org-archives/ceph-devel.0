From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Seeking approval for 10.2.6 - RGW
Date: Mon, 20 Feb 2017 15:16:21 -0800
Message-ID: <CADRKj5RoqOXhSXfx9zF0yZRBpra=bRKAiKS+bjwKjej0yNGocg@mail.gmail.com>
References: <808b405f-3243-c69d-eedd-f8f42ed55065@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36267 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdBTXQX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 18:16:23 -0500
Received: by mail-vk0-f48.google.com with SMTP id t8so70246908vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 15:16:23 -0800 (PST)
In-Reply-To: <808b405f-3243-c69d-eedd-f8f42ed55065@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's ok with me. I would have been happier if we could also have
http://tracker.ceph.com/issues/18912.

Yehuda

On Mon, Feb 20, 2017 at 1:56 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yehuda,
>
> A number of RGW backports have been merged into jewel in preparation for the
> 10.2.6 release. For a list, see:
>
> http://tracker.ceph.com/projects/rgw/issues?c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&f%5B%5D=status_id&f%5B%5D=tracker_id&f%5B%5D=fixed_version_id&f%5B%5D=&group_by=&op%5Bfixed_version_id%5D=%3D&op%5Bstatus_id%5D=%2A&op%5Btracker_id%5D=%3D&per_page=100&set_filter=1&t%5B%5D=&utf8=%E2%9C%93&v%5Bfixed_version_id%5D%5B%5D=529&v%5Btracker_id%5D%5B%5D=9
>
> Do you think 10.2.6 can go to QE for further testing ahead of release?
>
> Thanks,
> Nathan
