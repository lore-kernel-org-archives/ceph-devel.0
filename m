From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] radosgw - complete_multipart errors
Date: Thu, 31 Oct 2013 07:49:47 -0700
Message-ID: <CAPYLRzhaXUfjvU44S2Uf-ug5QY25vb_YmpvDQZ8QmFcJKv4uuQ@mail.gmail.com>
References: <CAMNMNTx6TCaxUng6wFYHm_TECQzK9+y_G0dTimDauoci_ucu9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64014 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab3JaOtt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 10:49:49 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey11so8464163wid.6
        for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 07:49:48 -0700 (PDT)
In-Reply-To: <CAMNMNTx6TCaxUng6wFYHm_TECQzK9+y_G0dTimDauoci_ucu9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dominik Mostowiec <dominikmostowiec@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Thu, Oct 31, 2013 at 6:22 AM, Dominik Mostowiec
<dominikmostowiec@gmail.com> wrote:
> Hi,
> I have strange radosgw error:
>
> =3D=3D=3D=3D=3D=3D
> 2013-10-26 21:18:29.844676 7f637beaf700  0 setting object
> tag=3D_ZPeVs7d6W8GjU8qKr4dsilbGeo6NOgw
> 2013-10-26 21:18:30.049588 7f637beaf700  0 WARNING: set_req_state_err
> err_no=3D125 resorting to 500
> 2013-10-26 21:18:30.049738 7f637beaf700  2 req 61655:0.224186:s3:POST
> /testbucket/files/image%20%286%29.jpeg:complete_multipart:http
> status=3D500
> 2013-10-26 21:18:30.049975 7f637beaf700  1 =3D=3D=3D=3D=3D=3D req don=
e
> req=3D0x11013d0 http_status=3D500 =3D=3D=3D=3D=3D=3D
>
> It's similar to: http://tracker.ceph.com/issues/5439
> This is the same bug?
> My ceph version:
> ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
>
> Bug (5439) is fixed.
> How to check (if I know commit
> "72d4351ea5a470051e428ffc5531acfc7d1c7b6f" ) which CEPH version have
> this fix.
> In latest bobtail - 0.56.7 it is fixed?

That particular commit is in dumpling and all subsequent dev releases.
(I checked by using "git tag --contains" in my git checkout.) It's not
in Bobtail, but I'm not sure when the behavior changed to become
incorrect (or whether Bobtail is susceptible to that particular bug).
I'd upgrade if I were you and test it out =97 behavior in a variety of
component failure conditions is much better under later versions than
it is under Bobtail!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
