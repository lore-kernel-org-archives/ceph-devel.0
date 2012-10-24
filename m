From: David Zafman <david.zafman@inktank.com>
Subject: Re: getting kernel debug output
Date: Wed, 24 Oct 2012 11:25:28 -0700
Message-ID: <5BBD7804-E54E-442D-95A6-CAED5C2FDBDE@inktank.com>
References: <alpine.DEB.2.00.1210241007500.31573@cobra.newdream.net> <50883019.5040506@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45722 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934943Ab2JXSZa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 14:25:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so752137oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 11:25:30 -0700 (PDT)
In-Reply-To: <50883019.5040506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org


I also added a kcon_most teuthology task which does almost the same thing as ceph/src/script/kcon_most.sh to all or any set of clients.  The teuthology version does not raise the console log level.

For example:

tasks:
- ceph:
- kclient:
- kcon_most:
- interactive:


On Oct 24, 2012, at 11:14 AM, Alex Elder <elder@inktank.com> wrote:

> On 10/24/2012 12:11 PM, Sage Weil wrote:
>> I'm working on http://tracker.newdream.net/issues/3342 and was able to 
>> reproduce the msgr bug (some annoying msgr race I think) while generating 
>> full libceph debug output.  I used a teuthology yaml fragment like so:
> 
> I have more trouble than that, but perhaps there's something
> weird about having my serial console connected from 1500 miles
> away.  I'm impressed full debugging didn't mess things up.
> 
>> tasks:
>> - clock: null
>> - ceph:
>>    log-whitelist:
>>    - wrongly marked me down
>>    - objects unfound and apparently lost
>> - thrashosds: null
>> - kclient: null
>> - exec:
>>    client.0:
>>      - echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control
> 
> This is cool, I didn't know you could do this.
> 
>> - workunit:
>>    clients:
>>      all:
>>      - suites/ffsb.sh
>> 
>> I was pleasantly surprised that even though this is putting copious 
>> amounts of crap in dmesg it didn't slow things down enough to avoid 
>> tripping the bug.  And the 'dmesg' command in kdb appears to be working 
>> now (a couple months back it wasn't).  Yay!
> 
> For me, dmesg has been working, but I'd like to know how to
> truncate the output to just, say, the last 200 lines.  (Maybe
> there is one.)
> 
>> Anyway, this might be useful in tracking down other bugs as well...
> 
> Yes, this is good news.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

