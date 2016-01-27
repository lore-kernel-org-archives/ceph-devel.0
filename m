From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Thu, 28 Jan 2016 00:29:02 +0800
Message-ID: <CACJqLyYkniPVVhG4WEzYM7PMYnTVODMnopK5exMxGrkC-ibiPQ@mail.gmail.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
	<CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com>
	<alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
	<alpine.DEB.2.11.1601270956260.6524@cpach.fuggernut.com>
	<56A8E142.4040401@42on.com>
	<alpine.DEB.2.11.1601271042590.6524@cpach.fuggernut.com>
	<56A8EA6D.1030808@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33840 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbcA0Q3D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 11:29:03 -0500
Received: by mail-ig0-f176.google.com with SMTP id ik10so84543899igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 08:29:03 -0800 (PST)
In-Reply-To: <56A8EA6D.1030808@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 28, 2016 at 12:03 AM, Wido den Hollander <wido@42on.com> wrote:
>
>
> On 27-01-16 16:45, Sage Weil wrote:
>> On Wed, 27 Jan 2016, Wido den Hollander wrote:
>>> On 27-01-16 15:59, Sage Weil wrote:
>>>> Loic pointed out that adding a new config file that is overrides/combines
>>>> with the global config makes our already-complicated config infrastructure
>>>> even more so.  And it turned out to be more complicated to implement than
>>>> I'd hoped.  On the other hand, I think there are valid use-cases for a
>>>> global config, e.g.:
>>>>
>>>>  - most config on the osd disk itself
>>>>  - /etc/ceph/ceph.conf containing crush_location and mon_host
>>>>
>>>> ...and with a single config I'm not sure how we'd get the datacenter
>>>> location set properly.
>>>>
>>>
>>> Yes, you probably want the mon_host variable in a global config. We
>>> might and I say *might* want to look at a DNS lookup at some time?
>>>
>>> A lookup for 'ceph-monitor' in the current DNS search domain. But that
>>> might be offtopic here.
>>
>> Yeah, I think if we make standard practice setting up DNS with an A or
>> AAAA record for each monitor then we can avoid a global mon_host.  But
>> there's still the crush location piece...
>>
>
> Yes. I created a issue for that: http://tracker.ceph.com/issues/14527
>
>>>> Anyway, I have two versions implemented.  The first just adds
>>>> $data_dir/config to the search pathh:
>>>>
>>>>     https://github.com/ceph/ceph/pull/7377
>>>>
>>>
>>> I like the first patch, but it doesn't seem to merge the config files,
>>> right?
>>>
>>> If a global /etc/ceph/ceph.conf is found it doesn't search any further.
>>>
>>>> The second adds the extra_config infrastructure.  It's just the last patch
>>>> that is different:
>>>>
>>>>     https://github.com/ceph/ceph/pull/7378
>>>>
>>>
>>> The --extra-config seems weird to me. Isn't there a way where you supply
>>> --config multiple times with multiple files?
>>
>> Right now config is a search path, and when it finds a match, it stops and
>> uses that config file exclusively.  extra_config is a way to merge two of
>> them.  I agree it's not ideal...
>>
>> An alternative approach would be to support 'include <file>' so that the
>> $data_dir/config, if present, would include something from /etc/ceph.
>>
>
> I think that a include would be much nicer. I filed a issue for that
> some time ago: http://tracker.ceph.com/issues/4771
>
> The default config we created for a daemon could be just a one-liner:
>
>
> /var/lib/ceph/osd/ceph-0/ceph.conf:
>
> include "/etc/ceph/ceph.conf"

The most annoying thing I think is config section and section
priority, I'm not sure
PR(https://github.com/ceph/ceph/pull/7378/files) resolve this problem.

For example, global ceph conf has [global] and [osd.0] section, local
ceph conf has [osd] section, which has higher priority?

Then local ceph conf now will clear global ceph conf section if exists
overlap, it will make thing misunderstanding for users.


>
> Wido
>
>> sage
>>



-- 
Best Regards,

Wheat
