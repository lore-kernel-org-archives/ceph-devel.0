From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: server unclear options of buckets stats info
Date: Tue, 27 Oct 2015 10:32:48 -0700
Message-ID: <CAJ4mKGaPCr+x3bqTJ=U6KL98-S2Kq5QiJ-B5omNW35bmEU=wVw@mail.gmail.com>
References: <CABAwU-b189oRUQ+B11bCVuz_G-d42CYjK+V9yMscM2t1CwOehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37804 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965439AbbJ0Rct (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 13:32:49 -0400
Received: by wicfv8 with SMTP id fv8so173174103wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2015 10:32:48 -0700 (PDT)
In-Reply-To: <CABAwU-b189oRUQ+B11bCVuz_G-d42CYjK+V9yMscM2t1CwOehA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 27, 2015 at 6:34 AM, huang jun <hjwsm1989@gmail.com> wrote:
> Hi, all
> I am looking rgw storage object, when use the following command to
> view the bucket information:
>>>> radosgw-admin bucket stats --bucket = bk0
> {"Bucket": "bk0",
>    "pool": ".rgw.buckets",
>    "index_pool": ".rgw.buckets.index",
>    "id": "default.4958.1",
>    "marker": "default.4958.1",
>    "owner": "rgwtest",
>    "ver": 15,
>    "master_ver": 0,
>    "mtime": 1445568223,
>    "max_marker": "",
>    "usage": {"rgw.main": {"size_kb": 36,
>            "size_kb_actual": 40,
>            "num_objects": 3}},
>    "bucket_quota": {"enabled": false,
>        "max_size_kb": -1,
>        "max_objects": -1}}
>
> but I don't understand the meaning of marker, master_ver, max_marker.
> what are they stand for? Any tips are welcome.

I *think* those are both for RGW's geo-replication system. master_ver
would be the version of the master bucket which has been synced up to,
and max_marker would be how far through the master bucket it got in
syncing individual objects.
-Greg
