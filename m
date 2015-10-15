From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 16:28:33 +0300
Message-ID: <20151015132832.GD7834@gmail.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
 <20151015063308.GA7834@gmail.com>
 <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com>
 <20151015123300.GC7834@gmail.com>
 <1121018324.46808736.1444913278970.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34569 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbbJON2k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 09:28:40 -0400
Received: by wicgb1 with SMTP id gb1so28297213wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 06:28:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1121018324.46808736.1444913278970.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <jdurgin@redhat.com>

On Thu, Oct 15, 2015 at 08:47:58AM -0400, Jason Dillaman wrote:
> > 
> > But we don't need them to match between different platforms, no? Is
> > linking 64bit code with 32bit possible (supported)?
> > 
> > Also, for this particular (char*) case, length would actually be the
> > length of the string, not the pointer length. From my example:
> > 
> > const char* journal_object_pool = "journal";
> > r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
> >                           journal_object_pool, strlen(journal_object_pool) +
> >                           1);
> > 
> 
> My original example was a string of length 4 vs a 4-byte int, but
> you said you were thinking of sizeof(type) instead.  I think this
> style of interface is great if you need to pass any arbitrary data
> along, but will we ever expect to pass along anything besides a
> string or an (u)int(32/64)?

I don't know, sure you have much more experience here, so if you
hardly expect other types in future, I would be rather then for
rbd_image_options_set_{uint64,str}() functions.

> On the flip-side, what will the C++ interface look like?  An
> equivalent API would imply passing a boost::any.  While certainly
> future-proof, something about that doesn't sit right with me as an
> API.  I think I would lean more towards something like xyz_set(const
> std::string&), xyz_set(uint64_t), et al.

For C++ I was also thinking about xyz_set(const std::string&),
xyz_set(uint64_t) variants, i.e:

int rbd::Image::options::set(int optname, const std::string& val);
int rbd::Image::options::set(int optname, uint64_t val);
...

-- 
Mykola Golub
