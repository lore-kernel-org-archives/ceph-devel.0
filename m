From: Gregory Farnum <greg@inktank.com>
Subject: Re: Does radosgw really need to talk to an MDS?
Date: Mon, 2 Jul 2012 09:23:50 -0700
Message-ID: <CAPYLRzjRMebP7Qd6aPHgpo0X0MYF6uUqhS3f6GALqFUpBomi7A@mail.gmail.com>
References: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
	<4FF1898E.7000202@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45621 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab2GBQXv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 12:23:51 -0400
Received: by lbbgm6 with SMTP id gm6so7858194lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 09:23:50 -0700 (PDT)
In-Reply-To: <4FF1898E.7000202@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

On Mon, Jul 2, 2012 at 4:44 AM, Wido den Hollander <wido@widodh.nl> wro=
te:
> Hi,
>
>
> On 02-07-12 13:41, Florian Haas wrote:
>>
>> Hi everyone,
>>
>> radosgw(8) states that the following capabilities must be granted to
>> the user that radosgw uses to connect to RADOS.
>>
>> ceph-authtool -n client.radosgw.gateway --cap mon 'allow r' --cap os=
d
>> 'allow rwx' --cap mds 'allow' /etc/ceph/keyring.radosgw.gateway
>>
>> Could someone explain why we need an "mds 'allow'" in here? I though=
t
>> only CephFS clients talked to MDSs, and at first glance configuring
>> client.radosgw.gateway without any MDS capability seems not to break
>> anything (at least with my limited S3 tests). Am I missing something=
?
>>
>
> You are not allowing the RADOS Gateway to do anything on the MDS.
>
> There is no 'r', =A0'w' or 'x' permission which you are allowing. So =
there is
> nothing the rgw has access to on the MDS.

Actually, that is an MDS cap =97=A0it's the "allow" cap, and that's all
that the MDS checks right now. But it is indeed completely unnecessary
for the MDS. (Thanks for the doc fix, Florian!)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
