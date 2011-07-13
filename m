From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 11:04:50 -0700
Message-ID: <CAC-hyiEsL2yw83pELy8-XdGqxMst_XZX4RGCW4-S6GCFjRRiZQ@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<4E1DDCEA.9010107@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46539 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab1GMSEw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 14:04:52 -0400
Received: by ewy4 with SMTP id 4so2296904ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:04:50 -0700 (PDT)
In-Reply-To: <4E1DDCEA.9010107@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samuel.just@dreamhost.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 10:59 AM, Samuel Just <samuelj@hq.newdream.net>=
 wrote:
> On 07/13/2011 10:52 AM, Yehuda Sadeh Weinraub wrote:
>>>
>>> * Naming> =A0Type Names:
>>>
>>> =A0 =A0Google uses CamelCaps for all type names. =A0We use two nami=
ng schemes:
>>>
>>> =A0 =A0- for structs (simple data containers), lower case with _t s=
uffix:
>>> =A0 =A0 =A0 =A0struct my_type_t {
>>> =A0 =A0 =A0 =A0 =A0int a, b;
>>> =A0 =A0 =A0 =A0 =A0my_type_t() : a(0), b(0) {}
>>> =A0 =A0 =A0 =A0};
>>
>> I'd rather have the struct naming without the _t suffix (as with the=
 C
>> code), and typedef to add _t, e.g.:
>>
>> typedef struct my_type {
>> =A0...
>> } my_type_t;
>>
> What is the advantage of the typedef?

Being consistent. That's what we do in C. The _t suffix denotes a
typedef, so it should be defined as one. We also mix C and C++ from
time to time (e.g., we have code that is common to both userspace side
and kernel side and/or links with other projects like qemu), so
keeping the same notation is crucial.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
