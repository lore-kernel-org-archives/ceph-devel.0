From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [Ceph-qa] QE validation hammer v0.94.7 finished (needs approval)
Date: Fri, 6 May 2016 19:13:22 +0200
Message-ID: <CAOi1vP9g0asaad8=7EA+XJm19DuwBhA2x8qG1bpQ0M-eHBvVNw@mail.gmail.com>
References: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34316 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbcEFRNY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 13:13:24 -0400
Received: by mail-lf0-f53.google.com with SMTP id m64so138419212lfd.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 10:13:23 -0700 (PDT)
In-Reply-To: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>

On Fri, May 6, 2016 at 6:26 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Hello
>
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/14692#note-61
>
> The following suites were in scope of this point release testing:
>
> rados (subset 1/7)
> rbd
> rgw
> fs
> krbd
> kcephfs
> hadoop
> samba
> rest
> ceph-deploy
> upgrade/client-upgrade
> upgrade/dumpling-firefly-x (hammer)
> upgrade/firefly-x (hammer)
> upgrade/hammer
> upgrade/hammer-x (infernalis)
> powercycle
>
> Known issues (approved for release):
>
> fs:
> http://tracker.ceph.com/issues/14716 - (same as in v0.94.6 was
> approved by Greg, Josh)
>
> samba:
> http://tracker.ceph.com/issues/14714 - (same as in v0.94.6 was approved by Greg)
>
> krbd:
> see failed runs, Jason/Josh pls review and approve or suggest next steps.

krbd based on

    http://pulpito.ovh.sepia.ceph.com:8081/teuthology-2016-04-24_18:06:02-krbd-hammer-testing-basic-openstack/

looks OK to me - known xfstests failures, under-provisioned OSDs (97%
full) and a huge-tickets failure.

huge-tickets seems to be failing consistently on ovh, I'll investigate
later.

Thanks,

                Ilya
