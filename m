From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: subdir-objects
Date: Sat, 7 Sep 2013 10:47:07 -0700
Message-ID: <CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
	<CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
	<CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com>
	<CAN04cT6FOspeq0NEN798ChLAJUuXsV2cFnzDLbQVNj0=pO6PPw@mail.gmail.com>
	<CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:57498 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3IGRrI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Sep 2013 13:47:08 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so3011014vbe.13
        for <ceph-devel@vger.kernel.org>; Sat, 07 Sep 2013 10:47:07 -0700 (PDT)
In-Reply-To: <CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Oh, and one question about the non-recursive approach. If I stick a
Makefile.am in the test/ directory I can do things like:

  LDADD =3D all-the-test-dependencies

and then avoid redundant per-target primaries like test_LDADD =3D (deps=
)
$(LDADD), because it applies to everything in the Makefile.

Is that possible with the include approach, or would a naked LDADD in
an included Makefile fragment affect all the targets in the file
including it?

-Noah

On Sat, Sep 7, 2013 at 10:38 AM, Noah Watkins <noah.watkins@inktank.com=
> wrote:
> The non-recursive approach is interesting. I just had a quick look in
> the tree I despise building the most, openmpi. It has 414 Makefile.am=
,
> and uses recursive builds. The rebuild definitely takes a while to
> visit all the sub-dirs, and is pretty annoying when my patience is lo=
w
> :)
>
> And there is definitely a big +1 for avoiding the SUBDIRS
> synchronization that slows down parallel make.
>
> I think the benefits of using recursive builds are that it may be
> familiar to the most people, it reflects the methods/suggestions in
> the automake manual, and, most importantly, it would seem that its us=
e
> forces good decomposition where as a non-recursive approach relies on
> guidelines that are easily broken.
>
> Given that the Ceph tree is relatively small (certinaly in comparison
> to the 414 directory openmpi monster), are there benefits to the
> non-recursive approach that are not performance related?
>
> - Noah
>
> On Sat, Sep 7, 2013 at 1:52 AM, Roald van Loon <roaldvanloon@gmail.co=
m> wrote:
>> Hi Noah,
>>
>> I just had a quick look at your build-refactor branch, and I think t=
he
>> greatest difference is that you use recursive builds and I don't. I'=
m
>> more in favor of non-recursive builds using includes for a number of
>> reasons. I think the most important reasons for me are;
>>
>> 1) recursive make leads to repetitive AM code
>> 2) recursive make takes much more time to compile (as each directory
>> needs to run configure and probably most important: you loose optima=
l
>> -jX usage due to serialization)
>> 3) non-recursive make knows all deps so rebuildings is much quicker
>> (it only compiles/links what is required instead of entering all
>> subdirs)
>>
>> There is =CFMHO one good reason to use recursive build, and that is
>> separation of AM code. However, that can be easily achieved with
>> includes and subdir-objects.
>>
>> I think this is the most important difference between your and my
>> approach, and I like to hear your arguments for recursive builds so =
we
>> can agree on recursive vs non-recursive make. Then I think it would =
be
>> great to combine work!
>>
>> Roald
>>
>> On Fri, Sep 6, 2013 at 7:27 PM, Noah Watkins <noah.watkins@inktank.c=
om> wrote:
>>> Hi Roald,
>>>
>>> Sage just pointed me at your wip-automake branch. I also just pushe=
d
>>> up a branch, make-refactor, that I was hacking on a bit. Not sure h=
ow
>>> much overlap there is, or if my approach is bogus, but I thought I'=
d
>>> point it out to see if there is anything that can be combined :)
>>>
>>> -Noah
>>>
>>> On Wed, Aug 21, 2013 at 2:01 PM, Roald van Loon <roaldvanloon@gmail=
=2Ecom> wrote:
>>>> On Wed, Aug 21, 2013 at 10:41 PM, Sage Weil <sage@inktank.com> wro=
te:
>>>>> Yes, the Makefile.am is in dire need of from TLC from someone who=
 knows a
>>>>> bit of autotools-fu.  It is only this way because in the beginnin=
g I
>>>>> didn't know any better.
>>>>
>>>> Well, my average knowledge of autotools could at least fix this
>>>> particular issue and clean up a bit more. It's a start I guess and
>>>> helps me to continue my RGW things.
>>>>
>>>> I'll send out a pull request when I've found some time to implemen=
t
>>>> and test this.
>>>>
>>>> Roald
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
