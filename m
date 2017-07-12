From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 10.2.9 release needed to fix fs regression in 10.2.8
Date: Wed, 12 Jul 2017 16:35:29 -0700
Message-ID: <CAMMFjmEGbSQqFm4S9Qj1F7PtPVSbj=wkCu5wQqZ6oJ10bgfWLA@mail.gmail.com>
References: <a7d7b003-f348-6648-064a-1c91524c7b64@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35883 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdGLXfb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 19:35:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id 62so8082175wmw.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 16:35:30 -0700 (PDT)
In-Reply-To: <a7d7b003-f348-6648-064a-1c91524c7b64@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Run and rerun:

http://pulpito.ceph.com/yuriw-2017-07-12_19:32:45-fs-wip_4_nathan_jewel_16282-distro-basic-smithi/
http://pulpito.ceph.com/yuriw-2017-07-12_23:25:02-fs-wip_4_nathan_jewel_16282-distro-basic-smithi/

On Wed, Jul 12, 2017 at 12:55 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi leads,
>
> Zheng and John confirmed today that there is an fs regression in 10.2.8
> which requires a single PR to fix. Since the v10.2.8 tag has already been
> applied, RPM and DEB packages uploaded, and release notes prepared, the best
> option at this stage seems to be cutting a 10.2.9 release consisting of the
> current tip of the jewel branch plus https://github.com/ceph/ceph/pull/16282
>
> Yuri is running an fs suite on that PR already.
>
> In this respect, I have two questions for you:
>
> 1. do you agree with the above, and
> 2. what further QE testing should we do on 10.2.9, other than the fs suite?
>
> Thanks,
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
