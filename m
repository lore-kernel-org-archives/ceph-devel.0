From: David Zafman <dzafman@redhat.com>
Subject: Re: regenerating man pages
Date: Tue, 17 Mar 2015 12:27:04 -0700
Message-ID: <55088008.8010807@redhat.com>
References: <55085911.9060800@redhat.com> <55085B32.9000305@redhat.com> <alpine.DEB.2.00.1503171011020.3716@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbbCQT1E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 15:27:04 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id B3DAAC63E4
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 19:27:04 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1503171011020.3716@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I found that I could not build the docs on Ubuntu 14.10 with the proper 
packages installed.  Kefu is looking into Asphyxiate which is very 
tempermental.  I installed an Ubuntu 11.10 in order to generate docs.

David

On 3/17/15 10:11 AM, Sage Weil wrote:
> On Tue, 17 Mar 2015, Josh Durgin wrote:
>> On 03/17/2015 09:40 AM, Ken Dreyer wrote:
>>> I had a question about the way that we're handling man pages.
>>>
>>> In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regenerate rbd(8)
>>> man page", it looks like man/rbd.8 was regenerated from doc/man/8/rbd.rst
>>>
>>> It seems like it would be more efficient to avoid storing man pages in
>>> Git and generate them dynamically at build time instead?
>> Yes, that'd be great!
>>
>>> https://github.com/ceph/ceph/blob/master/admin/manpage-howto.txt
>>>
>>> "admin/build-doc" does a lot of things (including man page generation).
>>> Could we simply run the "sphinx-build -b man" part at build time as a
>>> part of "make"?
>> I don't see a reason not to. It's just a matter of making it work on all
>> the platforms we're building packages for. That might be annoying for
>> the entirety of build-doc, but for just building man pages it should
>> be simple.
> I think the original reason we didn't was just because there are a lot of
> dependencies for building the docs, so this inflates Build-Depends.  That
> doesn't particularly bother me, though, if the deps do in fact exist.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

