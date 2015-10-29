From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Fix OP dequeuing order
Date: Thu, 29 Oct 2015 14:17:06 -0600
Message-ID: <CAANLjFrwcKVSea1Lz99a4KsZO89f7soOAEJPQAqj7a_wOk41Jw@mail.gmail.com>
References: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
	<alpine.DEB.2.00.1510282152110.1004@cobra.newdream.net>
	<CAANLjFoMBZHNrsVJNzj29Fvc=e87UtJCRFAmc7ie657C7mF60w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34098 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbbJ2URI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 16:17:08 -0400
Received: by vkgs66 with SMTP id s66so34609738vkg.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Oct 2015 13:17:06 -0700 (PDT)
In-Reply-To: <CAANLjFoMBZHNrsVJNzj29Fvc=e87UtJCRFAmc7ie657C7mF60w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Here is the pull request against master.

https://github.com/ceph/ceph/pull/6429
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Oct 28, 2015 at 11:44 PM, Robert LeBlanc  wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I've only tested on my dev cluster, but I'm not seeing the lone long
> blocked I/O. There is still blocked I/O, but it behaves a bit more
> like I expect. I'll try and get this fix out on our production cluster
> and see how it goes.
>
> I've tried implementing a Max-Min priority queue that had varied
> success, but I think there are multiple queues (one per thread or
> something) that made it challenging. I'm still trying to figure out
> how everything is getting queued and dequeued. There is one more queue
> idea I'd like to try that I think is less computationally stressful
> than the current three tier priority token bucket or the max-min I
> wrote up. I just wanted to get this fix in if it was the right
> direction.
>
> My max-min queue suffered from segfaults when OSDs were taken out, and
> I think it had to do with OPs not getting cleared out of the queue ( I
> removed all of the cutting in line and multiple queues and was relying
> on strict priority). Is there some documentation outlining the
> priority and the op that I can reference? ie. 128 - replication op, 64
> - primary op, etc...
>
> Do you want me to write up a patch against master as well?
>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWMbIpCRDmVDuy+mK58QAARSoQAIlqfkt8AOsmg4/Hkemg
> q6/u/AP0N3SIxk5j0OBM5MRe9jn14dW7ABpa6xnxunRXSUJC3MVQgl6jvJGn
> vtd68GDGu3dWWgmwMwgupr8B/OrQUmfMjmJxDGjerSEMAqzNluippVlCxM3R
> mFQjK9QNvO6/k3ceI1/SUcpjSwwp/fGWQizTQpKUcPFFJ4V/BXmv+rvzaNiU
> aJsWZvt6+ld9xdCWODP3MG8cBHl5dMaQvWdsmQ7bo66qgBdZImwUYqeCwKdm
> 6ODLmyrJJ3kTbhWKBvVQPzZFB8Ee89JfPKRq9LWsqNyZ5nqXVYle+XVC1KBF
> OPbqmqke6KJkjc4v+iCUgFarGZr4CxpJNqZqhvMg6LYnWF+m/E54DduxPzys
> N3LrR/K37Gp5NkUA7Qz/e/GoXf1kOSYvZUiAp2AHWkjeOT2Tx7LfEVScI6Ow
> 8V8iYDVlzTveH/6BxREpKgXoQ9EgZMdDWntLUBU+QV+FedlXRTEHD3zQKwlT
> Hix1lTuNxVY+VZSXos18FaFz+duVjUS/O2yuy1bmLWD6PfouFFCMfRwmK1rl
> QaaE1k6vinAzGbwq48D94hMPBcNQmJTWd8GC8kOGP+F9EFHyCPaHVK0Lu/T2
> jdnx9h/HcshOWh60CKu6N5w+JfvIcqyrLcDmiS3A9scgYOsdphLf1etxrKdq
> Xd8Z
> =evCv
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Wed, Oct 28, 2015 at 10:52 PM, Sage Weil  wrote:
>> On Wed, 28 Oct 2015, Robert LeBlanc wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> I created a pull request to fix an op dequeuing order problem. I'm not
>>> sure if I need to mention it here.
>>>
>>> https://github.com/ceph/ceph/pull/6417
>>
>> Wow, good catch.  Have you found that this materially impacts the behavior
>> in your cluster?
>>
>> sage
>>
>>
>>>
>>> - ----------------
>>> Robert LeBlanc
>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: Mailvelope v1.2.3
>>> Comment: https://www.mailvelope.com
>>>
>>> wsFcBAEBCAAQBQJWMVh6CRDmVDuy+mK58QAAztQP/385BOI8AH2uEJhN8pQ4
>>> QnAJxRy4HceWzjfAUulqNbbiD1scHZMU7LDW1GtsXfOZzmndTnJSBrR4+aHq
>>> F7py9zgXcxXH4uTAoILbRzkCF3rWdmkeh1/m5aY4LqmhE2N/O/LLOmDUe2BT
>>> XkQgZ9sROzY9pSj6pjA2vuv7k2u1SWtF3Ky14Hll3LHjqJibXoXYy+ik7lOP
>>> lRUoAY08Yf+c/Ag/Yy7CLGgIk/y6mdaJZPd2PCaVsKFa55NJAlYv0PHJKX0j
>>> XkSAY10MednMX6N+QL8XAq+yiAd//UADfCNhxHkP84YsPPCpNeS1OcoF6WGG
>>> g5H8uMK84kZCk37ummW/ANg9WNnO3hN2j22r9ezA+4GfxqKibT4lEMba6h88
>>> i5L3rQwWmM0cdpjS9plH1yUiPP2DexJV8PaiAIVVMAkw+AC0Xb/nUXKX6u5+
>>> YU744kSjtscN95Caf72V6HirB/uEU4sm+4lUuUBHzTcvau/r9WUHezwvmUiH
>>> HHL9bSU5TJ4jXvQhDEBYKbflTzLNKjXPcp1PagN2P9ZWQvNaxrQm32iB84DW
>>> 6jLEArFX10kE3eZ8IqoBikw5d+y3YtnuJ1oAIkfzj1ANofm37VKcQY/Wfrjw
>>> eke0nR4QBuN6SibbPXqIsjjIWZdo/jCgOCylNONXCFn9Qp08/7UJMQtzHk/1
>>> xRRp
>>> =g+NJ
>>> -----END PGP SIGNATURE-----
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWMn6/CRDmVDuy+mK58QAA/AoP/3k1psJiYWD3gsnDxK86
6RTLCvx4N1o74zabVnVXyfAASsD7q+S9r3K6vFgaMKUvf0EbbVqQsshTREJK
VhWxoy+w7uBAbPL+RCZwkUWPF+Gq974aChp2lo9ecllNcg1zFskZ5lxUHxQC
pIAsl7nCCIVHMew7Aedokb+x4WDJYf3appE2fthoizvhHjSzfGGA3ukxg1NG
EpoOH1bC47bIjVf8KaeT5kinGg7APj3fuozwjEnhR0VxOyam48KoP4Awb0Ru
NPabcwFiufkGC60z86g6o6uVCC1wCik4Yvj0xe48jePWn1m6cJBdGoQnA+wG
4RlZ2p/IQyijpYo3lzfRAq3mijZt37CDfhoRjHa5z9rAgt6H5bb+vWrgH1Jy
6bG0e97l9HhmAeAQV/yKXc1RrJLFSBowdbCsnGnITxYmWv6Y07U8wZyc6fSa
h8Jt56zORWZvRvUKBwqv4pt1Jc/MA2N2FCzWZ5C3QY5h5bqkjAhxEoCCQIFR
ZuO0M6Mm2dGczEeVOCAJCf5arYQySVVOi7h3uMIxtBqfSBfccPMetS0O3gaB
KZNe/V0OL9MMjsspFZs7F50iXgzdPefjoEWMBIWL8yWb9ak2aUkK2dAilFll
XZK59qc8SMI6idEqLPXSxrsUlvvJz2aXRmcX54O/kve2DCRW4xaetyTXcdCZ
pqqY
=uLf8
-----END PGP SIGNATURE-----
