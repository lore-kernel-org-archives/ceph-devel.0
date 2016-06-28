From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: prefered behavior for injecting untracked args
Date: Tue, 28 Jun 2016 12:00:11 -0700
Message-ID: <CAJ4mKGZTDmD=jW6KumYP80NQzojoO_sG=G7g0M-_o2JDVwRG1w@mail.gmail.com>
References: <CAEYCsVJz9b8fDdEz8V7iraoq6t6wtY8ddt4XqBnxEVmvAcLnfA@mail.gmail.com>
 <alpine.DEB.2.11.1606281533160.8816@piezo.us.to> <9421c622-ef5f-235b-57c2-04b85da1cd4b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36146 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcF1TAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 15:00:18 -0400
Received: by mail-vk0-f54.google.com with SMTP id k62so25169435vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 12:00:12 -0700 (PDT)
In-Reply-To: <9421c622-ef5f-235b-57c2-04b85da1cd4b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, Xiaoxi Chen <superdebuger@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 9:41 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 28-6-2016 17:38, Sage Weil wrote:
>> On Tue, 28 Jun 2016, Xiaoxi Chen wrote:
>>> Hi,
>>>
>>>    In jewel , when handling "inject-args" command, monitor will report
>>> "unchangeable" for those non-tracking args, nevertheless, the config
>>> is still updated. as "ceph daemon config show " will give out the new
>>> value.
>>>
>>>      It looks to me like if the configuration is not dynamically
>>> changeable, we may better NOT to update the config? as the config set
>>> by injectargs is not persist to disk , so before reboot the daemon,
>>> config will not take effect, after reboot the daemon, config will
>>> lost...it doesnt work(i.e make the config change) anyway.
>>>
>>>     We notice this because we had an accident on our network switch so
>>> lots of the OSD down and out, and we would intent to speed up the
>>> recovery, then we inject "osd_recovery_max_active= 10" and got
>>> "unchangeable", but in admin socket we can see this configuration so
>>> we assume it is working but actually not. My point is the non-tracking
>>> args showing in admin socket config dump is really misleading, other
>>> guys will never know whether the args in config dump is make effect if
>>> they don't know how this is set, via admin socket or via configuration
>>> files.
>>>
>>>     Kefu and I had some discussion on the original PR and would like to
>>> here more opinions, See pr for more background:
>>> https://github.com/ceph/ceph/pull/7085.
>>
>> We desperately need to overhaul the way that config options are described
>> and updated.  Right now we are cheating by letting any integer option be
>> changed, regardless of whether an observer is defined, and no string
>> options to be changed without an observer.  (This is the minimum necessary
>> to make config updates thread safe.)
>>
>> I think we need to extend the config_opts.h definitions of config options
>> to include things like accepted values (for enums), and annotations
>> indicating whether online updates are possible.  This *could* be implied
>> by the presence of observers, but in practice most of the options are used
>> directly out of g_conf and don't have observers defined...that would be
>> a bigger changes. Just setting a flag in the config options would be a
>> start.
>>
>> We've discussed this a few times in the past and there is probably an
>> etherpad sitting around somewhere from an old CDS...
>>
>> As to your specific question(s),
>>
>> 1- injectargs is never going to persis anything.  but we're looking at the
>> ability to define config options for the cluster via the mon, that that
>> would be persisted.
>>
>> 2- making message you see accurate would be good.
>>
>> 3- we may want to revise the observer framework a bit so that a set option
>> can be rejected.  Right now the internal interface doesn't allow this.
>
> If we are going to change the framework for option definition.
> Would it be possible that there is a field to be used during doc
> generation so that it is possible to start autoextracting the
> functionality of said option.
> Just let all the descriptions be empty of the moment, test will be
> inserted over due time.

Yeah, this comes up every time we discuss enhancing options handling.
Generally alongside labeling options as user-settable or
developer-only (and locked down in some way).
-Greg
