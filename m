From: Mike Almateia <mike.almateia@gmail.com>
Subject: Re: Question about big EC pool.
Date: Sat, 12 Sep 2015 22:12:58 +0300
Message-ID: <55F4793A.8040802@gmail.com>
References: <55F44C3D.4070603@gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE44457@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33845 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbILTNG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Sep 2015 15:13:06 -0400
Received: by lahg1 with SMTP id g1so35412091lah.1
        for <ceph-devel@vger.kernel.org>; Sat, 12 Sep 2015 12:13:03 -0700 (PDT)
Received: from [192.168.10.33] ([37.204.142.248])
        by smtp.gmail.com with ESMTPSA id b1sm1000849lah.11.2015.09.12.12.13.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 12:13:02 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE44457@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

12-Sep-15 19:34, Somnath Roy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> I don't think there is any limit from Ceph side..
> We are testing with ~768 TB deployment with 4:2 EC on Flash and it is=
 working well so far..
>
> Thanks & Regards
> Somnath

Thanks for answer!

It's very interesting!

What is hardware you use for your the test cluster?
You use only SSD or SSD+NVE?
Journal is located on the same SSD or not?
What a plugin you use?
You catch some bugs or strange things?

Sorry for so many questions, but it's very interesting!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
