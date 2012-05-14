From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:36:19 -0700
Message-ID: <CAC-hyiG41doR4-oxzR5F1g3BR3g=fN8WUMaohe0QRihQj7f7TQ@mail.gmail.com>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
	<CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
	<FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
	<Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60294 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab2ENRgV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:36:21 -0400
Received: by bkcji2 with SMTP id ji2so4060838bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 10:36:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>

On Mon, May 14, 2012 at 10:34 AM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 14 May 2012, Noah Watkins wrote:
>> On May 14, 2012, at 10:03 AM, Tommi Virtanen wrote:
>> > On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu=
> wrote:
>> >> Return an error rather than a segfault if a client uses the inter=
face
>> >> when unmounted. The Java bindings were explicitly enforcing the
>> >> mounted state, but this was overly complicated, uncommon, and bet=
ter
>> >> handled with a simple exception that can be checked at libcephfs =
level.
>> > ...
>> >> + =A0if (!cmount->is_mounted())
>> >> + =A0 =A0return -EDOM;
>> >
>> > Noah, this is not really about your patch, as existing code alread=
y
>> > has return -EDOM, but... oh boy does the API abuse POSIX errors.
>> >
>> > "Numerical argument out of domain".
>>
>> :) =A0Yeh, i stared at errno.h for a while. Note that -EDOM is alrea=
dy
>> returned by mount() when it is already mounted.
>
> Given the small number of libcephfs users, let's not be afraid to cha=
nge
> it to something better.
>

The easiest would be -EINVAL.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
