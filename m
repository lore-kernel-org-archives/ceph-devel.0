From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 08:47:58 -0400 (EDT)
Message-ID: <1121018324.46808736.1444913278970.JavaMail.zimbra@redhat.com>
References: <20150930065044.GA14958@gmail.com> <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com> <20151015063308.GA7834@gmail.com> <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com> <20151015123300.GC7834@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:39953 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbJOMr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 08:47:59 -0400
In-Reply-To: <20151015123300.GC7834@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <jdurgin@redhat.com>

> 
> But we don't need them to match between different platforms, no? Is
> linking 64bit code with 32bit possible (supported)?
> 
> Also, for this particular (char*) case, length would actually be the
> length of the string, not the pointer length. From my example:
> 
> const char* journal_object_pool = "journal";
> r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
>                           journal_object_pool, strlen(journal_object_pool) +
>                           1);
> 

My original example was a string of length 4 vs a 4-byte int, but you said you were thinking of sizeof(type) instead.  I think this style of interface is great if you need to pass any arbitrary data along, but will we ever expect to pass along anything besides a string or an (u)int(32/64)?

On the flip-side, what will the C++ interface look like?  An equivalent API would imply passing a boost::any.  While certainly future-proof, something about that doesn't sit right with me as an API.  I think I would lean more towards something like xyz_set(const std::string&), xyz_set(uint64_t), et al.

I've been witness to too many type-casting issues in the past (in fact just hit one last night within CephContext), which makes me lean more towards having the compiler be able to enforce type-correctness.

--

Jason
