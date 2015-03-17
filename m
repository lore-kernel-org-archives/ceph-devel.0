From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: regenerating man pages
Date: Tue, 17 Mar 2015 09:49:54 -0700
Message-ID: <55085B32.9000305@redhat.com>
References: <55085911.9060800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbbCQQt5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 12:49:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2HGntMg007907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 12:49:55 -0400
In-Reply-To: <55085911.9060800@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/17/2015 09:40 AM, Ken Dreyer wrote:
> I had a question about the way that we're handling man pages.
>
> In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regenerate rbd(8)
> man page", it looks like man/rbd.8 was regenerated from doc/man/8/rbd.rst
>
> It seems like it would be more efficient to avoid storing man pages in
> Git and generate them dynamically at build time instead?

Yes, that'd be great!

> https://github.com/ceph/ceph/blob/master/admin/manpage-howto.txt
>
> "admin/build-doc" does a lot of things (including man page generation).
> Could we simply run the "sphinx-build -b man" part at build time as a
> part of "make"?

I don't see a reason not to. It's just a matter of making it work on all
the platforms we're building packages for. That might be annoying for
the entirety of build-doc, but for just building man pages it should
be simple.

Josh
