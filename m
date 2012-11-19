From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Many dns domain names in radosgw
Date: Mon, 19 Nov 2012 10:02:05 -0800
Message-ID: <CAC-hyiGS9EvpZPJiueN7rP3GeAWj5r2cifUAE67N=ED8WAe6sg@mail.gmail.com>
References: <4911628473775241471@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39153 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2KSSCH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 13:02:07 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1200220lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 10:02:05 -0800 (PST)
In-Reply-To: <4911628473775241471@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Nov 17, 2012 at 1:50 PM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> Welcome,
>
> I have a question. Is there, any way to support multiple domains name=
s
> in one radosgw on virtual host type connection in S3 ??
>
Are you aiming at having multiple virtual domain names pointing at the
same bucket?

Currently a gateway can only be set up with a single domain, so the
virtual bucket scheme will only translate subdomains of that domain as
buckets. Starting at 0.55 there will be a way to point alternative
domains to a specific bucket (by modifying their dns CNAME record),
however, It doesn't sound like it's what you're looking for.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
