From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Some question about Ceph system (release 0.37)
Date: Wed, 26 Oct 2011 11:11:31 -0700
Message-ID: <CAORUGqCS0zE=OHO-fGF7HEEBk=7Mk_Y8T9a1KMqanZnek3qbhw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D56EFA7@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47248 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920Ab1JZSLx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 14:11:53 -0400
Received: by wyg36 with SMTP id 36so1957545wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 11:11:51 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D56EFA7@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 25, 2011 at 19:11,  <Eric_YH_Chen@wistron.com> wrote:
> Would you please give me some hint where is the problem? Maybe it is =
just configuration issue. Thanks!
>
> Message from "dmesg"
>
> [2304674.857044] libceph: mon0 172.16.33.5:6789 session established
> [2304677.935334] libceph: auth method 'x' error -1
=2E..
> And in mon.a.log
>
> 2011-10-26 09:48:11.297463 7f7cb8560700 -- 172.16.33.5:6789/0 >> 172.=
16.33.5:0/325292109 pipe(0x28e2c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept=
 peer addr is really 172.16.33.5:0/325292109 (socket is 172.16.33.5:399=
94/0)
> 2011-10-26 09:48:11.297952 7f7cb9d6a700 cephx server client.admin:=C2=
=A0 unexpected key: req.key=3D9366eb4b71c5f40d expected_key=3Ddc17c2ee9=
25c8134

Sounds like the client-side authentication keys are wrong. Perhaps you
reinstalled the Ceph server cluster, and are trying to use it from
another machine with the keys that belong to a previous installation?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
