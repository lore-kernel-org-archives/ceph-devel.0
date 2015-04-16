From: Gregory Farnum <greg@gregs42.com>
Subject: Re: partial acks when send reply to client to reduce write latency
Date: Thu, 16 Apr 2015 15:59:42 -0700
Message-ID: <CAC6JEv8X5k2RrKXYwXhZffWN183zn6aLS3-n_ZC06x9RTx98kQ@mail.gmail.com>
References: <CANE=7sWb_0o=NPR3O-yVjoGJyy_Oye0TFXt82FsTccH4R0BBcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:32843 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbDPW7o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 18:59:44 -0400
Received: by iecrt8 with SMTP id rt8so50697427iec.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 15:59:43 -0700 (PDT)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com. [209.85.223.173])
        by mx.google.com with ESMTPSA id o80sm5260276ioi.3.2015.04.16.15.59.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 15:59:43 -0700 (PDT)
Received: by iejt8 with SMTP id t8so63203721iej.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 15:59:42 -0700 (PDT)
In-Reply-To: <CANE=7sWb_0o=NPR3O-yVjoGJyy_Oye0TFXt82FsTccH4R0BBcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Apr 9, 2015 at 11:38 PM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@g=
mail.com> wrote:
> hi, all:
>
>     Now, ceph should received all ack message from remote and then
> reply ack to client, What
>
> about directly reply to client if primary has been received some of
> them. Below is the request
>
> trace among osd. Primary wait for second sub_op_commit_rec msg for a =
long time.
>
>     Does it make sense?

It makes sense on one level, but unfortunately it's just not feasible.
It would change how peering needs to work =E2=80=94 right now, we need =
to
contact at least one OSD that is active in any interval. If we allowed
commits to happen without having hit disk on every OSD, we need to
talk to all the OSDs in every interval (or at least, {num_OSDs} -
{number_we_require_ack} + 1 of them), which would be pretty bad for
our failure resiliency.

This comes up every so often as a suggestion and is a lot more
feasible with erasure coding =E2=80=94 Yahoo has already implemented th=
e
read-side version of this
(http://yahooeng.tumblr.com/post/116391291701/yahoo-cloud-object-store-=
object-storage-at),
but doing it on the write side would still take a lot of work.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
