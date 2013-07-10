From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: Re: Contribution
Date: Wed, 10 Jul 2013 17:24:56 +0200
Message-ID: <CAA8043jpFRc3M-+WpO=rqvGJUXF7-FyXk04bRFLemWYfDmnTBA@mail.gmail.com>
References: <CAA8043idUL1qbWfrBffhYXL8JX0LZ+WsMseUypatret7PrxBGw@mail.gmail.com>
 <CABBk=J9-hrMgGJ6ofvR0uuzX_gTfKJhH_TFCS4fR6m6gD=UBmg@mail.gmail.com>
 <CAA8043g_vkZvx_ErHZbF8eq12T2bvvXGWA_u=NRdwEWnmaqaug@mail.gmail.com>
 <CAA8043iF3GFwQLonGvCY=A=_mKWYX1zAXEYFFMJ1cyuw1ZOspw@mail.gmail.com>
 <CABBk=J812X6RKR0cBo1mPF2Xm4agHHJrRMjgqpOEn9uosBt6-Q@mail.gmail.com>
 <CAA8043gZQFHNONx1dQsOYUtBRN-khc0JaWd4LbMsRNuQn0=byA@mail.gmail.com> <CABBk=J_qLgOnCnn24j68CgK-rmv6+E68ox7taiLMcPgV=VDtcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56802 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab3GJPZQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 11:25:16 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so9905358oag.34
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 08:25:16 -0700 (PDT)
In-Reply-To: <CABBk=J_qLgOnCnn24j68CgK-rmv6+E68ox7taiLMcPgV=VDtcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

Hi,

Thanks for pointing out more tasks to me.

I have lately worked on theses tasks.

#Issue #1779:

I updated this issue so it can be closed, as you told it does not need
backporting.

Issue #3074:

This one should be closed by now.

Issue #5416:

Now that radosgw also has --help supports, i would be able to add
--rgw-zone and --rgw-region
in help.

Btw, should we had some help text near the options in help? If so,
what should it be?

Issue #5374:

I updated my pull request as you commented on it.
It now uses JSONFormatter to create the JSON data.

S3 Keystone Issue #5506:

I got the main idea about this issue. But i'm lacking documentation on
how keystone
authenticate user with S3 credentials. Do you have any link on documentation?

temp URLs:

I've been looking at the code of rgw_rest_s3.cc.
Does the S3 temp url implementation relies in this file, in the
RGW_Auth_S3::authorize method?

Issue #4365:

As i asked on the issue, should we had wilcard support in role
definition ('*-service', 'adm-*', etc.) or a generic wildcard role,
which one allows any role from keystone? If so, how sould we define it?
(option, '*' role name, other?)

Thanks!

Best regards.

