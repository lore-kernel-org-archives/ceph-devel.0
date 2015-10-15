From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 11:29:56 -0700
Message-ID: <561FF0A4.3000805@redhat.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
 <20151015063308.GA7834@gmail.com>
 <446012806.46791295.1444910707804.JavaMail.zimbra@redhat.com>
 <20151015123300.GC7834@gmail.com>
 <1121018324.46808736.1444913278970.JavaMail.zimbra@redhat.com>
 <20151015132832.GD7834@gmail.com>
 <alpine.DEB.2.00.1510150644390.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45459 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbbJOS2t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Oct 2015 14:28:49 -0400
In-Reply-To: <alpine.DEB.2.00.1510150644390.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Mykola Golub <mgolub@mirantis.com>
Cc: Jason Dillaman <dillaman@redhat.com>, ceph-devel@vger.kernel.org

On 10/15/2015 06:45 AM, Sage Weil wrote:
> On Thu, 15 Oct 2015, Mykola Golub wrote:
>> On Thu, Oct 15, 2015 at 08:47:58AM -0400, Jason Dillaman wrote:
>>>>
>>>> But we don't need them to match between different platforms, no? Is
>>>> linking 64bit code with 32bit possible (supported)?
>>>>
>>>> Also, for this particular (char*) case, length would actually be the
>>>> length of the string, not the pointer length. From my example:
>>>>
>>>> const char* journal_object_pool = "journal";
>>>> r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
>>>>                            journal_object_pool, strlen(journal_object_pool) +
>>>>                            1);
>>>>
>>>
>>> My original example was a string of length 4 vs a 4-byte int, but
>>> you said you were thinking of sizeof(type) instead.  I think this
>>> style of interface is great if you need to pass any arbitrary data
>>> along, but will we ever expect to pass along anything besides a
>>> string or an (u)int(32/64)?
>>
>> I don't know, sure you have much more experience here, so if you
>> hardly expect other types in future, I would be rather then for
>> rbd_image_options_set_{uint64,str}() functions.

This is my favorite option too.

> Having a str and int variant seems like the best path to me.  Maybe int64
> though, so that signed values are possible?

Don't think we need any signed values currently. It doesn't cause any
ABI problems to add signed ints or other types later, since it'll
already be overloaded in C++, and for C they need to be new functions
anyway.

>>> On the flip-side, what will the C++ interface look like?  An
>>> equivalent API would imply passing a boost::any.  While certainly
>>> future-proof, something about that doesn't sit right with me as an
>>> API.  I think I would lean more towards something like xyz_set(const
>>> std::string&), xyz_set(uint64_t), et al.
>>
>> For C++ I was also thinking about xyz_set(const std::string&),
>> xyz_set(uint64_t) variants, i.e:
>>
>> int rbd::Image::options::set(int optname, const std::string& val);
>> int rbd::Image::options::set(int optname, uint64_t val);

Sounds good to me.

Josh

