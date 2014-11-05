From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: Conflict with libgoogle-perftools4 in ubuntu12.04(precise)
Date: Wed, 5 Nov 2014 11:18:08 +0800
Message-ID: <CABF_e-E33_e29-N7TK9+Gd14+N-2_da8HyZN4KkMNOMKvdsXuA@mail.gmail.com>
References: <CABF_e-Fv1V8ACFFOYuiKWe8gy133P-eJuY0u8t4Nf3V_AWODrA@mail.gmail.com>
	<alpine.DEB.2.00.1411040109430.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:38571 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaKEDSJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 22:18:09 -0500
Received: by mail-oi0-f54.google.com with SMTP id a141so9664776oig.41
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 19:18:08 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411040109430.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2014-11-04 17:11 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Tue, 4 Nov 2014, Cheng Wei-Chung wrote:
>> Dear all:
>>
>> I know that the default precise repo did not have libgoogle-perftools4.
>> It should only have libgoogle-perftools0.
>> In the situation that we add the Ubuntu Cloud Archive will bring
>> libgoogle-perftools4 with havana icehouse, juno and later version.
>> It will make conflict with ceph if we have other softwares like
>> mongodb that depends on libgoogle-perftools4.
>>
>> I found the following feature:
>> http://tracker.ceph.com/issues/8039
>> Is this feature still haven't done, right?
>
> Right, it's not done yet.

OK, could I help to complete it?

>
>> I try to build the ceph version 0.87 with libgoogle-perftools4 and
>> upgrade from firefly in my test environment.
>>
>> It looks work normally. I think ceph can work on
>> libgoogle-perftools0/libgoogle-perftools4.
>
> Great!  It just needs patches to the packaging files, to go through
> testing, and then we need to make backported packages (possibly/probably)
> for a few older distros.
>
> It will be a bit awkward to to changed this for a stable release like
> firefly, though.  How disruptive will that be?
>
> sage

I also have simple I/O tests with openstack in my environment this weekend.
If these tests are OK, I think we could make backported packages and
test it again?

for change from a stable relase:
In my solution, I make sure the other ceph nodes and OSD processes are alive.
Upgrade only one node in the same time, because it will make some osd down for
a while due to removing ceph with libgoogle-perftools0.
In this stage, we need to remove libgoogle-perftools0 and install
libgoogle-perftools4
and its releated package.

After that, install a new ceph package and OSDs will resume working normally.

If I get something misunderstanding with your meaning, please feel
free to let me know!

thanks

vicente

>
>
>> Is there the plan for fix this conflict for the people using the
>> ubuntu cloud archive in precise?
>> Or we need to build a specific version with libgoogle-perftools4 if we
>> have any reasons to use libgoogle-perftools4.
>>
>> very thanks!!!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