On Fri, Jul 5, 2013 at 9:05 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> Hi,
>
> sorry for the response delay, it's a holiday around here now.
>
> On Thu, Jul 4, 2013 at 6:58 AM, christophe courtaut
> <christophe.courtaut@gmail.com> wrote:
>> Hi Yehuda,
>>
>> Thanks for pointing out tasks to me.
>>
>> I have lately worked on theses tasks.
>> We are done with #1779, #5228 and #5324.
>>
>> #Issue #1779:
>>
>> This issue has been marked has resolved, but as Greg pointed out here
>> http://tracker.ceph.com/issues/1779,
>> it might be backported.
>>
>> Do you agree? If so, where should it be backported?
>
> It doesn't look to me like a bug fix that needs backporting.
>
>>
>> Issue #3074:
>>
>> I started looking at #3074, which one seems to be trivial,
>> but as commented on the issue http://tracker.ceph.com/issues/3074,
>> the options that should be in the help does not only belong to radosgw,
>> but seems to be a generic option parsed in many binaries.
>> i would need more info to step forward.
>>
>> Do we duplicate the option help in each binaries supporting it?
>> Do we use generic help? Or something else maybe?
>
> There is some generic help system for the common commands. Look at
> src/common/ceph_argparse.cc:generic_usage() and friends.
>>
>> Issue #5416:
>>
>> I digged into ceph code to find about the --rgw-zone option, but i had
>> no chance in finding where this option is parsed, so i'll be able to write help
>> for it.
>> As you told me too, i looked into cuttlefish branch, and many others,
>> but still can't find it.
>> It would be great if you could point me out where exactly does this
>> option lives.
>
> That's a generic config option, it's defined in
> src/common/config_opts.h. It's only relevant to the radosgw, and
> radosgw-admin binaries though.
>
>>
>> Issue #5374:
>>
>> A pull request has been made for the #5374, and you commented on it.
>> Btw i think the #5374 should be sandboxed to this issue and we should open
>> a new one for the feature you request about S3 keystone.
>
> I agree
>
>>
>> S3 Keystone:
>>
>> As i am new to keystone and s3, i need more explanation on the work to
>> be done here.
>> I'm not familiar with the authentication process in S3, and on how it could rely
>> on keystone. Do you have any ideas on what should be done?
>
> The idea is that there should be an alternative way to authenticate S3
> requests. Currently we handle the S3 authentication by verifying
> signature against the one we calculate by having the user credentials
> internally. However, certain deployments might just want to have the
> S3 users controlled by Keystone, and not create their credentials on
> the rados backend. We do a similar thing with swift, in which we send
> a request to Keystone to verify the tokens that we get. With S3 it's a
> bit different, as there's no real way to cache the 'tokens'. But in
> any case, it'll require sending a request to Keystone to validate the
> signature. I opened issue #5506 for that.
>
>>
>> temp URLs:
>>
>> You mentionned earlier a mecanism of temp URLs, already present in S3.
>> How does it works? What are there purpose?
>
> E.g., when providing a URL that accesses a private data. Unlike
> regular S3 authenticated requests, all the auth data resides in the
> request as request params (and not as HTTP fields).  The request
> params have a timestamp that specifies until when this url is valid,
> and also a signature.
>
>>
>> Issue #4365:
>>
>> For the #4365 issue, i think i miss some info about
>> what to do exactly. Do you have any hints on how wildcard role works?
>> How does rgw need to integrate this wildcard roles? new Rest API command?
>
> Currently we only allow Keystone users that have specific
> (preconfigured) roles set to access the system. A wildcard role will
> allow any Keystone users to access the system.
>
>>
>> Vstart documentation:
>>
>> I also submitted another pull request on vstart documentation.
>> As i previously written a manpage a while ago, i have been told
>> that a manpage is not the good way to document vstart.
>> I now propose a new documentation page.
>>
>> All feedbacks are very welcome.
>
> Great. I'll take a look at that, but probably Greg and Sage may want
> to take a look at it too (CC'ed).
>
> Thanks!
>
>
>> Best regards.
>>
>> On Mon, Jul 1, 2013 at 10:23 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>> Hi,
>>>
>>> On Mon, Jul 1, 2013 at 12:52 PM, christophe courtaut
>>> <christophe.courtaut@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I updated my pull request and looking forward #5416, and asked for
>>>> more information on the tracker.
>>>>
>>>> Nowadays, i'm iterating on the tracker to find issues i can fix.
>>>> I currently proposed fixes for #1779, #5228 and #5324.
>>>
>>> I pulled your fix for 1779. I commented on 5228 (a similar fix for
>>> that issue already went in, but your fix does some other things). I
>>> will pull 5324 (already commented on that at github).
>>>
>>>>
>>>> I'm not very familiar with tests, and it might be a little too big for
>>>> me to start with.
>>>> Btw, I was also in contact with Joe Buck to properly setup a fake cluster
>>>> suitable to make tests, as i was having trouble in doing that.
>>>>
>>>> To get started, i'm looking for things a bit smaller, that could fit in a day.
>>>>
>>>> I would be glad if you could point me to some specific tasks,
>>>> even if they are not specially related to the geo-replication blueprint,
>>>> the best for me remaining rgw related tasks as it's what i am trying to learn.
>>>
>>>
>>> Here are a few (ordered by complexity):
>>>
>>>  - 3074 (trivial)
>>>  - swift temp URLs (there's already a similar mechanism for S3)
>>>  - 5374
>>>  - 4365
>>>
>>> Thanks!
>>> Yehuda
>>>
>>>>
>>>> Best regards.
>>>>
>>>> On Thu, Jun 27, 2013 at 5:25 PM, christophe courtaut
>>>> <christophe.courtaut@gmail.com> wrote:
>>>>> ---------- Forwarded message ----------
>>>>> From: Yehuda Sadeh <yehuda@inktank.com>
>>>>> Date: Thu, Jun 27, 2013 at 5:21 PM
>>>>> Subject: Re: Contribution
>>>>> To: christophe courtaut <christophe.courtaut@gmail.com>
>>>>>
>>>>>
>>>>> On Thu, Jun 27, 2013 at 7:30 AM, christophe courtaut
>>>>> <christophe.courtaut@gmail.com> wrote:
>>>>>> Hi Yehuda,
>>>>>>
>>>>>> I went thru http://tracker.ceph.com/projects/rgw/issues today ( all 22
>>>>>> of them ;-) and contributed a patch to
>>>>>> http://tracker.ceph.com/issues/5324 ( that was an easy one ). I'd be
>>>>>> happy to either fix more bugs on the current development branch or
>>>>>> contribute to the geo-replication
>>>>>> https://github.com/ceph/ceph/commits/wip-rgw-geo-2
>>>>>>
>>>>>> The amount of work going on with wip-rgw-geo is impressive and I'm not
>>>>>> sure what I could do to help. It would be most convenient for me to
>>>>>> pick from a list of self contained tasks in the tracker. I would be
>>>>>> happy to spend a few days on each of them, one at a time. Since I'm
>>>>>> still new to the code base, working on a tasks that would require
>>>>>> weeks of work is probably too ambitious at this point. However, I very
>>>>>> much understand that the definition of such tasks requires a fair
>>>>>> amount of work on your part. And if noone works on these tasks, this
>>>>>> would be a waste of your time. If that helps, I promise to diligently
>>>>>> work on them, full time :-)
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>>    I saw your pull request, and also commented on the commit. There's
>>>>> a similar easy issue (#5416) that you can take a look at now if you'd
>>>>> like.
>>>>> I think that at the moment with regard to the geo-replication, the
>>>>> most helpful thing would be to test the different APIs, make sure they
>>>>> work as expected as we're on a tight schedule, and planning a feature
>>>>> freeze by the end of next week.
>>>>> The API specifications are in the wiki
>>>>> (http://wiki.ceph.com/RESTful_API_for_DR_%2F%2F_Geo-Replication).
>>>>> Specifically I'm interested in data sync, as it's the path less
>>>>> tested. If you could simulate (even manually) a scenario, where you
>>>>> put an object in a bucket, check to see whether bucket is listed in
>>>>> the data log, then go to the bucket index log, see the change entry in
>>>>> the bucket index log, then generate a copy of that object from the
>>>>> master zone to the secondary zone. Look at the operation state log to
>>>>> see whether this operation is marked as completed.
>>>>> Check to see whether the object appears in the secondary zone, check
>>>>> its attributes.
>>>>> That tests a wide range of the new APIs, and it'll be really helpful.
>>>>> If you could somewhat automate it and create a script that does it,
>>>>> it'll be extra helpful.
>>>>>
>>>>> Most of the other DR/geo-replication tasks are either done (waiting
>>>>> for review and merge) or being implemented now. There are other
>>>>> non-geo-replication issues that I can assign to you if you want to get
>>>>> your feet dipped in the rgw code. Even if these are not a direct
>>>>> geo-replication issues it may help us getting geo-replication out the
>>>>> door faster as it'll free me to work on geo-replication. Let me know
>>>>> if you're interested.
>>>>>
>>>>> Thanks!
>>>>> Yehuda
>>>>>
>>>>>
>>>>> --
>>>>> Christophe Courtaut
>>>>
>>>>
>>>>
>>>> --
>>>> Christophe Courtaut
>>
>>
>>
>> --
>> Christophe Courtaut



-- 
Christophe Courtaut
