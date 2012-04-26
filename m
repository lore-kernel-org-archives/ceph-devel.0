From: Wido den Hollander <wido@widodh.nl>
Subject: Re: global_init fails when only specifying monitor address
Date: Thu, 26 Apr 2012 19:01:57 +0200
Message-ID: <4F997F85.5030604@widodh.nl>
References: <4F994883.3060805@widodh.nl> <Pine.LNX.4.64.1204260932260.6109@cobra.newdream.net> <56D7D5E0071D4CEB94971EAF7A27E75E@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:36957 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758051Ab2DZRCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Apr 2012 13:02:03 -0400
In-Reply-To: <56D7D5E0071D4CEB94971EAF7A27E75E@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/26/2012 06:57 PM, Greg Farnum wrote:
> On Thursday, April 26, 2012 at 9:33 AM, Sage Weil wrote:
>> On Thu, 26 Apr 2012, Wido den Hollander wrote:
>>> Hi,
>>>
>>> I tried to connect to a small Ceph setup on my desktop without cephx and that
>>> failed:
>>>
>>> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desktop.widodh.nl:6789) -s
>>> global_init: unable to open config file.
>>> root@stack01:~#
>>>
>>> I however worked with:
>>>
>>> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desktop.widodh.nl:6789) -c /dev/null -s
>>> 2012-04-26 14:55:33.828524 pg v148: 594 pgs: 594 active+clean; 0 bytes
>>> data, 7740 KB used, 70571 MB / 76800 MB avail
>>> 2012-04-26 14:55:33.829622 mds e1: 0/0/1 up
>>> 2012-04-26 14:55:33.836144 osd e14: 3 osds: 3 up, 3 in
>>> 2012-04-26 14:55:33.886429 log 2012-04-26 14:52:50.674430 osd.1
>>> [2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6807/28366 12 : [INF] 1.2b scrub ok
>>> 2012-04-26 14:55:33.892423 mon e1: 1 mons at
>>> {desktop=[2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6789/0}
>>> root@stack01:~#
>>>
>>> I quick look at global_init.cc (http://global_init.cc) showed me why this happened, it simply looks
>>> for a configuration file to open and when it can't it fails.
>>>
>>> But if a monitor address is set, a config file shouldn't be mandatory.
>>>
>>> It could be accomplished rather simple by setting the flag
>>> CINIT_FLAG_NO_DEFAULT_CONFIG_FILE if a mon_host has been set, but to do that
>>> conf->parse_argv(args); should move a few lines up.
>>>
>>> Comments? Thoughts?
>>
>> I wonder if the simplest thing to do is:
>>
>> - never error out on missing config in the default search path
>> - always error out on missing config if it was explicitly specified via
>> -c foo or CEPH_CONF in environment.
>>
>> ?
>>
>> sage
> I think this is probably right. I think that we may even error out correctly if we don't have values specified that we need, but we'll need to check that.

I agree, that would be indeed much easier :)

> I'm working on similar stuff as I look at monitor cluster additions for Carl, so I'll look at this today.

Thanks!

Wido

> -Greg
>
>
