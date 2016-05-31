From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Random thought: adding a tracker custom field for feature/"topic"
 (separate to category/component)
Date: Tue, 31 May 2016 06:47:44 -0700
Message-ID: <CAJ4mKGZ1J0En_1WJuFogjOuqCjYwQKsqdTywL=JhJBtv+Tkh8g@mail.gmail.com>
References: <CALe9h7eLOBYq+AHQU_kiB97NaPSg5Fmj90xSK7xyqLK8_TOa_w@mail.gmail.com>
	<alpine.DEB.2.11.1605310859020.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33928 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbcEaNrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 09:47:45 -0400
Received: by mail-vk0-f51.google.com with SMTP id c189so260239993vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 06:47:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605310859020.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 31, 2016 at 6:03 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 31 May 2016, John Spray wrote:
>> Hi all,
>>
>> Currently we have "Category", which is sort of a mixture of physical
>> components (e.g. MDS, OSD, client, librados) and higher level
>> features/topics.
>>
>> Lots of tickets actually refer to both a feature and a component, for
>> example in cephfs we have lots of tickets related to FSCK, and some of
>> them are MDS changes while some are tool changes.  Currently we sort
>> of work around this by prefacing things to subjects.
>>
>> I'm thinking that maybe we need two fields, one saying which component
>> (i.e. which subdir in the git tree), and one giving a higher level
>> category (which I'm imagining calling "topics").
>>
>> In a CephFS context, examples of components would be MDS, client,
>> ceph-fuse, libcephfs, libcephfs-python, cephfs-volume-client, kernel
>> client, hadoop plugin, samba plugin, ganesha plugin, tools,
>> MDSMonitor, qa-suite.
>>
>> ...whereas topics would be features that affect multiple components
>> like: multi-mds, multi-fs, snapshots, fsck.
>>
>> Thoughts?
>
> Sounds good to me! This might be slighly tricky to set up in redmine (not
> sure if 'categories' is special or not).

Hah, looks like we just create another "list" custom field. I'll
experiment with splitting "category" into "component" and "topic"
later today. (Actually, it'll probably be "category" and "component",
but we'll see how things behave.)
-Greg
