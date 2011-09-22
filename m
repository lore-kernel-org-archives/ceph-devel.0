From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: radosgw should support cdmi?
Date: Thu, 22 Sep 2011 09:31:01 -0700
Message-ID: <CAORUGqBbzFVVKHts0XaK7WvegzJNvzaroGCDOxE5Ab8yakbUQw@mail.gmail.com>
References: <Pine.LNX.4.64.1109192033450.23670@cobra.newdream.net>
 <CAMwB3Ti3J8cdstYzpe_m7+wRfnctoTN=w+FY1w_jW4hiFH5KOw@mail.gmail.com> <Pine.LNX.4.64.1109220919320.17520@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45227 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1IVQbW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 12:31:22 -0400
Received: by ewy4 with SMTP id 4so97970ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 09:31:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109220919320.17520@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

2011/9/22 Sage Weil <sage@newdream.net>:
> The obvious answer is that yes, we should support it. =C2=A0The only =
reason I
> can see not doing so it because there is some uglyness in what SNIA e=
nded
> up with, or it is sufficiently divigergent from the S3 and Swift APIs=
 that
> it doesn't make sense to put it in the same proxy.

Yeah, and it also has a different data model. For example:

- each object is required to have a unique fixed-length key, in
addition to the object name
- containers are multi-level, not just flat buckets
- etc

There seem to be some open source CDMI servers out there:

Proxy CDMI to e.g. S3: https://github.com/livenson/vcdm
(it seems like one could run that in front of radosgw)

Serves a local filesystem as CDMI: https://github.com/koenbollen/cdmi-s=
erve

Compliance tests?: https://github.com/livenson/ocmi-tester

Erlang proof-of-concept: https://github.com/jeastman/crime
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
