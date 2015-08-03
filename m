From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next hammer release v0.94.3
Date: Mon, 3 Aug 2015 17:01:39 +0100
Message-ID: <CAC6JEv91iRpTZivmaFME9iaeuJPrwaCpbriXY2kTpucPWGnXTg@mail.gmail.com>
References: <55BF8C21.5020204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33766 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbHCQBk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 12:01:40 -0400
Received: by ioii16 with SMTP id i16so148973042ioi.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 09:01:40 -0700 (PDT)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com. [209.85.223.174])
        by smtp.gmail.com with ESMTPSA id y30sm10377739ioi.23.2015.08.03.09.01.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 09:01:39 -0700 (PDT)
Received: by iodd187 with SMTP id d187so148742742iod.2
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 09:01:39 -0700 (PDT)
In-Reply-To: <55BF8C21.5020204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

On Mon, Aug 3, 2015 at 6:43 PM Loic Dachary <loic@dachary.org> wrote:
>
> Hi Greg,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer passed the fs suite (http://tracker.ceph.com/issues/11990#fs). =
Do you think it is ready for QE to start their own round of testing ?

I'm on vacation right now, but the only thing I see there that might
be iffy is the backport of the file handle reference counting. As long
as that is all good (Zheng?) things look fine to me.
-Greg

>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/11990#Release-information has dir=
ect links to the pull requests merged into hammer since v0.94.2 in case=
 you need more context about one of them.
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
