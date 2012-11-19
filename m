From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Many dns domain names in radosgw
Date: Mon, 19 Nov 2012 20:18:19 +0100
Message-ID: <CAMwB3Tigoq0048fVWRB9orKxZT3_2fJf2fNNxBG9aWBAJcDC-A@mail.gmail.com>
References: <4911628473775241471@unknownmsgid>
	<CAC-hyiGS9EvpZPJiueN7rP3GeAWj5r2cifUAE67N=ED8WAe6sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44292 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab2KSTSU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 14:18:20 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so220857qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 11:18:19 -0800 (PST)
In-Reply-To: <CAC-hyiGS9EvpZPJiueN7rP3GeAWj5r2cifUAE67N=ED8WAe6sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes. I am looking for using domain x.com, and y.com with virtual host
buckets like b.x.com, c.y.com

But if it's not possible i can handle this with cname *.x.com and use
only b and c on x.com domain.

Thanks for response.

19 lis 2012 19:02, "Yehuda Sadeh" <yehuda@inktank.com> napisa=C5=82(a):
>
> On Sat, Nov 17, 2012 at 1:50 PM, S=C5=82awomir Skowron <szibis@gmail.=
com> wrote:
> > Welcome,
> >
> > I have a question. Is there, any way to support multiple domains na=
mes
> > in one radosgw on virtual host type connection in S3 ??
> >
> Are you aiming at having multiple virtual domain names pointing at th=
e
> same bucket?
>
> Currently a gateway can only be set up with a single domain, so the
> virtual bucket scheme will only translate subdomains of that domain a=
s
> buckets. Starting at 0.55 there will be a way to point alternative
> domains to a specific bucket (by modifying their dns CNAME record),
> however, It doesn't sound like it's what you're looking for.
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
