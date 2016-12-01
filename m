From: Zhen Cao <juehuiconst@gmail.com>
Subject: Fwd: Ceph PG Number
Date: Thu, 1 Dec 2016 10:44:00 +0800
Message-ID: <CAOmt5rLndRVm9hx5Kfvg7yWLQcdeD06GPtdUjVGX=wjty2tWiw@mail.gmail.com>
References: <CAOmt5rK42=8DcdrkeHgqsY6o2NjaQ+5wWOeZToZNsPd0GtS2ew@mail.gmail.com>
 <20161130083105.GM26997@predictor> <CAOmt5rKynSwpdtXGDFJXD956mbLf5rR6XAg7p8wDwfpJk=RgUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34031 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbcLACoB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 21:44:01 -0500
Received: by mail-vk0-f65.google.com with SMTP id p9so10010347vkd.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 18:44:01 -0800 (PST)
In-Reply-To: <CAOmt5rKynSwpdtXGDFJXD956mbLf5rR6XAg7p8wDwfpJk=RgUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

---------- Forwarded message ----------
From: Zhen Cao <juehuiconst@gmail.com>
Date: 2016-11-30 17:01 GMT+08:00
Subject: Re: Ceph PG Number
To: Piotr Da=C5=82ek <branch@predictor.org.pl>


Thanks! I understood it.

http://docs.ceph.com/docs/jewel/rados/operations/placement-groups/ said

Ideally objects are evenly distributed in each placement group. Since
CRUSH computes the placement group for each object, but does not
actually know how much data is stored in each OSD within this
placement group, the ratio between the number of placement groups and
the number of OSDs may influence the distribution of the data
significantly.

For instance, if there was single a placement group for ten OSDs in a
three replica pool, only three OSD would be used because CRUSH would
have no other choice. When more placement groups are available,
objects are more likely to be evenly spread among them. CRUSH also
makes every effort to evenly spread OSDs among all existing Placement
Groups.

I got it,thanks for your help!


2016-11-30 16:31 GMT+08:00 Piotr Da=C5=82ek <branch@predictor.org.pl>:
> On Wed, Nov 30, 2016 at 04:22:10PM +0800, Zhen Cao wrote:
>> Hi,
>> I am reading the RADOS paper,but i could not understand why more PGs
>> per OSD result in a more balanced distribution.I konw the mapping
>> procedure between oid and osd=EF=BC=8Cbut it is neverless difficult to
>> understand for me.
>> Thanks for your help!
>
> In a nuthshell - because each PG corresponds to multiple objects.
> And because of this, it is possible that some PGs will aggregate more
> objects than other PGs, resulting in lack of acutal balance. Also see her=
e:
> http://docs.ceph.com/docs/jewel/rados/operations/placement-groups/
>
> --
> Piotr Da=C5=82ek
> branch@predictor.org.pl
> http://blog.predictor.org.pl
