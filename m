From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Ceph Write Path Improvement
Date: Thu, 3 Sep 2015 10:23:11 -0600
Message-ID: <CAANLjFpmO+rGnEFM5+u6piVoa4YqvoVCcTWjYOQJ2cXEEk7T-g@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE354DD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33022 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbbICQXL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 12:23:11 -0400
Received: by vkbf67 with SMTP id f67so27473520vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 09:23:11 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE354DD@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Somnath,

I'm having a hard time with your slide deck. Am I understanding
correctly that the default Hammer install was performed on SSDs with
co-located journals, but the optimized code was performed on the same
SSDs but the journal was in NVRAM? If so I'm having a hard time
understanding how these tests can be comparable. I really like the
performance gains you are seeing, but I'm trying to understand how
much the optimized code alone helps performance.

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV6HPoCRDmVDuy+mK58QAAJXQQAKz4ncncNQOFxRhKaAS4
gifdxT8PvzielfQ+f3mcgMpzDW2wdrThAe+ZOVP2wztv+6HvpJ0e2Vh/0y8r
zCp1wSZS52F2OeWNMXqzde2prBotpQqZGrZwd6q/TTBpT9Mg/qf6wEQvUqBb
w8k5IfeEQpvg4jxDiw4MzpETMIfnSPyyhoULV/vc9MxaXYgoch04xo6uD+VC
hZDuOs+JPT971X0U+67iyidGIv0pjz5tED93D2eyLe/PedZhh34+5A/b/KZ8
SFCEhmL0/5FXjKdOZk4glYKyVlWYNy1IXTUCbQ9+F1v1YAHtOLMw+IWMljXw
mAGudzt8sGGzX9XF0n7UMPpNJb5LKCutDNq3Jinkin5lFe32HILi9T2s8DQL
aagAyJFP9RVdnDlnPAanq7p3F5MBc8TcyKLISRp0cNJVRGnVjv6RJbo6RaZ6
lWeLhPkXCVJXbIo9BJ67QdgZUDz1FZxNkARL4cDGI7oZwzD5e99LJcKoz6yZ
d/0BcgJyzQPTfeOft7AwFTrP1at1mwK/aFK+jClEPU3GdDSrMluFCOH4Qu+F
pvIy0PxdGlGDS4P4Xs+NiWIeCu12NjtO8dRg++BO0rPbladBlsF3ZD+G7R/q
pG/QTKhf41s+pbDal+HJoNKiK7+WZgHhy8IBXdR4a8SQeMHRa/MYJk6MFLKr
vK/6
=wcJB
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Sep 2, 2015 at 5:06 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi,
> Here is the link of the document I presented in today's performance meeting.
> https://docs.google.com/presentation/d/1lCoLpFRjD8t_YCeHyWDV7ddv7ZkwfETgyjUzXw0-ttU/edit?usp=sharing
>
> It has the benchmark result of the filestore changes I proposed earlier for the ceph write path optimization.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
