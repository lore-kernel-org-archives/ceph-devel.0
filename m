From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds cache size configuration option being ignored
Date: Wed, 3 Oct 2012 16:15:44 -0700
Message-ID: <CAPYLRzjhdsEqqfOV=pP2rZnegZRsjfaFr4LGFJooDkXqrA71Aw@mail.gmail.com>
References: <CANLRBox7q8eJkJ8rKoyqrjdPLq7kjjqiMJx9MAdaSgCTtcmnog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55674 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583Ab2JCXPo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 19:15:44 -0400
Received: by ieak13 with SMTP id k13so18544539iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 16:15:44 -0700 (PDT)
In-Reply-To: <CANLRBox7q8eJkJ8rKoyqrjdPLq7kjjqiMJx9MAdaSgCTtcmnog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 3, 2012 at 3:22 PM, Tren Blackburn <tren@eotnetworks.com> w=
rote:
> Hi List;
>
> I was advised to use the "mds cache size" option to limit the memory
> that the mds process will take. I have it set to "32768". However it
> the ceph-mds process is now at 50GB and still growing.
>
> fern ceph # ps wwaux | grep ceph-mds
> root       895  4.3 26.6 53269304 52725820 ?   Ssl  Sep28 312:29
> /usr/bin/ceph-mds -i fern --pid-file /var/run/ceph/mds.fern.pid -c
> /etc/ceph/ceph.conf
>
> Have I specified the limit incorrectly? How far will it go?

Oof. That looks correct; it sounds like we have a leak or some other
kind of bug. I believe you're on Gentoo; did you build with tcmalloc?
If so, can you run "ceph -w" in one window and then "ceph mds tell 0
heap stats" and send back the output?
If you didn't build with tcmalloc, can you do so and try again? We
have noticed fragmentation issues with the default memory allocator,
which is why we switched (though I can't imagine it'd balloon that far
=97=A0but tcmalloc will give us some better options to diagnose it). So=
rry
I didn't mention this before!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
