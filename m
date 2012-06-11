From: John Axel Eriksson <john@insane.se>
Subject: Re: Ceph questions regarding auth and return on PUT from radosgw
Date: Mon, 11 Jun 2012 14:41:59 +0200
Message-ID: <CAMmJxtL_sGx6fSs2+CZet10JVDPJqebkqreJuHQzhgUxngM-nw@mail.gmail.com>
References: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com>
	<4FD5E74A.8070903@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63768 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab2FKMmA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 08:42:00 -0400
Received: by obbtb18 with SMTP id tb18so6688076obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 05:41:59 -0700 (PDT)
In-Reply-To: <4FD5E74A.8070903@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Oh sorry. I don't think I was clear on the auth question. What I meant
was if the admin.keyring and keys for the osd:s are really necessary
in a private ceph-cluster.

On Mon, Jun 11, 2012 at 2:40 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
>
> On 06/11/2012 02:32 PM, John Axel Eriksson wrote:
>>
>> Is there a point to having auth enabled if I run ceph on an internal
>> network, only for use with radosgw (i.e the object storage part)?
>> It seems to complicate the setup unnecessarily and ceph doesn't use
>> encryption anyway as far as I understand, it's only auth.
>> If my network is trusted and I know who has access (and I trust them=
)
>> - is there a point to complicate the setup with key-based auth?
>>
>
> The RADOS Gateway uses the S3 protocol and that requires authenticati=
on and
> authorization.
>
> When creating a bucket/pool and storing objects, it has to be mapped =
to a
> users inside the RADOS GW.
>
> I don't know what your exact use-case is, but if it's only internal, =
isn't
> it a possibility to use RADOS natively?
>
>
>> Also, when PUTting something through radosgw, does ceph/rgw return a=
s
>> soon as all data has been received or does it return
>> when it has ensured N replicas? (I've seen quite a delay after all
>> data has been sent before my PUT returns). I'm using nginx (1.2) by
>> the way.
>
>
> iirc it returns when all replicas have received and stored the object=
=2E
>
> Wido
>
>>
>> Thanks!
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
