From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Ceph Write Path Improvement
Date: Thu, 3 Sep 2015 11:38:40 -0600
Message-ID: <CAANLjFqUukYWwJk7QGhn56bDibigw74d7uv0CxHvf2UNG2zcEA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE354DD@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAANLjFpmO+rGnEFM5+u6piVoa4YqvoVCcTWjYOQJ2cXEEk7T-g@mail.gmail.com>
	<55E87862.5060809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35741 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbbICRpV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 13:45:21 -0400
Received: by vkaw128 with SMTP id w128so28750791vka.2
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 10:45:20 -0700 (PDT)
In-Reply-To: <55E87862.5060809@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Mark,

Thanks for the update. The performance meetings are at a bad time for
me and it usually takes a while for them to become available to review
later so I'm usually behind on the freshest news. I'm looking forward
to the results.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Sep 3, 2015 at 10:42 AM, Mark Nelson  wrote:
> On 09/03/2015 11:23 AM, Robert LeBlanc wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> Somnath,
>>
>> I'm having a hard time with your slide deck. Am I understanding
>> correctly that the default Hammer install was performed on SSDs with
>> co-located journals, but the optimized code was performed on the same
>> SSDs but the journal was in NVRAM? If so I'm having a hard time
>> understanding how these tests can be comparable. I really like the
>> performance gains you are seeing, but I'm trying to understand how
>> much the optimized code alone helps performance.
>
>
> Hi Robert,
>
> We talked about this a bit at the weekly performance meeting.  I think
> Somnath just hasn't gotten a chance to do those tests yet and is planning on
> doing them in the coming weeks.  I believe he started out with hammer on the
> SSDs and then tried to figure out how to tweak things to make the NVRAM
> configuration perform better.  Now he has to go back and retest the original
> configuration but with the new code.
>
> Mark

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV6IWbCRDmVDuy+mK58QAAC4MP/RmUaee7sDJcUvMDDySc
BexzhwpCQ6Ur/MUrjdWvf2YhPr4d0+gSrFDFpU8bwG056nz8F0QIRufmGY9p
b76xhcnTLvwIbIlInAfBXVWYp7uheAz+4znEuVYbmYiCau3FlWe4jnd+ohCg
hOuAy/fkcnjXcjv6TToFUr1KIe07xNZkvt4ALWcSeafTwvl3JgddUvpKgBYq
KdM2g4RL7KvYDIAmgf4/KKBtX2bcbLXkL48Tc6Ev4NJCcAZk5VlX3eBvQYgY
ZWnlRHDNeBlDRvwHzS5aaWdar19qXpSkMjqW4u5YiT+kL0k0jbcTVpu2W+qC
1dOGwMInFnAzT+vgrw8tFy8XEcZ2PWoNmY1wiYTLp+mgvDDeSoqmldmF7R9N
lM1woA/NRhpYY9RqHUC8JkUdcW5mZ3yjCMP7fj/5HxPZAe8QAsZrwg91xqew
5WrCnh0kLUGQltE/jSpqBnn1tLGpGkoE5Uowy5nODEWWQbOz9rECOiMdOrAY
3lZXz9QzetYPAa+kAJLQ6AG5fDmq0sIvc30kyVBkOa83aQPrdsSXpwGj1B7W
V1iRCb132zzzGFGGlQZZDKkErBKz5Txwki66ExKpiNI7lJ0YYIw1+hMrdLoy
SrgYIdZB/7jOnAaDkK68MTrvQKmDUtxLKkBqd8zFhpqMNAj7vlShWfic7fxl
Pj/3
=zJ9M
-----END PGP SIGNATURE-----
