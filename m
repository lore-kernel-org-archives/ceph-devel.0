From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: RBD rights acting up.
Date: Mon, 3 Jul 2017 11:00:35 -0700
Message-ID: <CAJ4mKGb=6bMGX2ER2phDDy4g4hsdb2pdW21zuuA2+bge-OUiWg@mail.gmail.com>
References: <066859a0-9ca6-613f-e9de-a01a430e7efa@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36374 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755865AbdGCSAi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jul 2017 14:00:38 -0400
Received: by mail-io0-f175.google.com with SMTP id z62so60401562ioi.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jul 2017 11:00:38 -0700 (PDT)
In-Reply-To: <066859a0-9ca6-613f-e9de-a01a430e7efa@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 3, 2017 at 10:51 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> Hi,
>
> I do not seem to have luck with working with the rights structure in
> Ceph. But please help me out with my ignorance....
>
> I have setup the FreeBSD cluster running in 5 ceph jails/vms. That works
> as a charm, and I can use ceph-fuse to mount a FS and write/read/... on
> it when I'm outside the ceph jails. For that I copies ceph.conf and
> ceph.client.admin.keyring to the current system I would like to connect
> with.
>
> Also things like ceph -s and rados commands just work as a charm.
>
> So the next check is to test rbd-ggate, the freebsd variant to map
> rbd-images to a device.... But then I start to get things like:
> ----
> # rbd info rbd/testrbdggate45846
> 2017-07-03 19:41:00.562567 80ee53b00 -1 librbd::image::OpenRequest:
> failed to retrieve create_timestamp: (1) Operation not permitted
> 2017-07-03 19:41:00.562685 80f8b2000 -1 librbd::ImageState: 0x80ef23640
> failed to open image: (1) Operation not permitted
> rbd: error opening image testrbdggate45846: (1) Operation not permitted
> ----
>
> Which is definitly a rights issue, because I can do that without much
> trouble on one of the Ceph servers:
> ----
> # jexec ceph_0 rbd info rbd/testrbdggate45846
> rbd image 'testrbdggate45846':
>         size 65536 kB in 16 objects
>         order 22 (4096 kB objects)
>         block_name_prefix: rbd_data.10e3c0b1daf
>         format: 2
>         features: layering, exclusive-lock, object-map, fast-diff,
> deep-flatten
>         flags:
> ----
>
> So why does this work from a server that is actually running
> mon/osd/mgr, but not from a server that has the same
> ceph.client.admin.keyring:
> [client.admin]
>         key = AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>         auid = 0
>         caps mds = "allow *"
>         caps mgr = "allow *"
>         caps mon = "allow *"
>         caps osd = "allow *"
>
> and ceph auth list:
> installed auth entries:
>
> mds.a
>         key: AQA+YFlZEHtzKRAAm7Ihhsp2bq2z1YrfmMKnXg==
>         caps: [mds] allow
>         caps: [mgr] allow profile
>  mds
>         caps: [mon] allow profile mds
>         caps: [osd] allow *
> osd.0
>         key: AQCLXllZ6NL+BBAAzZH3lnPOR7jOdpsHZz9+FA==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.1
>         key: AQDpXllZeNPKDBAAMzXKut/xcPQP43l2UzTyQw==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.2
>         key: AQAkX1lZmL4FOhAAcgVJ5lno+abOyGq7TOdpKg==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.3
>         key: AQBlX1lZyBxRARAAccH0W16MQ4EMPT+y3Bh5ag==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.4
>         key: AQCtX1lZaOnOGxAAFSK3sCq/pbqXARi9oELAxA==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.5
>         key: AQD5X1lZ2KhCGRAAFda2ttOumRXxLGU6CU26Fw==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> osd.6
>         key: AQA8YFlZkLPDBxAAe6YlnCCUTQlgQh0UvWw6Fg==
>         caps: [mon] allow profile osd
>         caps: [osd] allow *
> client.admin
>         key: AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>         auid: 0
>         caps: [mds] allow *
>         caps: [mgr] allow *
>         caps: [mon] allow *
>         caps: [osd] allow *
> client.bootstrap-mds
>         key: AQBWXllZ6DHwMRAA53Zp9126rH/b5IZr0y2j/A==
>         caps: [mon] allow profile bootstrap-mds
> client.bootstrap-osd
>         key: AQBWXllZWD3EDxAAhaJ41UcTwlQVJCHzw+tBkA==
>         caps: [mon] allow profile bootstrap-osd
> client.bootstrap-rgw
>         key: AQBWXllZ0EUAIRAAfUgvfH7mIzF2cTKXbd8yPg==
>         caps: [mon] allow profile bootstrap-rgw
> client.ggate
>         key: AQANP1pZGNDmNRAAVb8NRXUMmWYh9i1nju6rYA==
>         caps: [mon] allow r
>         caps: [osd] allow class-read object_prefix rbd_children, allow
> rwx pool=rbd

Presumably ggate is using this client. I'm not sure off-hand what
permissions RBD needs, but I presume it needs class-write in order to
create new images (and they probably won't be prefixed with
rbd_children?).
-Greg

> client.kernelrbd
>         key: AQBzP1pZEO4nLxAABljwihF2xHFzZfUcc+CJtg==
>         caps: [mon] allow r
>         caps: [osd] allow class-read object_prefix rbd_children, allow
> rwx pool=rbd
> mgr.a
>         key: AQA/YFlZkA7tDxAAAvC49DNN2VuTTSfCJ1nH+w==
>         caps: [mds] allow *
>         caps: [mon] allow profile mgr
>         caps: [osd] allow *
> mgr.x
>         key: AQA+YFlZcE52ERAASdHoQn7DZ4G6ialDJg922g==
>         caps: [mds] allow *
>         caps: [mon] allow profile mgr
>         caps: [osd] allow *
>
>
> Thanx,
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
