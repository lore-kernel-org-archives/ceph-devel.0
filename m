From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Wed, 18 Dec 2013 13:10:50 -0800
Message-ID: <CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:42044 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab3LRVKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 16:10:52 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so198978qcy.23
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 13:10:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alexandre Oliva <oliva@gnu.org>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zheng.z.yan@intel.com>

On Wed, Dec 18, 2013 at 9:09 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 18 Dec 2013, Alexandre Oliva wrote:
>> On Dec 18, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:
>>
>> > On Tue, Dec 17, 2013 at 7:25 PM, Alexandre Oliva <oliva@gnu.org> wrote:
>> >> # setfattr -n ceph.parent /cephfs/mount/path/name
>
> Can we add an additional prefix indicating that this is a debug/developer
> kludge that is not intended to be supported in the long-term?
> ceph.dev.force_rewrite_backtrace or something?

While the "ceph.dev" namespace might be a good idea for other things,
I'm not sure we should merge anything that we can't support long-term.
This probably wouldn't be too hard to get working properly, but if
it's only going to impact people who have been using CephFS for so
long they can build their own clusters I'm not sure it's worth the
effort?
In particular, I don't think this interacts properly with projection,
so we can't make any guarantees that it's actually done what the user
wants if there are ongoing changes, and it's sort of weird to not pay
attention to if the update actually succeeds...
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

>
> sage
>
>>
>> > This seems like a good solution for fixing cephfs that was created
>> > before dumpling.
>>
>> There's more to it than just that, actually.  Renaming an entire subtree
>> won't update the parent attribute of files in there, so they will appear
>> to be incorrect (*).  This patch introduces a mechanism that could be
>> used to force them to be updated.
>>
>> (*) I'm well aware that they contain enough information to find the
>> updated information, so the redundant info in this attribute can be
>> harmlessly out-of-date, but if someone plans to use the data for other
>> purposes (like I sometimes do), it's useful to have them fully up to
>> date.  I also move large trees around, which makes this issue visible.
>>
>> --
>> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
>> You must be the change you wish to see in the world. -- Gandhi
>> Be Free! -- http://FSFLA.org/   FSF Latin America board member
>> Free Software Evangelist      Red Hat Brazil Compiler Engineer
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
