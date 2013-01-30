From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW S3 Api
Date: Wed, 30 Jan 2013 09:53:30 -0800
Message-ID: <CAC-hyiEFYF4xGx3nAWaOBDjrRTxLJ_P33A40NescWLBeCnATyQ@mail.gmail.com>
References: <5EFBD28BA42C604BB012164C72CA5604502B0E1D@SMBXKO6.cgm.ag>
	<5EFBD28BA42C604BB012164C72CA5604502B0E6B@SMBXKO6.cgm.ag>
	<CAC-hyiGdR8AMMFk41tWgjmYNAqffTd8R8UacdcaFEPErEr=+Rw@mail.gmail.com>
	<5EFBD28BA42C604BB012164C72CA5604502B0EDE@SMBXKO6.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:32870 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3A3Rxc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 12:53:32 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so1550087ieb.34
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 09:53:31 -0800 (PST)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA5604502B0EDE@SMBXKO6.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 30, 2013 at 9:34 AM, J=E4ger, Philipp <Philipp.Jaeger@cgm.c=
om> wrote:
> Hello, thanks for the answer.
> I don't know, the programmer say the api (s3 api java) wants to conne=
ct per https. When you know a possibility to  (de)actiate ssl, I would =
be happy you can tell:) than im sure its not a ssl problem.
>
>
> Do you know the error message "peer not authenticated"?
> I think its not a rados error message, because when you google for it=
, you can see that it's common ssl error in java.

Then it's probably ssl error. Radosgw doesn't generate such an error.

> But it can be an inherited error because of rados misconfiguration I =
think.
>
>
> How do I know if the gateway can be reached?
> Nothing special in the logs..
>
> Have you looked into the confs in the zip file I added to the mail?

Yeah. there's not much there.

> Im very unsure about the apache ssl configuration, when I set the fas=
tcgi virtual host section also to 443, I get an error message, but I do=
nk think its right to leave it on 80.


> Don't you ever set up radosgw with ssl ?

that's really orthogonal to radosgw, more of the web server (apache) is=
sue.

Try using some out of the box s3 client before using the api to help
with diagnosing the issue. It looks to me like some issues with your
apache configuration (ssl, fastcgi).


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
