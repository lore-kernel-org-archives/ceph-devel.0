From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Sat, 05 Apr 2014 08:08:45 -0500
Message-ID: <5340005D.5080401@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <1396660579.2130.103.camel@localhost> <533F62EE.2060701@ieee.org> <1396685353.2130.106.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36419 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaDENIN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Apr 2014 09:08:13 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so4503933iec.39
        for <ceph-devel@vger.kernel.org>; Sat, 05 Apr 2014 06:08:13 -0700 (PDT)
In-Reply-To: <1396685353.2130.106.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: ceph-devel@vger.kernel.org

On 04/05/2014 03:09 AM, Olivier Bonvalet wrote:
> Le vendredi 04 avril 2014 =C3=A0 20:57 -0500, Alex Elder a =C3=A9crit=
 :
>> On 04/04/2014 08:16 PM, Olivier Bonvalet wrote:
>>> Le mardi 25 mars 2014 =C3=A0 09:39 +0100, Olivier Bonvalet a =C3=A9=
crit :
>>>> Hi,
>>>>
>>>> what can/should I do to help fix that problem ?
>>>>
>>>> for now, RBD kernel client hang on :=20
>>>>         Assertion failure in rbd_img_obj_callback() at line 2131:
>>>>            rbd_assert(which >=3D img_request->next_completion);
>>>>
>>>> or on :
>>>>         Assertion failure in rbd_img_obj_callback() at line 2127:
>>>>             rbd_assert(img_request !=3D NULL);
>>>>
>>>>
>>>> I have both case at least once per week, on latest 3.13.5 kernels.
>>>>
>>>> It seems that the problem occurs only on more loaded servers (I ha=
ve 4
>>>> near same servers, and crash occurs on two of them. If I move the =
VM,
>>>> crash follows...).
>>>>
>>>> Olivier
>>>>
>>>> --
>>>
>>> Hi,
>>>
>>> so. After some days without any problems, RBD crashed toonight :
>>
>> Unfortunately this could be a symptom of the same sort of race.
>> When a object request is removed from its image request's list
>> the request count gets decremented.  To be honest, all of these
>> assertions in rbd_img_obj_callback() are probably unsafe, at
>> least until I get the patch that does proper reference counting
>> implemented:
>>
>>         rbd_assert(img_request !=3D NULL);
>>         rbd_assert(img_request->obj_request_count > 0);
>>         rbd_assert(which !=3D BAD_WHICH);
>>         rbd_assert(which < img_request->obj_request_count);
>>
>> Until then I think you can avoid this by commenting out those
>> assertions.  I'm afraid there will remain a (smaller) window
>> of opportunity for a problem to occur, but I believe commenting
>> those out will help for now.
>>
>> I'm very sorry you're hitting these.  I'll see if I can get
>> a comprehensive fix this weekend.
>>
>> 					-Alex
>=20
> Thanks for your help, really.
>=20
> By removing those asserts, can I throw any data corruption ?

Data corruption is no more likely with the asserts removed.

They should not fail, and in general they do not, so things
are working properly.  Because of this race condition we are
seeing them fail, on rare occasions.  I understand why this
is happening though, and when it does, this test should avoid
doing any invalid processing of the request:
        if (which !=3D img_request->next_completion)
                goto out;

					-Alex

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
