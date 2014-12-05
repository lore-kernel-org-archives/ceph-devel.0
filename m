From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: experimental features
Date: Fri, 05 Dec 2014 11:46:19 -0600
Message-ID: <5481EF6B.4010901@redhat.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net> <CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:62138 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaLERqX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 12:46:23 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so807112qcv.8
        for <ceph-devel@vger.kernel.org>; Fri, 05 Dec 2014 09:46:22 -0800 (PST)
In-Reply-To: <CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>



On 12/05/2014 11:39 AM, Gregory Farnum wrote:
> On Fri, Dec 5, 2014 at 9:36 AM, Sage Weil <sweil@redhat.com> wrote:
>> A while back we merged Haomai's experimental OSD backend KeyValueStore.
>> We named the config option 'keyvaluestore_dev', hoping to make it clear to
>> users that it was still under development, not fully tested, and not yet
>> ready for production.  In retrospect, I don't think '_dev' was
>> sufficiently scary because many users tried it and ran into
>> unexpectd trouble.
>>
>> There are several other features we've recently added or are considering
>> adding that fall into this category.  Having them in the tree is great
>> because it streamlines QA and testing, but I want to make sure that
>> users are not able to enable the features without being aware of the
>> risks.
>>
>> A few possible suggestions:
>>
>> - scarier option names, like
>>
>>    osd objectstore = keyvaluestore_experimental_danger_danger
>>    ms type = async_experimental_danger_danger
>>    ms type = xio_experimental_danger_danger
>>
>>    Once the feature becomes stable, they'll have to adjust their
>> config, or we'll need to support both names going forward.
>>
>> - a separate config option that allows any experimental option
>>
>>    allow experimental features danger danger = true
>>    osd objectstore = keyvaluestore
>>    ms type = xio
>>
>>    This runs the risk that the user will enable experimental features to
>> get X, and later start using Y without realizing Y is also
>> experiemental.
>>
>> - enumerate experiemntal options we want to enable
>>
>>    allow experimental features danger danger = keyvaluestore, xio
>>    ms type = xio
>>    osd objectstore = keyvaluestore
>>
>>    This has the property that no config change is necessary when the
>> feature drops its experimental status.
>>
>> In all of these cases, we can also make a point of sending something to
>> the log on daemon startup.  I don't think too many people will notice
>> this, but it is better than nothing.
>>
>> Other ideas?
>
> I don't think these should even be going into release packages for
> users to work with. We can build them on the dev gitbuilders for QA
> and testing without them ever reaching the hands of users grabbing our
> production packages. ;)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I'm in favor of the "allow experimental features" but instead call it:

"ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes things a 
little more explicit. With great power comes great responsibility.

Mark
