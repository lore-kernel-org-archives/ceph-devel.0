From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 00:54:16 +0100
Message-ID: <f2aa4fc4-8bb8-7c53-d792-2f7b341eb985@digiware.nl>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57111 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbdCHAB7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 19:01:59 -0500
In-Reply-To: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 7-3-2017 23:48, Sage Weil wrote:
> We have three competing PRs to address the crashes when -O0 is used:
> 
> lixiaoy1	https://github.com/ceph/ceph/pull/12796
> kefu		https://github.com/ceph/ceph/pull/13819
> adam		https://github.com/ceph/ceph/pull/12931
> 
> Adam's is appealing because it will ensure the bounded encodes are in fact 
> constant at compile time.  Unfortunately, it requires you to define DENC 
> twice, like so:
> 
> -  DENC_FEATURED(bar_t, v, p, f) {
> +  DENC_FEATURED_BOUNDED(bar_t, v, p, f) {
>      ::denc(v.a, p, f);
>      ::denc(v.b, p, f);
>    }
> +  DENC_FEATURED_BOUND_ENCODE(bar_t, p, f) {
> +    DENC_START(1, 1, p);
> +    ::denc(bounded_t<decltype(bar_t::a)>{}, p, f);
> +    ::denc(bounded_t<decltype(bar_t::b)>{}, p, f);
> +    DENC_FINISH(p);
> +  }
> 
> which feels like a deal-killer to me... I think I'd rather just drop the 
> check entirely and rely on the developer to be careful.
> 
> The other two PRs fix up the handful of type(s) that were actually causing 
> failures to manually define bound (again making the single DENC macro 
> unusable).
> 
> What about instead changing all of the instances of
> 
>       denc(*(const T*)nullptr, elem_size);
> 
> with a macro that will either do the above "*(const T*)nullptr" -or-, if 
> it looks like this is a debug build or compiler optimizations are off or 
> some other compiler environment indicates it won't work, replace it with 
> "T()"?  That avoids crashes in the -O0 case, but still lets us keep some 
> safeguard for other builds?
> 
> Any other ideas?

Hi Sage,

Clang is already complaining about the current construction, and any fix
would be nice to not have Clang complain.
I have not yet run into crashes (even when compiling with -O0), but that
might be because the current crash is in Bluestore I think. And I do not
build that for FreeBSD.

Why would 2 defines be a deal breaker, if otherwise the burden also is
the the developer that needs to take care of possible pitfalls.

And I would expect to have your second option to still run into warnings
with Clang if not compiling with -O0 and we still compile "*(const
T*)nullptr"

--WjW


/home/jenkins/workspace/ceph-master/src/include/denc.h:1162:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:1169:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:1236:10: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
    denc(*(bool *)nullptr, p);
         ^~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:682:12: warning:
binding dereferenced null pointer to reference has undefined behavior
[-Wnull-dereference]
      denc(*(const T*)nullptr, elem_size);
           ^~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/include/denc.h:1304:11: note: in
instantiation of function template specialization
'_denc::container_base<std::vector,
_denc::pushback_details<std::__1::vector<snapid_t,
std::__1::allocator<snapid_t> > >, snapid_t,
std::__1::allocator<snapid_t> >::bound_encode<snapid_t>' requested here

  traits::bound_encode(o, len);
          ^
/home/jenkins/workspace/ceph-master/src/common/snap_types.h:58:7: note:
in instantiation of function template specialization
'encode<std::__1::vector<snapid_t, std::__1::allocator<snapid_t> >,
denc_traits<std::__1::vector<snapid_t, std::__1::allocator<snapid_t> >,
void> >' requested here
    ::encode(snaps, bl);
      ^


