From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: deprecating mkcephfs (the arrival of light-weight deployment tools)
Date: Mon, 19 Nov 2012 14:13:40 -0800 (PST)
Message-ID: <1353363220.47659.YahooMailNeo@web121906.mail.ne1.yahoo.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com> <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm23-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.211]:47832 "EHLO
	nm23-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab2KSWTr convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Nov 2012 17:19:47 -0500
In-Reply-To: <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I am trying to understand ceph deployment direction because from this l=
ink http://ceph.com/docs/master/rados/deployment/
it
 is mentioned that mkcephfs is dreprecated. It also has the statement=20
below which mentions light-weight deployment scripts to help you=20
evaluate Ceph.


"We provide light-weight deployment scripts to help you evaluate Ceph. =
=46or
professional deployment, you should consider professional deployment sy=
stems
such as Juju, Puppet, Chef or Crowbar."

I=A0 think there is a need to have native ceph deployment tools that ar=
en't dependent upon any third party deployment tools. So my question is=
 this
=A0=A0=A0=20
=A0=A0=A0 1. when will the light-weight deployment scripts be=20
available and which ceph version will they be released into?

=A0=A0=A0 2. Now, going forward, when will mkcephfs not work anymore (w=
hat ceph version)?

Isaac

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
