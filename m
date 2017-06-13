From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Tue, 13 Jun 2017 13:49:08 +0200
Message-ID: <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:36723 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFMLtv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 07:49:51 -0400
Received: by mail-ot0-f169.google.com with SMTP id i31so85774711ota.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 04:49:50 -0700 (PDT)
Received: from mail-ot0-f170.google.com (mail-ot0-f170.google.com. [74.125.82.170])
        by smtp.gmail.com with ESMTPSA id l18sm6327080ota.0.2017.06.13.04.49.49
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 04:49:49 -0700 (PDT)
Received: by mail-ot0-f170.google.com with SMTP id a2so85831396oth.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 04:49:49 -0700 (PDT)
In-Reply-To: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Would it be possible to get these into 10.2.8?

    http://tracker.ceph.com/issues/19677
    http://tracker.ceph.com/issues/19762
    http://tracker.ceph.com/issues/20027

Thanks!

Dan


On Fri, Jun 9, 2017 at 6:13 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi John:
>
> The following cephfs backports have been merged into the jewel branch in
> preparation for the 10.2.8 release.
>
> http://tracker.ceph.com/projects/cephfs/issues?utf8=3D%E2%9C%93&set_filte=
r=3D1&f%5B%5D=3Dstatus_id&op%5Bstatus_id%5D=3D%3D&v%5Bstatus_id%5D%5B%5D=3D=
3&f%5B%5D=3Dtracker_id&op%5Btracker_id%5D=3D%3D&v%5Btracker_id%5D%5B%5D=3D9=
&f%5B%5D=3Dfixed_version_id&op%5Bfixed_version_id%5D=3D%3D&v%5Bfixed_versio=
n_id%5D%5B%5D=3D537&f%5B%5D=3D&c%5B%5D=3Dproject&c%5B%5D=3Dtracker&c%5B%5D=
=3Dstatus&c%5B%5D=3Dpriority&c%5B%5D=3Dsubject&c%5B%5D=3Dassigned_to&c%5B%5=
D=3Dupdated_on&c%5B%5D=3Dcategory&c%5B%5D=3Dfixed_version&c%5B%5D=3Dcf_3&gr=
oup_by=3D&t%5B%5D=3D
>
> (I thought there were more than two, but apparently not?)
>
> Do you think it's time for QE to do its testing?
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
