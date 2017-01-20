From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: hammer 0.94.10 approval
Date: Fri, 20 Jan 2017 14:52:20 -0800
Message-ID: <CADRKj5Qn0-gb249RvZNywOarrzO4h5077wsbieer8ftFRYLNkw@mail.gmail.com>
References: <1864f77e-ab28-8d1b-97d1-a81a3ee38005@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33946 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdATXAh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2017 18:00:37 -0500
Received: by mail-vk0-f45.google.com with SMTP id r136so59502342vke.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jan 2017 15:00:36 -0800 (PST)
In-Reply-To: <1864f77e-ab28-8d1b-97d1-a81a3ee38005@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Orit Wasserman <owasserm@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, looks fine.

Thanks,
Yehuda

On Fri, Jan 20, 2017 at 2:43 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hello Yehuda:
>
> Several bugfixes have been backported to hammer, after passing the rgw
> suite. See [1] for a list.
>
> Do you think it is ready for QE to start their own round of testing ?
>
> Cheers,
> Nathan
>
> [1]
> http://tracker.ceph.com/projects/rgw/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
