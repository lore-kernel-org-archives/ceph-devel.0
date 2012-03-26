From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to read CRUSH source code efficiently?
Date: Mon, 26 Mar 2012 11:13:01 -0700
Message-ID: <CAORUGqDMpe-rpaejvGDJxV5R2gB8kpzr+Y2Cud5-64CdGYyrKg@mail.gmail.com>
References: <CALwGbP+9N8Ygzbqn9QxPENwcm4_ZeU0BGCYzE_kJvH3GrEX=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37541 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627Ab2CZSNW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 14:13:22 -0400
Received: by pbcun15 with SMTP id un15so6257693pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 11:13:21 -0700 (PDT)
In-Reply-To: <CALwGbP+9N8Ygzbqn9QxPENwcm4_ZeU0BGCYzE_kJvH3GrEX=EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Mar 24, 2012 at 00:35, =E8=83=A1=E7=80=9A=E6=A3=AE <softrank.ne=
t@gmail.com> wrote:
> After reading the thesis about CRUSH, I proceed to read the related
> source code in order to understand it more deeply and thoroughly.
>
> But it's seems not to be efficient to read the source code files in
> src/crush one by one.
>
> I'd like to know where should I start? I think the pseudo code
> "Algorithm 1" described in the thesis is quite important, but where
> can I find the implementation of this algorithm?

crush_do_rule chooses an array of decision based on a rule. It's not
structured quite the same way as procedure SELECT, but you should see
parallels.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
