From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: coding style document
Date: Thu, 14 Jul 2011 13:37:28 -0700
Message-ID: <CAF3hT9DysGui-hh22unPU+Z9n1bVx87XHovX3sSfCtyLNNHSsw@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
	<CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
	<CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
	<CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
	<CA+qbEUM7HPo9DdjyS_7Dnmq74u_gKVCJjXEf8G=_VVfiX_sJ-Q@mail.gmail.com>
	<CAC-hyiFxqSEVm5r54hitYWNaHr3DMZ1jyC4FdnCPVDqgFWdULQ@mail.gmail.com>
	<Pine.LNX.4.64.1107131518300.11118@cobra.newdream.net>
	<CAF3hT9CPjOoup+UsWq4MsvxCD4zZPSL1Wu1wWnL1u=G=fJ3e9w@mail.gmail.com>
	<Pine.LNX.4.64.1107141056250.29636@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34385 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1GNUh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 16:37:29 -0400
Received: by yxi11 with SMTP id 11so276249yxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 13:37:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107141056250.29636@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Colin Patrick McCabe <colin.mccabe@dreamhost.com>, ceph-devel@vger.kernel.org

I've been going over the Google Coding Style document and noticed a
few other things that probably merit discussion/a diff:
1) It says not to use streams, except for logging. We don't do a lot
of text output other than logging, but in the few places we do it
(program help text, for instance) I believe we use stream.s
2) Under the "Integer Types" section, they prefer not to use unsigned
types except for bit patterns. They explicitly state that values which
are not allowed to be <0 should be checked with asserts, rather than
guaranteed by the type. This isn't the case for any of our current
code and I'm not sure it's worth changing.

Also, I encourage everybody to note the guidelines on commenting. :)
-Greg
