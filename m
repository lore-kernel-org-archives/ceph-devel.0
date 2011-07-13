From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 11:21:45 -0700
Message-ID: <CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59720 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab1GMSVq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 14:21:46 -0400
Received: by fxd18 with SMTP id 18so6231898fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:21:45 -0700 (PDT)
In-Reply-To: <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 13, 2011 at 10:52 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> Following are my remarks to the new coding style document:
>
> On Wed, Jul 13, 2011 at 10:34 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> =A0 =A0- for regular classes, CamelCaps, private: section, etc.
>>
>> * Naming > Variable Names:
>>
>> =A0 Google uses _ suffix for class members. =A0We haven't up until n=
ow. =A0Should we?
>
> No.

Quick quiz: line 144 of rgw/rgw_op.cc, is ret a local or class
variable? How about line 1340? Or line 1419?

I am on commit 4761317b754c6a903862d1913b53c8ab5e06b8eb .

It's just confusing for class variables to teleport in with the same
names used by local variables elsewhere in the file. If you are lucky,
you'll get a type mismatch, but what if you're not? The fact that
local variables shadow class variables is "obvious" to someone with 10
years of C++ experience, but not so much to people from the community
trying to read the code.

This is why languages like Python don't have the "implicit this"--
every access to a class variable in python must look like
self.variable.
We should follow Google's lead here.

>
>>
>> * Naming > Constant Names:
>>
>> =A0 Google uses kSomeThing for constants. =A0We prefere SOME_THING.
>>
>> * Naming > Function Names:
>>
>> =A0 Google uses CamelCaps. =A0We use_function_names_with_underscores=
().
>>
>> =A0 Accessors are the same, {get,set}_field().
>>
>> * Naming > Enumerator Names:
>>
>> =A0 Name them like constants, as above (SOME_THING).
>>
>> * Comments > File Comments:
>>
>> =A0 Don't sweat it, unless the license varies from that of the proje=
ct (LGPL2) or
>> the code origin isn't reflected by the git history.
>>
>> * Formatting > Conditionals:
>>
>> =A0 - No spaces inside conditionals please, e.g.
>>
>> =A0 =A0 =A0 =A0if (foo) { =A0 // okay
>>
>> =A0 =A0 =A0 =A0if ( foo ) { // no
>>
>> =A0 - Always use newline following if:
>>
>> =A0 =A0 =A0 =A0if (foo)
>> =A0 =A0 =A0 =A0 =A0bar; =A0 =A0 =A0 =A0 // okay
>>
>> =A0 =A0 =A0 =A0if (foo) bar; =A0// no, usually hardler to visually p=
arse
>>
>>
>>
>>
>> The following guidelines have not been followed in the legacy code,
>> but are worth mentioning and should be followed strictly for new cod=
e:
>>
>> * Header Files > Function Parameter Ordering:
>>
>> =A0 =A0Inputs, then outputs.
>
> I generally agree, just that there's a class of strcpy like functions
> that put the destination first. This usually makes sense when you hav=
e
> multiple functions that do similar things with varied input
> parameters:
>
> =A0char *strcpy(char *dest, const char *src);
>
> =A0char *strncpy(char *dest, const char *src, size_t n);
>
> So in both cases, dest and src are the first and second parameters,
> which looks more consistent.

Well, nothing is set in stone. There are always exceptions if it
really makes sense. If you are designing a function patterned after
strcpy or whatever, making it "look like" strcpy probably makes a lot
of sense.

>
> And there's also the case of using default values, which usually
> (though not always) applies to the input parameters. Enforcing strict
> input before output ordering wouldn't work there.

Well, the Google document says not to use default parameters because
"they obscure the interface."
So that is a non-issue.

Check out commit 6e2b594b3329cb08bf54cd325776b236f2e6c4f1 for an
example of how default parameters can really bite.

Colin

>
>
>>
>> * Classes > Explicit Constructors:
>>
>> =A0 =A0You should normally mark constructors explicit to avoid getti=
ng silent
>> type conversions.
>>
>
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
