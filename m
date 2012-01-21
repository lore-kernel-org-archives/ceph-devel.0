From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: wip-encoding
Date: Fri, 20 Jan 2012 16:52:31 -0800
Message-ID: <CAF3hT9BwUW8mHsB+Z2u_iUGZp0494wGKjFgmjhzipxuYhXcV_w@mail.gmail.com>
References: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
	<CAF3hT9CMJ1MZmA6Dkzj8ZXKpDtYECk_h3s2rudQjYkZDc-2cQw@mail.gmail.com>
	<Pine.LNX.4.64.1201201045230.8753@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35060 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2AUAwc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2012 19:52:32 -0500
Received: by iacb35 with SMTP id b35so334280iac.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jan 2012 16:52:31 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201201045230.8753@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 20, 2012 at 10:58 AM, Sage Weil <sage@newdream.net> wrote:
> The current pattern is
>
> void Foo::encode(bufferlist& bl, unsigned features) const
> {
> =A0if (features & NEW_THING) {
> =A0 =A0 // encode normally
> =A0} else {
> =A0 =A0 // encode old way (wahtever was in this func)
> =A0}
> }
>
> I'm not sure what to add here to make this less painful or error-pron=
e.
> ceph-dencoder does have options to print the feature set for the vers=
ion
> it was compiled for, and to set the bits passed to encoder functions,=
 so
> that we can test these paths.

Well, our features tend to all move forward, so perhaps we should have
a way of specifying different encoders based on the feature bits (or
struct version) we're targeting, instead of if-elsing through the code
(nesting with something like this tends to sprawl ever-deeper). I
think that would make it easier to test inter-version compatibility
and avoid accidentally breaking interoperation.

Not having spent a bunch of time thinking about how to do this I don't
have obviously better ideas off-hand, but I'd really like it if
somebody could either present a good option or else say why we won't
get anything much better, instead of just pressing ahead because
nobody has any better ideas. :( We're going to be stuck with this for
a while.


>> > This requires and initial incompat change to add the length and in=
compat
>> > fields, but then we can generally add things without breakage.
>> Hmm...if we come up with something that talks feature bits we could =
do
>> this nicely with a compat bit. :)
>
> Hmm, yeah. =A0If we redo a bunch of encoders at once we can use a
> single feature bit for all of them. =A0That's a good idea!

I'm not sure my thought came across clearly =97=A0we should be able to =
use
a compat rather than an incompat flag if we have a good way to target
multiple versions in our encoder.


> I cleaned up the tool usage a bit and it currently looks like
>
> $ ./ceph-dencoder -h
> usage: ceph-dencoder [commands ...]
>
> =A0version =A0 =A0 =A0 =A0 =A0print version string (to stdout)
>
> =A0import <encfile> read encoded data from encfile
> =A0export <outfile> write encoded data to outfile
>
> =A0features <num> =A0 set feature bits used for encoding
> =A0get_features =A0 =A0 print feature bits (int) to stdout

We will probably be happier in the long run if we can use symbolic
names for the features. Not sure how difficult that would be, though.

> =A0list_types =A0 =A0 =A0 list supported types
> =A0type <classname> select type
> =A0decode =A0 =A0 =A0 =A0 =A0 decode into in-core object
> =A0encode =A0 =A0 =A0 =A0 =A0 encode in-core object
> =A0dump_json =A0 =A0 =A0 =A0dump in-core object as json (to stdout)
>
> =A0count =A0 =A0 =A0 =A0 =A0 =A0print number of generated test object=
s (to stdout)
> =A0select <n> =A0 =A0 =A0 select generated test object as in-core obj=
ect

I'm not sure what "in-core" means here, nor what it means to "select ty=
pe".

The rest looks good to me, though. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
