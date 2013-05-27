From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Numerical argument out of domain
Date: Mon, 27 May 2013 20:59:38 +0100
Message-ID: <51A3BB2A.3050106@inktank.com>
References: <5EFBD28BA42C604BB012164C72CA56045030CBB3@SMBXKO5.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:54984 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948Ab3E0T7k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 15:59:40 -0400
Received: by mail-we0-f180.google.com with SMTP id t60so3726063wes.11
        for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 12:59:39 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA56045030CBB3@SMBXKO5.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?=22J=E4ger=2C_Philipp=22?= <Philipp.Jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/27/2013 08:31 PM, J=E4ger, Philipp wrote:
> Hello,
>
> i've set up a rados cluster, but the second of three mons will not st=
art:
>
> [19057]: (33) Numerical argument out of domain
> failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i d --pid-file /var/run/=
ceph/mon.d.pid -c /etc/ceph/ceph.conf '
>
>
> Added a 4. Mon, same problem.
> Tested with Ubuntu 12.04LTS and Debian 7.
> ceph version 0.61.2
>
> Also when I type in "usr/bin/ceph-mon -I d" only, I get the error mes=
sage and the mon service does not start.
>
> Do you know where the problem is?

Most likely, in ceph.conf.

   -Joao

--=20
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
