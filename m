From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: v0.24.1 released
Date: Mon, 10 Jan 2011 16:50:39 -0800
Message-ID: <AANLkTi=eqODNCvC11sCp=651t0ha1t9Rc+6hr589RU7j@mail.gmail.com>
References: <Pine.LNX.4.64.1101092141550.28455@cobra.newdream.net>
	<AANLkTikCwDeutENJqpqFzvyHEu4H+VdcrLNFwQ=MwQBP@mail.gmail.com>
	<AANLkTik9v2kctQib4pUCkvEwTYvZDHvEDiiLD_JWU6aN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab1AKAul (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jan 2011 19:50:41 -0500
Received: by fxm20 with SMTP id 20so19447834fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jan 2011 16:50:40 -0800 (PST)
In-Reply-To: <AANLkTik9v2kctQib4pUCkvEwTYvZDHvEDiiLD_JWU6aN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Terrance Hutchinson <terrance.hutchinson@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Terrance,

We haven't tested RHEL 6 yet. My feeling is that it will be strictly
easier, since more packages are likely to be officially supported in 6
than in 5. I guess perhaps where to find libedit might change.

On Mon, Jan 10, 2011 at 3:01 PM, Terrance Hutchinson
<terrance.hutchinson@gmail.com> wrote:
> What about RHEL 6? If you need help, let me know.

Sure! Help is always welcome. As Sage mentioned, we'd love to build
RPM packages for RHEL distributions. The spec file we have now is
almost complete enough to do that, but it needs a little bit of work.

Also if you find anything handy, be sure to update the wiki!

regards,
Colin


>
> On Jan 10, 2011 1:15 PM, "Colin McCabe" <cmccabe@alumni.cmu.edu> wrote:
>> On Sun, Jan 9, 2011 at 9:42 PM, Sage Weil <sage@newdream.net> wrote:
>>> We plan to start building RHEL/CentOS and Fedora packages soon,
>>> and will be updating the wiki with information on gathering all the
>>> dependencies to build from source shortly.
>>
>> For RHEL/CentOS users: there is now a wiki page to help with installing
>> Ceph:
>> http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS
>>
>> The instructions were tested under CentOS 5.4.
>>
>> cheers,
>> Colin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
