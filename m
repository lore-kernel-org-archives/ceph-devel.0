From: huang jun <hjwsm1989@gmail.com>
Subject: Re: raodsgw--s3 client can't display objects with prefix of "_"
Date: Mon, 6 Feb 2012 11:49:21 +0800
Message-ID: <CABAwU-aaYHD3saGCOyBiGV9-OwM6NqKfcVBc=-kHks8AG1S=NA@mail.gmail.com>
References: <CABAwU-Y_emMq1DBu3xkZsvXhD87f_tE8NnaYww_GxeFLm3mpeg@mail.gmail.com>
	<CAC-hyiG6mOmGNBNh6wVYF8QOdZ=cvXqB43piy3+C5bt_Q_6h4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:60021 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab2BFDtW convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 5 Feb 2012 22:49:22 -0500
Received: by obcva7 with SMTP id va7so6289554obc.19
        for <ceph-devel@vger.kernel.org>; Sun, 05 Feb 2012 19:49:21 -0800 (PST)
In-Reply-To: <CAC-hyiG6mOmGNBNh6wVYF8QOdZ=cvXqB43piy3+C5bt_Q_6h4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/2/6 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Sun, Feb 5, 2012 at 6:21 PM, huang jun <hjwsm1989@gmail.com> wrote=
:
>> hi, all
>> Recently, we use s3 client cyberduck to add some files to RADOS, it
>> seems doesn't support objects named with prefix of '_'.
>> eg, if we put a object named "_test"(1 prefix "_") in bucket TEST, i=
t
>> will store in RADOS in another name =A0"___test"(3 prefix "_").
>> =A0 =A0 =A0but if we list bucket TEST, it sends op whoes oid is "__t=
est"(2
>> prefix "_"), result the RADOS return ENOENT err.
>
> That's a bug. From what I can tell, the bucket listing is broken (whe=
n
> object name starts with underscore). I created bug #2025 in the ceph
> tracker.
>
>> we trace the debug log,and found where it comes from:
>> in =A0"translate_raw_obj" func of =A0rgw_common.h,
>> =A0 =A0 if (obj.size() >=3D 2 && obj[1] =3D=3D '_') {
>> =A0 =A0 =A0 =A0 =A0obj =3D obj.substr(1);
>> =A0 =A0 =A0 =A0 return true;
>> =A0 =A0 =A0}
>> =A0why cut the obj name?
>
> The underscore serves as an escape character. Some object are created
> in a separate namespace, and the format for those objects is:
>
> _<namespace>_<obj name>
>
> These objects reside in the bucket, but may not be listable, and may
> not be accounted in the bucket stats.
>
>> =A0what is "string ns" in struct rgw_obj doing here? Can't we just u=
se
>> the origin obj name that passed object_name verfication?
>
> 'ns' is the namespace. I'm not sure what check you're pointing at, bu=
t
> we do need to handle the case where an object has a namespace
> different than the default one.
>
I mean here is "validate_object_name" when init the rgw_handler.
i think we should do nothing if the "ns"  string is empty.
i have done a test, it works well except that when we download a file
"_test' (size is 20B)
the yberduck returns error "unexpected end of ZLIB input stream".
> Thanks,
> Yehuda



--
thanks.
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
