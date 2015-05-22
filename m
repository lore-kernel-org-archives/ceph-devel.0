From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next firefly release v0.80.10
Date: Fri, 22 May 2015 14:35:10 -0700
Message-ID: <CAC6JEv-Od8BSFwwbuyLvfbhRjM=tsBUV5ePZgcuGG1qhZ=3wwQ@mail.gmail.com>
References: <555F8BBD.90606@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36872 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824AbbEVVfM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 17:35:12 -0400
Received: by igbsb11 with SMTP id sb11so446553igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 14:35:11 -0700 (PDT)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id j4sm25146igm.21.2015.05.22.14.35.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 14:35:11 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so1500697igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 14:35:11 -0700 (PDT)
In-Reply-To: <555F8BBD.90606@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

Yep, looks good.
-Greg

On Fri, May 22, 2015 at 1:04 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next firefly release as found at https://github.com/ceph/ceph/tre=
e/firefly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the fs suit=
e (http://tracker.ceph.com/issues/11090#fs). Do you think it is ready f=
or QE to start their own round of testing ?
>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/11090#Release-information has dir=
ect links to the pull requests merged into firefly since v0.80.9 in cas=
e you need more context about one of them.
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
