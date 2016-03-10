From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: master build failure with boost 1.60
Date: Thu, 10 Mar 2016 10:10:42 +0100
Message-ID: <87oaam1ywd.fsf@suse.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de> <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com> <86io0wrn1s.fsf@linux-stsn.suse> <20160309105811.GB21590@pxe-sup5.sup.suse.de> <56E005C9.8020201@digiware.nl> <CAANLjFpY3rKOt4grHtNPrA7oa+L4SBsVyGxjSyQCQ0wrzs3gGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35297 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935170AbcCJJLw (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 10 Mar 2016 04:11:52 -0500
In-reply-to: <CAANLjFpY3rKOt4grHtNPrA7oa+L4SBsVyGxjSyQCQ0wrzs3gGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Karol Mroz <kmroz@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


Robert LeBlanc writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Willem,
>
> The goal is not to introduce features that are only available in
> 1.60.0, it is around fixing a problem that showed up with 1.60.0, but
> worked with previous versions. Apparently, they changed the way that
> Advanced Lookup and Inserts functioned which broke things.
>
> Karol and Abhishek,
>
> I've pushed an update to that pull request, can you try it again? It
> seems to pass on my hacked environment.

After applying latest commit from #7984, the build seems to be passing
now. Thanks for spending the time to fix this.

>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.6
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJW4H4UCRDmVDuy+mK58QAAqZkP/Ril3r+yltOJlFmEn/7g
> 9BG853bLMnS0zcm7r/YuqNcInSW9zJ979lLVekiNB4OfW3iEcZ022yFCgKUm
> 26NB6FeC0uYF8+ZvRzpgzWhAxEhLRmmjqcTleeUx2LEMAUAUm0mWFlHb7jj3
> RyG2CU+8e8iqn84QcVQ+p+UJ2ohxJoq97Y/xV4iAm+HIGOtiO0S9oUtUGx//
> 30sR+4eqLYMRZ4cFJr1VE9MCw/LepiGdmbcusBCrBdW0vlblesa0zlwx3IRy
> FR06KGfk/stvvoLJSLMLC3IYi7IYXQwWPVDosK4hrIGeF71GtcQPws2qLqAc
> D3VnRWqhpanAeNLzwvO7bXLK4d9xLtlu3AJxaQsv2Sv8zjdQ7xnpanTqbp/N
> qE6vDvdY7MgdY7wVD1ccYSBTRCZFIg/XJXwPUiy+udxUpKqAnuUqHcAQQdpL
> rOaOIcnpuvUOnasE8k2c0mjo7K3W4qEaYZJtpxvpJmDgz+UgE9I6f6tSAWLX
> U1KduXdzc2g9SDdL1qM/kY7P+E6sVejHY5TYjDn9jrn1IhV5OCI8zH7qDRjG
> BFDRJqFjZAmb7gGbQP/I4xZfmLvF2H2rfXiwl3ya/8X+UVnL4MnAgRLeikbc
> stDXz2lXHShIcMrXE1+tupmAjtVBmN7SP0eKa7+CCCMQvsFpj7ntWS5qdVBO
> 2wk1
> =AXup
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Wed, Mar 9, 2016 at 4:15 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 9-3-2016 11:58, Karol Mroz wrote:
>>>
>>> On Wed, Mar 09, 2016 at 10:57:35AM +0100, Abhishek L wrote:
>>>>
>>>>
>>>> Robert LeBlanc writes:
>>>>
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA256
>>>>>
>>>>> Karol,
>>>>>
>>>>> I think I may have already resolved this with a patch I was already
>>>>> working on. Can you pull in https://github.com/ceph/ceph/pull/7984 and
>>>>> see if it resolves the issue?
>>>>
>>>>
>>>> I tried applying 7984 atop of current master, it was still failing, on
>>>> similar errors with WeightedPriorityQueue, here is a log http://ix.io/pYl
>>>>
>>>
>>> Hi Robert,
>>>
>>> +1 here as well, with the same failure as seen in Abhishek's log above.
>>>
>>
>> Not to rain on anybody's parade but this is currently what FreeBSD offers
>> me in packages:
>> boost-all-1.55.0               The "meta-port" for boost libraries
>> boost-docs-1.55.0              Documentation for libraries from boost.org
>> boost-jam-1.55.0               Build tool from the boost.org
>> boost-libs-1.55.0_9            Free portable C++ libraries (without
>> Boost.Python)
>>
>> The CentOS7 I'm running has:
>> #define BOOST_LIB_VERSION "1_53"
>>
>> So I guess you will have to provide alternatives for code snippets that
>> depend
>> on 1.60 stuff?
>>
>> --WjW

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4ToUAAoJEPnwZB8bZe1fbKAH/2Y7hFkPIicGaJaGDqz2NK8v
EvA+1j/vT0ccNeUKW2iEur3KeUX7IFR83HW5ssSlcTQHFHtCKprp2hiiDVdeLan3
fTIsyIPbczuHo1wVclOvfDbuwI+gqG4SDaWa3KFE5yF2jeXOL5PNq2cqA7mm+OXv
Qa510DSEiAQZjc300K8YlAZniC5UWMvmUh2bjx95H6BP8R8bGqaLUofSR+Q0pBPj
y4y1xe0KB7LmlrP7V0aoADa3owTQ5T+Jn7yA+RaTKKmjRrPNGn5V/TGv866ou2q6
bBhsItzFIdfmyFy+4gm2VRGQFTGB5sERivOC6mTd+pLog4mZaRjQBPV3eM/HnpU=
=S+Na
-----END PGP SIGNATURE-----
