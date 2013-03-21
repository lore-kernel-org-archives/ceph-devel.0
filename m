From: Gregory Farnum <greg@inktank.com>
Subject: Re: github pull requests
Date: Thu, 21 Mar 2013 16:15:56 -0700
Message-ID: <CAPYLRzjyLmtFHLTny4Ni1FzhaAPqmmqTNt3ztDBL-oCMZZ7m0A@mail.gmail.com>
References: <alpine.DEB.2.00.1303191550140.4850@cobra.newdream.net>
	<CAMQoE_3+Os=F75LE+7dLVK2LYamNbEqwk0wpTe5+b0UZvYnQzg@mail.gmail.com>
	<52FEF7AC-2E35-413D-A0E6-A69B2FB2271D@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61026 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab3CUXP5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 19:15:57 -0400
Received: by mail-qa0-f51.google.com with SMTP id g10so2011160qah.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 16:15:56 -0700 (PDT)
In-Reply-To: <52FEF7AC-2E35-413D-A0E6-A69B2FB2271D@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Guilhem Lettron <guilhem@lettron.fr>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ross Turk <ross@inktank.com>

I'm not sure that we handle enough incoming yet that the extra process
weight of something like Gerrit or Launchpad is necessary over Github.
What are you looking for in that system which Github doesn't provide?
-Greg

On Thu, Mar 21, 2013 at 3:58 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
> can we have a review system like review.openstack.com?
>
> =B7=A2=D7=D4=CE=D2=B5=C4 iPhone
>
> =D4=DA 2013-3-20=A3=AC7:10=A3=AC"Guilhem Lettron" <guilhem@lettron.fr=
> =D0=B4=B5=C0=A3=BA
>
>> Glad to see this openness! Everyone isn't like you.
>> And I hope to see less [PATCH] in mailing-list, but maybe it's only =
a dream.
>>
>> Just my two cents.
>>
>> On Tue, Mar 19, 2013 at 11:54 PM, Sage Weil <sage@inktank.com> wrote=
:
>>>
>>> The only thing it doesn't do for you is zap the old branch.
>>
>> Github can do it: https://github.com/blog/1335-tidying-up-after-pull=
-requests
>> You can "delete this branch" when pull request is closed (and better=
 merged).
>>
>> You can also use this: https://github.com/blog/1377-create-and-delet=
e-branches
>>
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
