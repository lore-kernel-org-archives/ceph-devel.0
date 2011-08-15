From: Damien Churchill <damoxc@gmail.com>
Subject: Re: rbd copy progress
Date: Mon, 15 Aug 2011 10:12:14 +0100
Message-ID: <CAFtEh-eFXgoK6uJ__MVNbd3MmtxfsEHRZiVcjHTwurQeaqCoBA@mail.gmail.com>
References: <CAFtEh-dpiebifi31NXNoGYpzawvWNR0T5qc8DO-XLivXbw8HCQ@mail.gmail.com>
	<4E455FDE.8080207@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35747 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab1HOJMO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2011 05:12:14 -0400
Received: by yxj19 with SMTP id 19so3020503yxj.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2011 02:12:14 -0700 (PDT)
In-Reply-To: <4E455FDE.8080207@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 12 August 2011 18:16, Josh Durgin <josh.durgin@dreamhost.com> wrote:
> On 08/12/2011 07:59 AM, Damien Churchill wrote:
>>
>> Hi,
>>
>> I was wondering if it's possible to get copy progress statistics som=
e
>> how when doing a rbd copy<image> =C2=A0<dest>? I could check the dis=
k usage
>> for Ceph but that seems rather unclean and also prone to errors,
>> especially if there are multiple copies going on at once.
>
> Good point! It was an oversight. Added in
> 361997af37620d80a95a969addd60f734748ac37.
>

=46antastic, thanks :-)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
