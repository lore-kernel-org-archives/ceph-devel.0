From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: coding style document
Date: Wed, 13 Jul 2011 10:52:01 -0700
Message-ID: <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:54590 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab1GMRzJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 13:55:09 -0400
Received: by fxd18 with SMTP id 18so6210978fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 10:55:08 -0700 (PDT)
In-Reply-To: <CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

=46ollowing are my remarks to the new coding style document:

On Wed, Jul 13, 2011 at 10:34 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> Ceph Coding style
> -----------------
>
> Coding style is most important for new code and (to a lesser extent)
> revised code. =A0It is not worth the churn to simply reformat old cod=
e.
>
> C code
> ------
>
> For C code, we conform by the Linux kernel coding standards:
>
> =A0 =A0http://lxr.linux.no/linux/Documentation/CodingStyle
>
>
> C++ code
> --------
>
> For C++ code, things are a bit more complex. =A0As a baseline, we use=
 Google's
> coding guide:
>
> =A0 =A0 =A0 http://google-styleguide.googlecode.com/svn/trunk/cppguid=
e.xml
>
>
> As an addendum to the above, we add the following guidelines, organiz=
ed
> by section.
>
> * Naming > Type Names:
>
> =A0 =A0Google uses CamelCaps for all type names. =A0We use two naming=
 schemes:
>
> =A0 =A0- for structs (simple data containers), lower case with _t suf=
fix:
> =A0 =A0 =A0 =A0struct my_type_t {
> =A0 =A0 =A0 =A0 =A0int a, b;
> =A0 =A0 =A0 =A0 =A0my_type_t() : a(0), b(0) {}
> =A0 =A0 =A0 =A0};

I'd rather have the struct naming without the _t suffix (as with the C
code), and typedef to add _t, e.g.:

typedef struct my_type {
=A0...
} my_type_t;

> =A0 =A0- for regular classes, CamelCaps, private: section, etc.
>
> * Naming > Variable Names:
>
> =A0 Google uses _ suffix for class members. =A0We haven't up until no=
w. =A0Should we?

No.

>
> * Naming > Constant Names:
>
> =A0 Google uses kSomeThing for constants. =A0We prefere SOME_THING.
>
> * Naming > Function Names:
>
> =A0 Google uses CamelCaps. =A0We use_function_names_with_underscores(=
).
>
> =A0 Accessors are the same, {get,set}_field().
>
> * Naming > Enumerator Names:
>
> =A0 Name them like constants, as above (SOME_THING).
>
> * Comments > File Comments:
>
> =A0 Don't sweat it, unless the license varies from that of the projec=
t (LGPL2) or
> the code origin isn't reflected by the git history.
>
> * Formatting > Conditionals:
>
> =A0 - No spaces inside conditionals please, e.g.
>
> =A0 =A0 =A0 =A0if (foo) { =A0 // okay
>
> =A0 =A0 =A0 =A0if ( foo ) { // no
>
> =A0 - Always use newline following if:
>
> =A0 =A0 =A0 =A0if (foo)
> =A0 =A0 =A0 =A0 =A0bar; =A0 =A0 =A0 =A0 // okay
>
> =A0 =A0 =A0 =A0if (foo) bar; =A0// no, usually hardler to visually pa=
rse
>
>
>
>
> The following guidelines have not been followed in the legacy code,
> but are worth mentioning and should be followed strictly for new code=
:
>
> * Header Files > Function Parameter Ordering:
>
> =A0 =A0Inputs, then outputs.

I generally agree, just that there's a class of strcpy like functions
that put the destination first. This usually makes sense when you have
multiple functions that do similar things with varied input
parameters:

  char *strcpy(char *dest, const char *src);

  char *strncpy(char *dest, const char *src, size_t n);

So in both cases, dest and src are the first and second parameters,
which looks more consistent.

And there's also the case of using default values, which usually
(though not always) applies to the input parameters. Enforcing strict
input before output ordering wouldn't work there.


>
> * Classes > Explicit Constructors:
>
> =A0 =A0You should normally mark constructors explicit to avoid gettin=
g silent
> type conversions.
>


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
