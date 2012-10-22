From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 09:28:46 -0700
Message-ID: <CAC-hyiHFiryTZYi_wC_BswcK49k_ek346o1qhu6NPZDTquPuQg@mail.gmail.com>
References: <508469CE.3000502@gmail.com>
	<alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
	<508562A1.2040106@gmail.com>
	<50856F74.8020001@inktank.com>
	<CAC-hyiFkOKxef+iJ2NidNL4_yPwu5jxaxvjC+z82_rGJdJJbmw@mail.gmail.com>
	<50857206.1050702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46857 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2JVQ2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:28:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1152084bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:28:46 -0700 (PDT)
In-Reply-To: <50857206.1050702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Joe Buck <jbbuck@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 22, 2012 at 9:19 AM, Sam Lang <sam.lang@inktank.com> wrote:
> On 10/22/2012 11:14 AM, Yehuda Sadeh wrote:
>>
>> On Mon, Oct 22, 2012 at 9:08 AM, Sam Lang <sam.lang@inktank.com> wrote:
>>>
>>> On 10/22/2012 10:13 AM, Joe Buck wrote:
>>>>
>>>>
>>>> On 10/21/2012 02:35 PM, Sage Weil wrote:
>>>
>>>
>>>
>>>>> Also, we should fix the auth none usage at some point.  :)
>>>
>>>
>>>
>>> I made some changes a while back to fix the auth none problems with
>>> vstart
>>>
>>> (https://github.com/ceph/ceph/commit/0f7c516f3e1f37c5869f8fbff67f53ca0c90568c).
>>> The -x help text inversion was a bug on my part.
>>>
>>
>> By the way, I think those changes broke the use of CEPH_BIN env variable.
>
>
> I may not be using CEPH_BIN as intended then.  What is CEPH_BIN supposed to
> point to?
>
> I usually setup out-of-tree builds, and point CEPH_BIN at the src dir there:
>
> <in ceph dir>
> mkdir build
> cd build
> ../configure ...
> make
> CEPH_BIN=$PWD/src
> ../src/vstart.sh ...
>
CEPH_BIN should point at the built binaries. I usually set up out of
tree builds also, and point CEPH_BIN at the make install target, which
should also work. Maybe vstart.sh misuses it (e.g., looks at CEPH_BIN
for some other dependency).
