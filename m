From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Single MDS cephx key
Date: Wed, 27 Sep 2017 14:49:25 +0000
Message-ID: <D5F1084A.9B7BC%travis.nielsen@quantum.com>
References: <D5F02A0B.9B73A%travis.nielsen@quantum.com>
 <CALe9h7cNg-6fq8pQSOzW+SYn0StV0R-NQtt3s5QjxoAjHxY9fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:29872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751808AbdI0Ot2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 27 Sep 2017 10:49:28 -0400
In-Reply-To: <CALe9h7cNg-6fq8pQSOzW+SYn0StV0R-NQtt3s5QjxoAjHxY9fg@mail.gmail.com>
Content-Language: en-US
Content-ID: <D1C9D51FA18B6C4DB8E3372D68766D68@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Ok that makes sense to maintain the control over the teardown, thanks for
the perspective.




On 9/27/17, 3:01 AM, "John Spray" <jspray@redhat.com> wrote:

>On Wed, Sep 27, 2017 at 12:09 AM, Travis Nielsen
><Travis.Nielsen@quantum.com> wrote:
>> Is it possible to use the same cephx key for all instances of MDS or do
>> they each require their own? Mons require the same keyring so I tried
>> following the same pattern by creating a keyring with "mds.", but the
>>MDS
>> is complaining about not being authorized when it tries to start. Am I
>> missing something or is this not possible for MDS keys? If I create a
>> unique key for each MDS instance it works fine, but it would simplify my
>> scenario if I could use the same key. I'm running on Luminous.
>
>I've never heard of anyone trying to do this.
>
>It's probably not a great idea, because if all MDS daemons are using
>the same key then you lose the ability to simply remove an MDS's key
>to ensure that it can't talk to the system any more.  This is useful
>when tearing something down, because it means you're not taking it on
>faith that the daemon is really physically stopped.
>
>John
>
>> The key was generated with this:
>> ceph auth get-or-create-key mds. osd allow * mds allow mon allow profile
>> mds
>>
>>
>>
>> The keyring contents are:
>> [mds.]
>> key =3D AQD62spZw3zRGhAAkHHVokP3BDf8PEy4+vXGMg=3D=3D
>>
>>
>> I run the following with that keyring:
>> ceph-mds --foreground --name=3Dmds.mymds -i mymds
>>
>> And I see the error:
>> 2017-09-26 22:55:55.973047 7fb004459200 -1 mds.mds81c2n ERROR: failed to
>> authenticate: (22) Invalid argument
>>
>>
>>
>> Thanks,
>> Travis
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at
>>https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.ke=
rn
>>el.org%2Fmajordomo-info.html&data=3D02%7C01%7CTravis.Nielsen%40quantum.co=
m%
>>7C00d1db42478d48fa8c6508d5058ec254%7C322a135f14fb4d72aede122272134ae0%7C1
>>%7C0%7C636421033061815149&sdata=3D3Vu79xeZbnb1jwhGE85PACq6qByVE6vUlPjp8pj=
rv
>>hA%3D&reserved=3D0

