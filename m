From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 10:59:06 -0700
Message-ID: <4E1DDCEA.9010107@hq.newdream.net>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com> <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41457 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab1GMR7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 13:59:06 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A540FC066
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 10:59:05 -0700 (PDT)
Received: from [192.168.107.170] (ip-64-111-111-107.dreamhost.com [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 97951C062
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 10:59:05 -0700 (PDT)
In-Reply-To: <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 07/13/2011 10:52 AM, Yehuda Sadeh Weinraub wrote:
>> * Naming>  Type Names:
>>
>>     Google uses CamelCaps for all type names.  We use two naming schemes:
>>
>>     - for structs (simple data containers), lower case with _t suffix:
>>         struct my_type_t {
>>           int a, b;
>>           my_type_t() : a(0), b(0) {}
>>         };
> I'd rather have the struct naming without the _t suffix (as with the C
> code), and typedef to add _t, e.g.:
>
> typedef struct my_type {
>   ...
> } my_type_t;
>
What is the advantage of the typedef?
>>     - for regular classes, CamelCaps, private: section, etc.
>>
>> * Naming>  Variable Names:
>>
>>    Google uses _ suffix for class members.  We haven't up until now.  Should we?
> No.
>
>> * Naming>  Constant Names:
>>
>>    Google uses kSomeThing for constants.  We prefere SOME_THING.
>>
>> * Naming>  Function Names:
>>
>>    Google uses CamelCaps.  We use_function_names_with_underscores().
>>
>>    Accessors are the same, {get,set}_field().
>>
>> * Naming>  Enumerator Names:
>>
>>    Name them like constants, as above (SOME_THING).
>>
>> * Comments>  File Comments:
>>
>>    Don't sweat it, unless the license varies from that of the project (LGPL2) or
>> the code origin isn't reflected by the git history.
>>
>> * Formatting>  Conditionals:
>>
>>    - No spaces inside conditionals please, e.g.
>>
>>         if (foo) {   // okay
>>
>>         if ( foo ) { // no
>>
>>    - Always use newline following if:
>>
>>         if (foo)
>>           bar;         // okay
>>
>>         if (foo) bar;  // no, usually hardler to visually parse
>>
>>
>>
>>
>> The following guidelines have not been followed in the legacy code,
>> but are worth mentioning and should be followed strictly for new code:
>>
>> * Header Files>  Function Parameter Ordering:
>>
>>     Inputs, then outputs.
> I generally agree, just that there's a class of strcpy like functions
> that put the destination first. This usually makes sense when you have
> multiple functions that do similar things with varied input
> parameters:
>
>    char *strcpy(char *dest, const char *src);
>
>    char *strncpy(char *dest, const char *src, size_t n);
>
> So in both cases, dest and src are the first and second parameters,
> which looks more consistent.
>
> And there's also the case of using default values, which usually
> (though not always) applies to the input parameters. Enforcing strict
> input before output ordering wouldn't work there.
>
>
>> * Classes>  Explicit Constructors:
>>
>>     You should normally mark constructors explicit to avoid getting silent
>> type conversions.
>>
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

