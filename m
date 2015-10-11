From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MDS stuck in a crash loop
Date: Sun, 11 Oct 2015 10:16:37 -0700
Message-ID: <CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33923 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbJKRQi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 13:16:38 -0400
Received: by wicgb1 with SMTP id gb1so25529659wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 10:16:37 -0700 (PDT)
In-Reply-To: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Oct 11, 2015 at 10:09 AM, Milosz Tanski <milosz@adfin.com> wrot=
e:
> About an hour ago my MDSs (primary and follower) started ping-pong
> crashing with this message. I've spent about 30 minutes looking into
> it but nothing yet.
>
> This is from a 0.94.3 MDS
>

>      0> 2015-10-11 17:01:23.596008 7fd4f52ad700 -1 mds/SessionMap.cc:
> In function 'virtual void C_IO_SM_Save::finish(int)' thread
> 7fd4f52ad700 time 2015-10-11 17:01:23.594089
> mds/SessionMap.cc: 120: FAILED assert(r =3D=3D 0)

These "r =3D=3D 0" asserts pretty much always mean that the MDS did did=
 a
read or write to RADOS (the OSDs) and got an error of some kind back.
(Or in the case of the OSDs, access to the local filesystem returned
an error, etc.) I don't think these writes include any safety checks
which would let the MDS break it which means that probably the OSD is
actually returning an error =E2=80=94 odd, but not impossible.

Notice that the assert happened in thread 7fd4f52ad700, and look for
the stuff in that thread. You should be able to find an OSD op reply
(on the SessionMap object) coming in and reporting an error code.
-Greg

>
>  ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0x94cc1b]
>  2: /usr/bin/ceph-mds() [0x7c7df1]
>  3: (MDSIOContextBase::complete(int)+0x81) [0x7c83b1]
>  4: (Finisher::finisher_thread_entry()+0x1a0) [0x87f490]
>  5: (()+0x8182) [0x7fd4fd031182]
>  6: (clone()+0x6d) [0x7fd4fb7a047d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
