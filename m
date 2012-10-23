From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Tue, 23 Oct 2012 06:46:13 -0500
Message-ID: <50868385.7090708@inktank.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net> <508562A1.2040106@gmail.com> <50856F74.8020001@inktank.com> <CAC-hyiFkOKxef+iJ2NidNL4_yPwu5jxaxvjC+z82_rGJdJJbmw@mail.gmail.com> <50857206.1050702@inktank.com> <CAC-hyiHFiryTZYi_wC_BswcK49k_ek346o1qhu6NPZDTquPuQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57425 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab2JWLqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 07:46:17 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5086453iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 04:46:17 -0700 (PDT)
In-Reply-To: <CAC-hyiHFiryTZYi_wC_BswcK49k_ek346o1qhu6NPZDTquPuQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Joe Buck <jbbuck@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/22/2012 11:28 AM, Yehuda Sadeh wrote:
> On Mon, Oct 22, 2012 at 9:19 AM, Sam Lang <sam.lang@inktank.com> wrote:
>> On 10/22/2012 11:14 AM, Yehuda Sadeh wrote:
>>>
>>> On Mon, Oct 22, 2012 at 9:08 AM, Sam Lang <sam.lang@inktank.com> wrote:
>>>>
>>>> On 10/22/2012 10:13 AM, Joe Buck wrote:
>>>>>
>>>>>
>>>>> On 10/21/2012 02:35 PM, Sage Weil wrote:
>>>>
>>>>
>>>>
>>>>>> Also, we should fix the auth none usage at some point.  :)
>>>>
>>>>
>>>>
>>>> I made some changes a while back to fix the auth none problems with
>>>> vstart
>>>>
>>>> (https://github.com/ceph/ceph/commit/0f7c516f3e1f37c5869f8fbff67f53ca0c90568c).
>>>> The -x help text inversion was a bug on my part.
>>>>
>>>
>>> By the way, I think those changes broke the use of CEPH_BIN env variable.
>>
>>
>> I may not be using CEPH_BIN as intended then.  What is CEPH_BIN supposed to
>> point to?
>>
>> I usually setup out-of-tree builds, and point CEPH_BIN at the src dir there:
>>
>> <in ceph dir>
>> mkdir build
>> cd build
>> ../configure ...
>> make
>> CEPH_BIN=$PWD/src
>> ../src/vstart.sh ...
>>
> CEPH_BIN should point at the built binaries. I usually set up out of
> tree builds also, and point CEPH_BIN at the make install target, which
> should also work. Maybe vstart.sh misuses it (e.g., looks at CEPH_BIN
> for some other dependency).

It was previously doing ./init-ceph (which only worked if run from the 
ceph srcdir), and now does $CEPH_BIN/init-ceph, which breaks when you 
point CEPH_BIN at the make install target.

My goal with that change was to be able to run vstart.sh from outside 
the src dir (namely from the build dir).  To do that though, I think we 
would need to turn it into a autoconf generated file (vstart.sh.in -> 
vstart.sh).  That doesn't seem worth the trouble.  I'll put the 
./init-ceph back in.

-sam

>

