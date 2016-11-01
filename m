From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Lots of radosgw-admin commands fail after upgrade
Date: Tue, 1 Nov 2016 15:04:20 +0100
Message-ID: <CABo9giRVAb-+2zvKWTWhRVF4fftG=szDxgrXBXNmDpH-yQrWMw@mail.gmail.com>
References: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36542 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936053AbcKAOE1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 10:04:27 -0400
Received: by mail-wm0-f54.google.com with SMTP id p190so207479841wmp.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2016 07:04:21 -0700 (PDT)
In-Reply-To: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafa1024m@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
what version of jewel are you using?
can you try raodsgw-admin zone get --rgw-zone default and
radosgw-admin zonegroup get --rgw-zonegroup default?

Orit

On Tue, Nov 1, 2016 at 2:13 PM, Mustafa Muhammad <mustafa1024m@gmail.com> wrote:
> Hello,
> I have production cluster configured with multiple placement pools according to:
>
> http://cephnotes.ksperis.com/blog/2014/11/28/placement-pools-on-rados-gw
>
> After upgrading to Jewel, most radosgw-admin are failing, probably
> because there is no realm
>
>
> # radosgw-admin realm list
> {
>     "default_info": "",
>     "realms": []
> }
>
>
> # radosgw-admin zone get
> unable to initialize zone: (2) No such file or directory
>
>
> # radosgw-admin regionmap get
> failed to read current period info: 2016-11-01 16:08:14.099948
> 7f21b55ee9c0  0 RGWPeriod::init failed to init realm  id  : (2) No
> such file or directory(2) No such file or directory
> {
>     "zonegroups": [],
>     "master_zonegroup": "",
>     "bucket_quota": {
>         "enabled": false,
>         "max_size_kb": -1,
>         "max_objects": -1
>     },
>     "user_quota": {
>         "enabled": false,
>         "max_size_kb": -1,
>         "max_objects": -1
>     }
> }
>
>
> # radosgw-admin bucket stats
> 2016-11-01 16:07:55.860053 7f6e747f89c0  0 zonegroup default missing
> zone for master_zone=
> couldn't init storage provider
>
> I have previous region.conf.json and zone.conf.json, how can I make
> everything work again? Will creating new realm fix this?
>
> Regards
> Mustafa Muhammad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
