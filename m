From: Myna V <mynaramana@gmail.com>
Subject: Re: How to update ceph/jerasure.git
Date: Mon, 3 Apr 2017 22:28:22 +0530
Message-ID: <CAGvpcHYhLqPBGueFK4srh7LLKka4F6A_Nq39Hj5nsyWwYb-Eow@mail.gmail.com>
References: <CAGvpcHYQqUcBWC6cCQkXPczNCkUjoC8T3qsMi_LBzocnL3HVcA@mail.gmail.com>
 <5349a3af-3eed-e42b-11cc-d64e64037da6@dachary.org> <CAGvpcHY3+uAOyqweaA_F_TwAEq9uqdcEZQCTnNcXoVLhFDQ-rQ@mail.gmail.com>
 <8e6f622f-ce9b-83ed-9016-33435b84dbd1@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34020 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdDCQ7D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Apr 2017 12:59:03 -0400
Received: by mail-pg0-f52.google.com with SMTP id 21so126154669pgg.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Apr 2017 09:59:03 -0700 (PDT)
In-Reply-To: <8e6f622f-ce9b-83ed-9016-33435b84dbd1@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org, Birenjith Sasidharan <birenjith@gmail.com>, Elita Lobo <loboelita@gmail.com>, Bhagyashree Puranik <bhagya.puranik@gmail.com>, Ganesh Kini <kiniganesh94@gmail.com>, Vinayak Ramkumar <vinram93@gmail.com>

hi Loic,

I did not receive any email with confirmation instructions from jerasure.or=
g.

Thanks,
Myna

On Mon, Apr 3, 2017 at 10:20 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
>
> On 04/03/2017 06:42 PM, Myna V wrote:
>> Hi Loic,
>>
>> Thanks a lot for the reply. It somehow ended up in my spam. I tried
>> signing up on the jerasure upstream code page. But couldn't get any
>> response.
>
> Do you mean jerasure.org was down ?
>
> Cheers
>
>>
>> We are working on implementing coupled layer MSR code (issue 19278).
>> It is an MDS array code with optimal(minimal most) network, disk
>> traffic use during chunk repair.
>>
>> Please look at our pull request (
>> https://github.com/ceph/ceph/pull/14300 ) when you get a chance. We
>> introduced two new functions jerasure_matrix_decode_substripe,
>> jerasure_matrix_dotprod_substripe as private functions in
>> ErasureCodeJerasureCLMSR.
>>
>> Consider that an object is divided in to 4 parts(chunk 0, 1, 2, 3) and
>> encoded to get 2 parts (chunk 4,5). We introduce a notion of subchunk,
>> substripe, where in a chunk is divided in to 8 sub chunks below. Each
>> column in the below picture corresponds to a substripe and the 4 rows
>> together correspond to data coming from a stripe.
>>
>> |--|--|--|--|--|--|--|--| --> chunk 0 with 8 subchunks.
>> |--|--|--|--|--|--|--|--| --> chunk 1
>> |--|--|--|--|--|--|--|--| --> chunk 2
>> |--|--|--|--|--|--|--|--| --> chunk 3
>> |--|--|--|--|--|--|--|--| --> chunk 4
>> |--|--|--|--|--|--|--|--| --> chunk 5
>>
>> The new api's restrict the operations to a particular substripe. We
>> would like to know your comments on including these functions as part
>> of ErasureCodeJerasureCLMSR instead of them being included in
>> jerasure.h.
>>
>> Thanks,
>> Myna
>>
>>
>> On Mon, Mar 27, 2017 at 10:17 PM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Myna,
>>>
>>> On 03/27/2017 06:19 PM, Myna V wrote:
>>>> Hello All,
>>>>
>>>> How do I push changes to ceph/jerasure.git ? Is it the same as the
>>>> procedure needed for ceph/ceph.git ?
>>>
>>> The upstream for jerasure is at http://jerasure.org/groups/jerasure
>>>
>>> Cheers
>>>
>>>>
>>>> Thanks,
>>>> Myna.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
