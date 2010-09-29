From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Several patches for CEPH
Date: Wed, 29 Sep 2010 10:42:43 -0700
Message-ID: <AANLkTikFQZtvzhR3wcChXV0j1ZjyTU7VFU2b24Q+pVME@mail.gmail.com>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
	<AANLkTimSQKsa60B1i1FyxDQDu91SKCPLF9yAEARY3nks@mail.gmail.com>
	<AANLkTikbbO48kojFbV3jQ8L2A77mr5rRGd_=fKE+XB3W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50112 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab0I2Rmo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Sep 2010 13:42:44 -0400
Received: by qyk33 with SMTP id 33so1544879qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 10:42:43 -0700 (PDT)
In-Reply-To: <AANLkTikbbO48kojFbV3jQ8L2A77mr5rRGd_=fKE+XB3W@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 29, 2010 at 9:29 AM, Henry C Chang
<henry_c_chang@tcloudcomputing.com> wrote:
> On Thu, Sep 23, 2010 at 1:14 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
>> On Wed, Sep 22, 2010 at 8:29 AM, Henry C Chang
>> <henry_c_chang@tcloudcomputing.com> wrote:
>>> 1. http://github.com/tcloud/ceph/commit/3c91d0c0e20425f94eaa374f39b2a1f398270255
>>>
>>> This fixed a monitor bug we hit several times. When some osds report
>>> that other osds are down,
>>> there is a chance that the leading monitor would enter an infinite loop (you can
>>> see the CPU usage of cmon is 100% from "top").
>> You diagnosed the problem correctly, but it looks like your patch can
>> make the monitor discard the wrong report! Fixed this by sticking an
>> "&& i != fail_notes.end()" into the while loop, in
>> commit:2c5a3d99aa3be5ce114072e84f73a0a6426e63fd.
>
> With this commit, however, if i == fail_notes.end() and leaves the while loop,
> it will cause segfault/abort in the following if-else when
> fail_notes.erase(i) is called.
> (I wonder if my patch is right.)
Whoops, I missed that in the branching.
The basic problem here is that if you reach end() then attempting to
deref either of the values returns 0 -- which in this case can be a
valid value. So, also, check for end() in the if clause.
commit:ba39fd782375dc1bc909519fa3f5307a9696032b

In your proposed patch, there's a similar problem as presently: if
there are no reports in the current epoch of the given OSD (say osd0),
the iterator will start out on the next OSD (osd1) -- but if you have
reported that osd1 is down, then the outside if block will evaluate to
true (because the target is not equal, even though the reporter is),
and then you will pass the reporter check, and then you will delete
the incorrect report.
:)
-Greg
