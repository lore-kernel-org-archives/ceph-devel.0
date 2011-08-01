From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 09:42:43 -0700
Message-ID: <CAORUGqCD3a-1RD+GSB5SyzruL33tfZh5EN6p49b+q-iqFz2MKw@mail.gmail.com>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
 <Pine.LNX.4.64.1108010936430.6290@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43874 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1HAQnE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:43:04 -0400
Received: by vxh35 with SMTP id 35so4290309vxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 09:43:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108010936430.6290@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 1, 2011 at 09:40, Sage Weil <sage@newdream.net> wrote:
> Heh, you forgot the link again? =C2=A0:)

Yup, it's Monday.. https://github.com/akheron/jansson

> That's basically what JSONFormatter is doing, except it has some high=
er
> level methods for opening object vs array sections, and can add white=
space
> for human readability. =C2=A0The only thing we'd be using here is the=
 string
> quoting. =C2=A0It's probably easier to just lift that method than lin=
k in an
> external dependency for that. =C2=A0Or, fix any bugs in the current e=
scaping...

Oh most of the value I see in using a pre-existing JSON library is
exactly in the test coverage. Jansson has 2600 lines of C for tests
and 109 data-driven test cases..
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
