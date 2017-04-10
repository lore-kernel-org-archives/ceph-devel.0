From: kefu chai <tchaikov@gmail.com>
Subject: Re: Toying with a FreeBSD cluster results in a crash
Date: Mon, 10 Apr 2017 16:12:12 +0800
Message-ID: <CAJE9aOO2v3Yd7+wQ86EgJAOgs-6S+oSwmRBQKT54uiM-QKA1sw@mail.gmail.com>
References: <f94f1932-ae99-eb6a-7fc6-e2fb6afee051@digiware.nl>
 <CAJE9aONW_n1k+_5by=JLs_7kkpka8xJCkcsPkM0YMchQottA_Q@mail.gmail.com> <3fd7e04e-cf9d-5439-a932-33dcef685c88@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34510 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdDJIMN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 04:12:13 -0400
Received: by mail-ua0-f182.google.com with SMTP id u103so28697474uau.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Apr 2017 01:12:13 -0700 (PDT)
In-Reply-To: <3fd7e04e-cf9d-5439-a932-33dcef685c88@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Apr 8, 2017 at 8:43 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 08-04-17 05:33, kefu chai wrote:
>> On Fri, Apr 7, 2017 at 10:34 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> I'm playing with my/a FreeBSD test cluster.
>>> It is full with different types of disks, and sometimes they are not
>>> very new.
>>>
>>> The deepscrub on it showed things like:
>>>  filestore(/var/lib/ceph/osd/osd.7) error creating
>>> #-1:4962ce63:::inc_osdmap.705:0#
>>> (/var/lib/ceph/osd/osd.7/current/meta/inc\uosdmap
>>> .705__0_C6734692__none) in index: (87) Attribute not found
>>
>> filestore stores subdir states using xattr, could you check the xattr
>> of your meta collection using something like:
>>
>>  lsextattr user /var/lib/ceph/osd/osd.7/current/meta
>>
>> if nothing shows up, did you enable the xattr on the mounted fs in
>> which /var/lib/ceph/osd/osd.7/current/meta is located?
>
> This is on ZFS, and there attributes are on per default.
>
> I checked other parts of the OSD files and several other did have
> attributes. But everything in this directory had nothing set.

that sounds weird. looks like a bug. can you reproduce it?

>
> Now the trick question is if it can recover from a crash like this:
>>> /usr/ports/net/ceph/work/ceph-wip.FreeBSD/src/osd/OSD.cc: 3360:
>>> FAILED assert(0 == "Missing map in load_pgs")
>
> If it depends on infomation in its local tree, things might be too
> corrupt to restart it...

yes, the osdmap is stored in the meta collection, which in turn misses
the subdir states stored in the xattr.

> But if it needs to be fetched from the rest of the cluster, I had a
> different type of problem?

maybe you can rebuild that osd? the meta collection is different from
one osd to another, i am not sure if we can copy it over from anther
osd.

-- 
Regards
Kefu Chai
