From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 11:32:43 -0700
Message-ID: <CAC-hyiGOjPhNfrq11Tfwe=S_FTm+2dGncJZ8oEmOisvg55Cb1A@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<4E1DDCEA.9010107@hq.newdream.net>
	<CAC-hyiEsL2yw83pELy8-XdGqxMst_XZX4RGCW4-S6GCFjRRiZQ@mail.gmail.com>
	<CA+qbEUMSDOrCGPB4YO0ysAs_VzXzHUJNKSe2a9fKoDLjVOEOtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab1GMSfb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 14:35:31 -0400
Received: by bwd5 with SMTP id 5so4896357bwd.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:35:29 -0700 (PDT)
In-Reply-To: <CA+qbEUMSDOrCGPB4YO0ysAs_VzXzHUJNKSe2a9fKoDLjVOEOtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: samuel.just@dreamhost.com, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 11:08 AM, Colin McCabe <cmccabe@alumni.cmu.edu>=
 wrote:
> On Wed, Jul 13, 2011 at 11:04 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Wed, Jul 13, 2011 at 10:59 AM, Samuel Just <samuelj@hq.newdream.n=
et> wrote:
>>> On 07/13/2011 10:52 AM, Yehuda Sadeh Weinraub wrote:
>>>>>
>>>>> * Naming> =A0Type Names:
>>>>>
>>>>> =A0 =A0Google uses CamelCaps for all type names. =A0We use two na=
ming schemes:
>>>>>
>>>>> =A0 =A0- for structs (simple data containers), lower case with _t=
 suffix:
>>>>> =A0 =A0 =A0 =A0struct my_type_t {
>>>>> =A0 =A0 =A0 =A0 =A0int a, b;
>>>>> =A0 =A0 =A0 =A0 =A0my_type_t() : a(0), b(0) {}
>>>>> =A0 =A0 =A0 =A0};
>>>>
>>>> I'd rather have the struct naming without the _t suffix (as with t=
he C
>>>> code), and typedef to add _t, e.g.:
>>>>
>>>> typedef struct my_type {
>>>> =A0...
>>>> } my_type_t;
>>>>
>>> What is the advantage of the typedef?
>>
>> Being consistent. That's what we do in C. The _t suffix denotes a
>> typedef, so it should be defined as one. We also mix C and C++ from
>> time to time (e.g., we have code that is common to both userspace si=
de
>> and kernel side and/or links with other projects like qemu), so
>> keeping the same notation is crucial.
>>
>
> Actually, using typedef that way is *inconsistent*, since we claim to
> follow the kernel coding style document. And this is what it has to
> say about that:
>
>> Please don't use things like "vps_t".
>>
>> It's a _mistake_ to use typedef for structures and pointers. When yo=
u see a
>>
>> =A0 =A0 =A0 vps_t a;
>>
>> in the source, what does it mean?
>>
>> In contrast, if it says
>>
>> =A0 =A0 =A0 struct virtual_container *a;
>>
>> you can actually tell what "a" is.

Whether to typedef or not is a different issue. If you want a _t
suffix, use typedef.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
