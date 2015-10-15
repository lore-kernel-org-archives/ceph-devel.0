From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 08:05:07 -0400 (EDT)
Message-ID: <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com>
References: <20150930065044.GA14958@gmail.com> <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com> <20151015063308.GA7834@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34627 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJOMFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 08:05:09 -0400
In-Reply-To: <20151015063308.GA7834@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <jdurgin@redhat.com>

> > I am concerned about passing a void* + length to specify the option
> > value since you really can't protect against the user providing data
> > in the incorrect format.  For example, if the backend treated
> > RBD_OPTION_STRIPE_UNIT as a 4byte int, what happens if someone
> > passes a 2- or 8-byte int or a 4-byte char* string?
> 
> Then rbd_image_options_set() will fail with EINVAL, because the option
> type (size) is a part of interface.
> 
> I do this by analogy to setsockopt(2):
> 
> http://pubs.opengroup.org/onlinepubs/009695399/functions/setsockopt.html
> 
> Note option type documented for every option there, and it works
> fairly well.
> 
> Following a common practice is an additional argument to this
> approach to me.

Except for the following cases:

sizeof(char*) == sizeof(uint32_t) (32bit)
sizeof(char*) == sizeof(uint64_t) (64bit)

-- 

Jason Dillaman 
