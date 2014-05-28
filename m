From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: A plea for more tooling usage
Date: Wed, 28 May 2014 14:21:49 -0700
Message-ID: <5386536D.7020503@inktank.com>
References: <20140506134826.GA17004@trvx.org> <alpine.DEB.2.00.1405060816160.28165@cobra.newdream.net> <20140515233431.GS13333@thinkpad.thebehrens.net> <20140527221935.GA15288@thinkpad.thebehrens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53489 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbaE1VVu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 17:21:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id x19so3551235ier.41
        for <ceph-devel@vger.kernel.org>; Wed, 28 May 2014 14:21:50 -0700 (PDT)
In-Reply-To: <20140527221935.GA15288@thinkpad.thebehrens.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thorsten Behrens <tbehrens@suse.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org

On 05/27/2014 03:19 PM, Thorsten Behrens wrote:
> I wrote:
>> Sage Weil wrote:
>>> If anybody is interested in helping with that effort, pull requests
>>> are very welcome!  :)
>>>
> [snip]
>
>> As hinted at in the patch, something like boost::program_options would
>> be nice, but that's a chunk of work & I'd rather hear feedback first
>> this way or the other. For the boost option, not sure if verbose error
>> reporting (the if (oss) parts) would translate over easily, I presume
>> that is deemed important?
>>
> Hi guys,
>
> any further opinion on that? If no one feels strongly, I think I'll
> just go ahead & hack something up with program_options, and see if
> that looks more pleasant. :)

It'd be interesting if you could use boost::program_options just
for the binary-specific flags.

Trying to use it for all options, including those from
common/config_opts.h, is a lot more effort. There was some work towards
that a while ago, though the branch is no longer there:

http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/11139

Josh
