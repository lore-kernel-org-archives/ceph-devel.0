From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Single MDS cephx key
Date: Wed, 27 Sep 2017 16:36:20 +0000
Message-ID: <D5F11CB7.9B833%travis.nielsen@quantum.com>
References: <D5F02A0B.9B73A%travis.nielsen@quantum.com>
 <CALe9h7cNg-6fq8pQSOzW+SYn0StV0R-NQtt3s5QjxoAjHxY9fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:16736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751798AbdI0QgW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 27 Sep 2017 12:36:22 -0400
In-Reply-To: <CALe9h7cNg-6fq8pQSOzW+SYn0StV0R-NQtt3s5QjxoAjHxY9fg@mail.gmail.com>
Content-Language: en-US
Content-ID: <8F50E61F5A1300459DAA20538DA441A8@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

To expand on the scenario, I'm working in a Kubernetes environment where
the MDS instances are somewhat ephemeral. If an instance (pod) dies or the
machine is restarted, Kubernetes will start a new one in its place. To
handle the failed pod scenario, I'd appreciate if you could help me
understand MDS better.

1) MDS instances are stateless, correct? If so, I'm assuming when an MDS
instance dies, a new MDS instance (with a new ID) can be brought up and
assigned its rank without any side effects other than disruption during
the failover. Or is there a reason to treat them more like mons that need
to survive reboots and maintain state?

2) Will there be any side effects from MDS instances being somewhat
ephemeral? For example, if a new instance came up every hour or every day,
what challenges would I run into besides cleaning up the old cephx keys?

Thanks!
Travis




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

