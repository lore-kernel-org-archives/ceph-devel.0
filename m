From: Dan van der Ster <dan@vanderster.com>
Subject: Re: unit test for messaging crc32c
Date: Thu, 18 Jun 2015 11:15:19 +0200
Message-ID: <CABZ+qq=9GsrUtJDYSe8zcKOvMBtgN=oRtTy8KLCdrKHYgm7Hog@mail.gmail.com>
References: <CABZ+qqndvbGM-nK8FDsyaC=iEV_B6-WxR87ndOuJu6oZ=qXcXA@mail.gmail.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C1843F0@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35142 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFRJQC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 05:16:02 -0400
Received: by qgeu36 with SMTP id u36so23985970qge.2
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 02:16:01 -0700 (PDT)
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com. [209.85.192.46])
        by mx.google.com with ESMTPSA id k82sm3571208qkh.48.2015.06.18.02.16.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 02:16:00 -0700 (PDT)
Received: by qgeu36 with SMTP id u36so23985778qge.2
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 02:15:59 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4C1843F0@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 18, 2015 at 9:53 AM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
> Actually, all it takes is just to disable CRC in configuration on one=
 node (or even
> daemon). It'll cause to put zeros in CRC fields in all messages sent,=
 triggering
> CRC check failures cluster-wide (on remaining, unaffected nodes/daemo=
ns).

Thanks for the hint. I will try that!

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
