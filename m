From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Toying with a FreeBSD cluster results in a crash
Date: Mon, 10 Apr 2017 14:32:11 +0200
Message-ID: <fcebd83a-1fe2-6e9e-2bb8-4678d48c6721@digiware.nl>
References: <f94f1932-ae99-eb6a-7fc6-e2fb6afee051@digiware.nl>
 <CAJE9aONW_n1k+_5by=JLs_7kkpka8xJCkcsPkM0YMchQottA_Q@mail.gmail.com>
 <3fd7e04e-cf9d-5439-a932-33dcef685c88@digiware.nl>
 <CAJE9aOO2v3Yd7+wQ86EgJAOgs-6S+oSwmRBQKT54uiM-QKA1sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:49024 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbdDJMcf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Apr 2017 08:32:35 -0400
In-Reply-To: <CAJE9aOO2v3Yd7+wQ86EgJAOgs-6S+oSwmRBQKT54uiM-QKA1sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10-4-2017 10:12, kefu chai wrote:
> On Sat, Apr 8, 2017 at 8:43 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 08-04-17 05:33, kefu chai wrote:
>>> On Fri, Apr 7, 2017 at 10:34 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> Hi,
>>>>
>>>> I'm playing with my/a FreeBSD test cluster.
>>>> It is full with different types of disks, and sometimes they are not
>>>> very new.
>>>>
>>>> The deepscrub on it showed things like:
>>>>  filestore(/var/lib/ceph/osd/osd.7) error creating
>>>> #-1:4962ce63:::inc_osdmap.705:0#
>>>> (/var/lib/ceph/osd/osd.7/current/meta/inc\uosdmap
>>>> .705__0_C6734692__none) in index: (87) Attribute not found
>>>
>>> filestore stores subdir states using xattr, could you check the xattr
>>> of your meta collection using something like:
>>>
>>>  lsextattr user /var/lib/ceph/osd/osd.7/current/meta
>>>
>>> if nothing shows up, did you enable the xattr on the mounted fs in
>>> which /var/lib/ceph/osd/osd.7/current/meta is located?
>>
>> This is on ZFS, and there attributes are on per default.
>>
>> I checked other parts of the OSD files and several other did have
>> attributes. But everything in this directory had nothing set.
> 
> that sounds weird. looks like a bug. can you reproduce it?

It is a long standing (> 3 months) test cluster that has been severely
abused by me learning Ceph things and testing ceph-fuse.

>> Now the trick question is if it can recover from a crash like this:
>>>> /usr/ports/net/ceph/work/ceph-wip.FreeBSD/src/osd/OSD.cc: 3360:
>>>> FAILED assert(0 == "Missing map in load_pgs")
>>
>> If it depends on infomation in its local tree, things might be too
>> corrupt to restart it...
> 
> yes, the osdmap is stored in the meta collection, which in turn misses
> the subdir states stored in the xattr.
> 
>> But if it needs to be fetched from the rest of the cluster, I had a
>> different type of problem?
> 
> maybe you can rebuild that osd? the meta collection is different from
> one osd to another, i am not sure if we can copy it over from anther
> osd.

Well trouble started when I wanted to grow from 1 replica to 3 replica.
(So what is lost on osd.7 is not available elsewhere.)

This I did to see how that this growing behaves, and then this osd.7
crashed. From what I could find in the logfiles it complained about the
missing maps or attributes.

I guess I'll just scrap the cluster, and start fresh, because this could
very well be a FreeBSD-ish problem in combination with me doing silly
things. And I do not have to keep the cluster around, because it has
grown to a size that eats all my diskspace on the test hardware.

--WjW



