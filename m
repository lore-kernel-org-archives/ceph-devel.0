From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: RBD rights acting up.
Date: Thu, 6 Jul 2017 10:00:45 +0200
Message-ID: <b768fbbf-8357-f95c-6361-4d4494a4a77f@digiware.nl>
References: <066859a0-9ca6-613f-e9de-a01a430e7efa@digiware.nl>
 <CAJ4mKGb=6bMGX2ER2phDDy4g4hsdb2pdW21zuuA2+bge-OUiWg@mail.gmail.com>
 <536f0dd0-41f4-4306-f393-30caffe2375b@digiware.nl>
 <CA+aFP1A+BCwX1xaTzBnb4HJJd-0qeox-NL4Bf+eWhEr0GfL+WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50443 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbdGFIAv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Jul 2017 04:00:51 -0400
In-Reply-To: <CA+aFP1A+BCwX1xaTzBnb4HJJd-0qeox-NL4Bf+eWhEr0GfL+WQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 6-7-2017 03:20, Jason Dillaman wrote:
> Any chance that you have the OSD log for the PGs mapped to that
> image's header? Since that method is brand new, I wonder if the
> -EOPNOTSUPP error is being somehow mapped to -EPERM under FreeBSD(?).

Hi Jason,

Getting annoyed witht the fact that I could not get it right, I thrashed
the cluster and redid it. So no more logs...
I think we must write this up to "pilot error".

And then it worked after I build a new cluster..
Now the difference is that the second time I created the mgr rights in
the client keyring right from the bat. It was missing that in earlier
version of my build-cluster script.

So my conclusion is that all tries I did to get a working keyring with
mgr rights were unsuccessful.

But your answer triggers something for me to check....
There is now conversion of the errorcodes in FreeBSD servers and
clients. All wire messages should contain the "Linux" version of the
errorcode, and are translated upon exit or arrival.
Problem is there what to do with errors that do not have a matching
counterpart. ATM they are all translated to EPERM, so once converted the
meaning is lost, and the errorcode stays at EPERM.

This gives me an idea though. Perhaps I should convert errorcodes
without Linux counterpart to 1000+errocode. Once they arrive at the
other end, it is time to decide how to translate back:
	if it is a FreeBSD system, return wirecode-1000
	if it is a linux system return EPERM.
(And start looking into the Errorcode class)

Fortunatelly that error type is known on both sides of the fence:
Linux:#define        EOPNOTSUPP      95
FreeBSD:#define      EOPNOTSUPP      45
And should be translatable without loss of information.

Thing is, the full extend of the PR set got merged like only yesterday
and I'm testing a version of v12.1.0 with without that translation part.
The package was last build on Tuesday 4th.

So I guess it must have been me, being clumsy with rights.

--WjW

> On Mon, Jul 3, 2017 at 3:24 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>>
>> Op 3-7-2017 om 20:00 schreef Gregory Farnum:
>>>
>>> On Mon, Jul 3, 2017 at 10:51 AM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I do not seem to have luck with working with the rights structure in
>>>> Ceph. But please help me out with my ignorance....
>>>>
>>>> I have setup the FreeBSD cluster running in 5 ceph jails/vms. That works
>>>> as a charm, and I can use ceph-fuse to mount a FS and write/read/... on
>>>> it when I'm outside the ceph jails. For that I copies ceph.conf and
>>>> ceph.client.admin.keyring to the current system I would like to connect
>>>> with.
>>>>
>>>> Also things like ceph -s and rados commands just work as a charm.
>>>>
>>>> So the next check is to test rbd-ggate, the freebsd variant to map
>>>> rbd-images to a device.... But then I start to get things like:
>>>> ----
>>>> # rbd info rbd/testrbdggate45846
>>>> 2017-07-03 19:41:00.562567 80ee53b00 -1 librbd::image::OpenRequest:
>>>> failed to retrieve create_timestamp: (1) Operation not permitted
>>>> 2017-07-03 19:41:00.562685 80f8b2000 -1 librbd::ImageState: 0x80ef23640
>>>> failed to open image: (1) Operation not permitted
>>>> rbd: error opening image testrbdggate45846: (1) Operation not permitted
>>>> ----
>>>>
>>>> Which is definitly a rights issue, because I can do that without much
>>>> trouble on one of the Ceph servers:
>>>> ----
>>>> # jexec ceph_0 rbd info rbd/testrbdggate45846
>>>> rbd image 'testrbdggate45846':
>>>>          size 65536 kB in 16 objects
>>>>          order 22 (4096 kB objects)
>>>>          block_name_prefix: rbd_data.10e3c0b1daf
>>>>          format: 2
>>>>          features: layering, exclusive-lock, object-map, fast-diff,
>>>> deep-flatten
>>>>          flags:
>>>> ----
>>>>
>>>> So why does this work from a server that is actually running
>>>> mon/osd/mgr, but not from a server that has the same
>>>> ceph.client.admin.keyring:
>>>> [client.admin]
>>>>          key = AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>>>>          auid = 0
>>>>          caps mds = "allow *"
>>>>          caps mgr = "allow *"
>>>>          caps mon = "allow *"
>>>>          caps osd = "allow *"
>>>>
>>>> and ceph auth list:
>>>> installed auth entries:
>>>> client.admin
>>>>          key: AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
>>>>          auid: 0
>>>>          caps: [mds] allow *
>>>>          caps: [mgr] allow *
>>>>          caps: [mon] allow *
>>>>          caps: [osd] allow *
>>
>>
>>>> client.ggate
>>>>          key: AQANP1pZGNDmNRAAVb8NRXUMmWYh9i1nju6rYA==
>>>>          caps: [mon] allow r
>>>>          caps: [osd] allow class-read object_prefix rbd_children, allow
>>>> rwx pool=rbd
>>>
>>> Presumably ggate is using this client. I'm not sure off-hand what
>>> permissions RBD needs, but I presume it needs class-write in order to
>>> create new images (and they probably won't be prefixed with
>>> rbd_children?).
>>
>>
>> Well,  client.ggate was an attempt to mirror what we have in our working
>> OpenStack ceph.
>>
>> But my major concern is that it all works on a host that is actually part of
>> the cluster (as admin),
>> but it does not work for all rbd commands once I start working on a separate
>> host.
>> Ceph and rados are oke, but certain rbs commands fail.
>>
>> So why doesn't it work as admin on an 'external'  host.
>>
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

