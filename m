From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: RBD rights acting up.
Date: Wed, 5 Jul 2017 21:20:49 -0400
Message-ID: <CA+aFP1A+BCwX1xaTzBnb4HJJd-0qeox-NL4Bf+eWhEr0GfL+WQ@mail.gmail.com>
References: <066859a0-9ca6-613f-e9de-a01a430e7efa@digiware.nl>
 <CAJ4mKGb=6bMGX2ER2phDDy4g4hsdb2pdW21zuuA2+bge-OUiWg@mail.gmail.com> <536f0dd0-41f4-4306-f393-30caffe2375b@digiware.nl>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35484 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdGFBUu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jul 2017 21:20:50 -0400
Received: by mail-yw0-f180.google.com with SMTP id v193so2159687ywg.2
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jul 2017 18:20:50 -0700 (PDT)
In-Reply-To: <536f0dd0-41f4-4306-f393-30caffe2375b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Any chance that you have the OSD log for the PGs mapped to that
image's header? Since that method is brand new, I wonder if the
-EOPNOTSUPP error is being somehow mapped to -EPERM under FreeBSD(?).

On Mon, Jul 3, 2017 at 3:24 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
>
> Op 3-7-2017 om 20:00 schreef Gregory Farnum:
>>
>> On Mon, Jul 3, 2017 at 10:51 AM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>>>
>>> Hi,
>>>
>>> I do not seem to have luck with working with the rights structure in
>>> Ceph. But please help me out with my ignorance....
>>>
>>> I have setup the FreeBSD cluster running in 5 ceph jails/vms. That works
>>> as a charm, and I can use ceph-fuse to mount a FS and write/read/... on
>>> it when I'm outside the ceph jails. For that I copies ceph.conf and
>>> ceph.client.admin.keyring to the current system I would like to connect
>>> with.
>>>
>>> Also things like ceph -s and rados commands just work as a charm.
>>>
>>> So the next check is to test rbd-ggate, the freebsd variant to map
>>> rbd-images to a device.... But then I start to get things like:
>>> ----
>>> # rbd info rbd/testrbdggate45846
>>> 2017-07-03 19:41:00.562567 80ee53b00 -1 librbd::image::OpenRequest:
>>> failed to retrieve create_timestamp: (1) Operation not permitted
>>> 2017-07-03 19:41:00.562685 80f8b2000 -1 librbd::ImageState: 0x80ef23640
>>> failed to open image: (1) Operation not permitted
>>> rbd: error opening image testrbdggate45846: (1) Operation not permitted
>>> ----
>>>
>>> Which is definitly a rights issue, because I can do that without much
>>> trouble on one of the Ceph servers:
>>> ----
>>> # jexec ceph_0 rbd info rbd/testrbdggate45846
>>> rbd image 'testrbdggate45846':
>>>          size 65536 kB in 16 objects
>>>          order 22 (4096 kB objects)
>>>          block_name_prefix: rbd_data.10e3c0b1daf
>>>          format: 2
>>>          features: layering, exclusive-lock, object-map, fast-diff,
>>> deep-flatten
>>>          flags:
>>> ----
>>>
>>> So why does this work from a server that is actually running
>>> mon/osd/mgr, but not from a server that has the same
>>> ceph.client.admin.keyring:
>>> [client.admin]
>>>          key = AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>>>          auid = 0
>>>          caps mds = "allow *"
>>>          caps mgr = "allow *"
>>>          caps mon = "allow *"
>>>          caps osd = "allow *"
>>>
>>> and ceph auth list:
>>> installed auth entries:
>>> client.admin
>>>          key: AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>>>          auid: 0
>>>          caps: [mds] allow *
>>>          caps: [mgr] allow *
>>>          caps: [mon] allow *
>>>          caps: [osd] allow *
>
>
>>> client.ggate
>>>          key: AQANP1pZGNDmNRAAVb8NRXUMmWYh9i1nju6rYA==
>>>          caps: [mon] allow r
>>>          caps: [osd] allow class-read object_prefix rbd_children, allow
>>> rwx pool=rbd
>>
>> Presumably ggate is using this client. I'm not sure off-hand what
>> permissions RBD needs, but I presume it needs class-write in order to
>> create new images (and they probably won't be prefixed with
>> rbd_children?).
>
>
> Well,  client.ggate was an attempt to mirror what we have in our working
> OpenStack ceph.
>
> But my major concern is that it all works on a host that is actually part of
> the cluster (as admin),
> but it does not work for all rbd commands once I start working on a separate
> host.
> Ceph and rados are oke, but certain rbs commands fail.
>
> So why doesn't it work as admin on an 'external'  host.
>
>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
