From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: changing default installed packages by ceph-deploy
Date: Fri, 31 Jul 2015 11:26:59 -0700
Message-ID: <CACkq2mr6ERroUfjk-sVbhJ0vPUsGKXpcNC8a2weRB7K7NtgFzA@mail.gmail.com>
References: <CACkq2mpmFLotjC9u45YHK=fGyUT8kzgvmkX0voxXoasfrLX1ew@mail.gmail.com>
 <20150731120930.54c5b266@g21.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33954 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbGaS1T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 14:27:19 -0400
Received: by oigi136 with SMTP id i136so42483882oig.1
        for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2015 11:27:19 -0700 (PDT)
In-Reply-To: <20150731120930.54c5b266@g21.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 31, 2015 at 3:09 AM, David Disseldorp <ddiss@suse.de> wrote:
> On Wed, 29 Jul 2015 15:41:29 -0700, Travis Rhoden wrote:
>
>> There are the following flags in ceph-deploy today that can control
>> what daemons get installed:
>>
>>  ceph-deploy install --help
>> ...
>>   --mon                 install the mon component only
>>   --mds                 install the mds component only
>>   --rgw                 install the rgw component only
>>   --osd                 install the osd component only
>>   --cli, --common       install the common component only
>>   --all                 install all ceph components (e.g. mon,osd,mds,rgw).
>>                         This is the default
>>
>> So, my proposal is to change the default behavior from "ceph-deploy
>> install --all ..." to "ceph-deploy install --mon --osd ...".
>>
>> Any objections?
>
> Sounds good to me Travis.

I received some feedback that while this change would make sense all
around, it would represent a non-backwards-compatible change, and that
is true.  There are scripts out there that presume everything is
installed by default, and we don't want to break those...

What I *can* do, however, is build off of the work you did in
https://github.com/ceph/ceph-deploy/pull/324/commits, and install a
subset of packages when requested to do so.  This works even before
the ceph->ceph-mon/ceph-osd split arrives.  Thanks for that code. :)
I've added http://tracker.ceph.com/issues/12543 to cover that.

>
> For the ceph-deploy install --iscsi changes at
> https://github.com/ceph/ceph-deploy/pull/326 I had intentionally left
> targetcli out of the --all group so that it wouldn't be installed by
> default, but I'll add it if your proposed changes go in.
> Any thoughts on the install --iscsi changes?

Added feedback on that pull request. Sorry for the delay!

>
> Cheers, David
