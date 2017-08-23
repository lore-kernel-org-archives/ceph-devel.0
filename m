From: kefu chai <tchaikov@gmail.com>
Subject: Re: Are we ready for Luminous?
Date: Wed, 23 Aug 2017 21:11:29 +0800
Message-ID: <CAJE9aOMhuzp-VNX4t7DByqUz78HOLvxgR-p8waX_EdRsgtqBKw@mail.gmail.com>
References: <87shgir0cl.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35877 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdHWNLa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 09:11:30 -0400
Received: by mail-oi0-f51.google.com with SMTP id g131so498674oic.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 06:11:30 -0700 (PDT)
In-Reply-To: <87shgir0cl.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Matt Benjamin <mbenjami@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Jason Dillaman <jdillama@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 23, 2017 at 7:26 PM, Abhishek Lekshmanan <abhishek@suse.com> wr=
ote:
>
> Other than the existing PRs in https://github.com/ceph/ceph/milestone/10,
> do we have anything else that really needs to go in for Luminous? Any
> other blockers?

and all tracker tickets whose "backport" has "luminous", and pending
on packport [0]. and all needs-backport PRs which are not yet
backported [1].

---
[0] http://tracker.ceph.com/projects/rados/issues?utf8=3D=E2=9C=93&set_filt=
er=3D1&f%5B%5D=3Dstatus_id&op%5Bstatus_id%5D=3D%21&v%5Bstatus_id%5D%5B%5D=
=3D3&f%5B%5D=3Dcf_2&op%5Bcf_2%5D=3D%7E&v%5Bcf_2%5D%5B%5D=3Dluminous&f%5B%5D=
=3D&c%5B%5D=3Dproject&c%5B%5D=3Dtracker&c%5B%5D=3Dstatus&c%5B%5D=3Dpriority=
&c%5B%5D=3Dsubject&c%5B%5D=3Dassigned_to&c%5B%5D=3Dupdated_on&c%5B%5D=3Dcat=
egory&c%5B%5D=3Dfixed_version&c%5B%5D=3Dcf_3&group_by=3D&t%5B%5D=3D
[1] https://github.com/ceph/ceph/pulls?utf8=3D=E2=9C=93&q=3Dis%3Apr%20label=
%3Aneeds-backport%20.
quite a few of PRs in this list have been backported.

>
> Thanks,
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
