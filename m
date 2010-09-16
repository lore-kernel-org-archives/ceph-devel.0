From: Mag Gam <magawake@gmail.com>
Subject: Re: maintaining parity
Date: Thu, 16 Sep 2010 07:51:36 -0400
Message-ID: <AANLkTikZy=6f0CrZjt0QWCoQSx-0VfMxoorH7wcqp2UR@mail.gmail.com>
References: <AANLkTimX+4Mt7vDnNPWLZCUWpEH6q9vsumnc18HyGco3@mail.gmail.com>
	<4C920442.9090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38158 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0IPLvh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Sep 2010 07:51:37 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so349070gyd.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Sep 2010 04:51:36 -0700 (PDT)
In-Reply-To: <4C920442.9090303@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Exactly what I was thinking but space is a big issue when you are
dealing with hundreds of terabytes. I would hate to make a copy of the
data.


On Thu, Sep 16, 2010 at 7:49 AM, andy <nxilei@gmail.com> wrote:
> =C2=A0Use parity will very inefficient, although it can save a lot of=
 capcity!
> On 09/16/2010 07:00 PM, Mag Gam wrote:
>>
>> there are plans to maintain parity with various
>> servers instead of simply replicating the data. This is similar to
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
