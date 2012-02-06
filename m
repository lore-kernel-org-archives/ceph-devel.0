From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: raodsgw--s3 client can't display objects with prefix of "_"
Date: Mon, 6 Feb 2012 13:21:20 -0800
Message-ID: <CAC-hyiHvA1B+D=0borNwf2w9G1uTMXjm48-iTfH7_+h51pr6wg@mail.gmail.com>
References: <CABAwU-Y_emMq1DBu3xkZsvXhD87f_tE8NnaYww_GxeFLm3mpeg@mail.gmail.com>
	<CAC-hyiG6mOmGNBNh6wVYF8QOdZ=cvXqB43piy3+C5bt_Q_6h4g@mail.gmail.com>
	<CABAwU-aaYHD3saGCOyBiGV9-OwM6NqKfcVBc=-kHks8AG1S=NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42913 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab2BFVVU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2012 16:21:20 -0500
Received: by yenm8 with SMTP id m8so2709236yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2012 13:21:20 -0800 (PST)
In-Reply-To: <CABAwU-aaYHD3saGCOyBiGV9-OwM6NqKfcVBc=-kHks8AG1S=NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Feb 5, 2012 at 7:49 PM, huang jun <hjwsm1989@gmail.com> wrote:
> 2012/2/6 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> On Sun, Feb 5, 2012 at 6:21 PM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>>> hi, all
>>> Recently, we use s3 client cyberduck to add some files to RADOS, it
>>> seems doesn't support objects named with prefix of '_'.
>>> eg, if we put a object named "_test"(1 prefix "_") in bucket TEST, =
it
>>> will store in RADOS in another name =A0"___test"(3 prefix "_").
>>> =A0 =A0 =A0but if we list bucket TEST, it sends op whoes oid is "__=
test"(2
>>> prefix "_"), result the RADOS return ENOENT err.
>>
>> That's a bug. From what I can tell, the bucket listing is broken (wh=
en
>> object name starts with underscore). I created bug #2025 in the ceph
>> tracker.
>>
>>> we trace the debug log,and found where it comes from:
>>> in =A0"translate_raw_obj" func of =A0rgw_common.h,
>>> =A0 =A0 if (obj.size() >=3D 2 && obj[1] =3D=3D '_') {
>>> =A0 =A0 =A0 =A0 =A0obj =3D obj.substr(1);
>>> =A0 =A0 =A0 =A0 return true;
>>> =A0 =A0 =A0}
>>> =A0why cut the obj name?
>>
>> The underscore serves as an escape character. Some object are create=
d
>> in a separate namespace, and the format for those objects is:
>>
>> _<namespace>_<obj name>
>>
>> These objects reside in the bucket, but may not be listable, and may
>> not be accounted in the bucket stats.
>>
>>> =A0what is "string ns" in struct rgw_obj doing here? Can't we just =
use
>>> the origin obj name that passed object_name verfication?
>>
>> 'ns' is the namespace. I'm not sure what check you're pointing at, b=
ut
>> we do need to handle the case where an object has a namespace
>> different than the default one.
>>
> I mean here is "validate_object_name" when init the rgw_handler.
> i think we should do nothing if the "ns" =A0string is empty.
> i have done a test, it works well except that when we download a file
> "_test' (size is 20B)
> the yberduck returns error "unexpected end of ZLIB input stream".

There are actually two different issues. One is that we don't escape
the preceding underscore correctly (adding two underscores instead of
one), and the second issue is that we don't return the translated
object when listing a bucket.

I pushed a fix for those issues to the ceph master branch. The only
caveat is that you can't access now any object that was uploaded that
started with underscore. If possible, it'd be best to remove those
objects before applying the fix. Let me know if that's a real issue.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
