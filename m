From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 15:33:02 +0300
Message-ID: <20151015123300.GC7834@gmail.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
 <20151015063308.GA7834@gmail.com>
 <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34961 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbJOMdH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 08:33:07 -0400
Received: by wicll6 with SMTP id ll6so38558402wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 05:33:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <jdurgin@redhat.com>

On Thu, Oct 15, 2015 at 08:05:07AM -0400, Jason Dillaman wrote:
> > > I am concerned about passing a void* + length to specify the option
> > > value since you really can't protect against the user providing data
> > > in the incorrect format.  For example, if the backend treated
> > > RBD_OPTION_STRIPE_UNIT as a 4byte int, what happens if someone
> > > passes a 2- or 8-byte int or a 4-byte char* string?
> > 
> > Then rbd_image_options_set() will fail with EINVAL, because the option
> > type (size) is a part of interface.
> > 
> > I do this by analogy to setsockopt(2):
> > 
> > http://pubs.opengroup.org/onlinepubs/009695399/functions/setsockopt.html
> > 
> > Note option type documented for every option there, and it works
> > fairly well.
> > 
> > Following a common practice is an additional argument to this
> > approach to me.
> 
> Except for the following cases:
> 
> sizeof(char*) == sizeof(uint32_t) (32bit)
> sizeof(char*) == sizeof(uint64_t) (64bit)

But we don't need them to match between different platforms, no? Is
linking 64bit code with 32bit possible (supported)?

Also, for this particular (char*) case, length would actually be the
length of the string, not the pointer length. From my example:

const char* journal_object_pool = "journal";
r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
                          journal_object_pool, strlen(journal_object_pool) + 1);

-- 
Mykola Golub
