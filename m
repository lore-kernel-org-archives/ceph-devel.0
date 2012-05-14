From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:49:51 -0700
Message-ID: <CAPYLRzgn_cwk6LfYgZbC5FvBbph9z6HGh_qyveHBr3CFOocs8w@mail.gmail.com>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
	<CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
	<FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
	<Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
	<6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754991Ab2ENRtw convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 May 2012 13:49:52 -0400
Received: by lahd3 with SMTP id d3so3522065lah.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 10:49:51 -0700 (PDT)
In-Reply-To: <6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On Mon, May 14, 2012 at 10:39 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
>
> On May 14, 2012, at 10:34 AM, Sage Weil wrote:
>
>> On Mon, 14 May 2012, Noah Watkins wrote:
>>> On May 14, 2012, at 10:03 AM, Tommi Virtanen wrote:
>>>> On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu=
> wrote:
>>>>> Return an error rather than a segfault if a client uses the inter=
face
>>>>> when unmounted. The Java bindings were explicitly enforcing the
>>>>> mounted state, but this was overly complicated, uncommon, and bet=
ter
>>>>> handled with a simple exception that can be checked at libcephfs =
level.
>>>> ...
>>>>> + =A0if (!cmount->is_mounted())
>>>>> + =A0 =A0return -EDOM;
>>>>
>>>> Noah, this is not really about your patch, as existing code alread=
y
>>>> has return -EDOM, but... oh boy does the API abuse POSIX errors.
>>>>
>>>> "Numerical argument out of domain".
>>>
>>> :) =A0Yeh, i stared at errno.h for a while. Note that -EDOM is alre=
ady
>>> returned by mount() when it is already mounted.
>>
>> Given the small number of libcephfs users, let's not be afraid to ch=
ange
>> it to something better.
>
> -ENOTCONN replace -EDOM for this patch
> -EISCONN =A0replace -EDOM for mount() when already mounted?

I haven't had the chance to go over everything thoroughly (I notice a
few other users of EDOM that I want to check out), but those
definitely sound better to me.
More better review comments later today.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
