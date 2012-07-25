From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph Benchmark HowTo
Date: Wed, 25 Jul 2012 13:35:20 -0700
Message-ID: <CADvuQRGzddGRfkN_jY4-aoAKVtfcW10Yf3c4Bj+j-RD4RMm7DQ@mail.gmail.com>
References: <20120724144300.GA3317@mail.sileht.net> <CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
 <CAPYLRzjkEisL6GqXQDMJUnYbiObRBSw-jELXr7u2Je=zFk4hqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34121 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab2GYUfl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 16:35:41 -0400
Received: by vbbff1 with SMTP id ff1so980341vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 13:35:40 -0700 (PDT)
In-Reply-To: <CAPYLRzjkEisL6GqXQDMJUnYbiObRBSw-jELXr7u2Je=zFk4hqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, Mehdi Abaakouk <sileht@sileht.net>, ceph-devel@vger.kernel.org

On Wed, Jul 25, 2012 at 1:25 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> Yeah, an average isn't necessarily very useful here =E2=80=94 it's wh=
at you
> get because that's easy to implement (with a sum and a counter
> variable, instead of binning). The inclusion of max and min latencies
> is an attempt to cheaply compensate for that...but if somebody wants
> to find/write an appropriately-licensed statistical counting library
> and integrate it with rados bench, then (say it with me) contribution=
s
> are welcome! ;)

How about "output results in a good machine-readable format and here's
the pandas script to crunch it to a useful summary".

http://pandas.pydata.org/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
