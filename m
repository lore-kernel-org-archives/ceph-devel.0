From: Gregory Farnum <greg@inktank.com>
Subject: Re: Keys & caps
Date: Tue, 10 Jul 2012 16:30:17 -0700
Message-ID: <CAPYLRzhCA61Lgaztgg1Y06xwD6yHREZZDfO8fKcn3TTTXpO98Q@mail.gmail.com>
References: <4183318.yLl07ggMzS@mranderson>
	<1968682.cis2SWxC6X@mranderson>
	<CAPYLRzgn6NC9193y4HsH7ASevtX-QWq9P=RrYJpmD3uvyoi8LA@mail.gmail.com>
	<1619446.aT01BgUE1G@mranderson>
	<alpine.DEB.2.00.1207101619230.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48630 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab2GJXaT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 19:30:19 -0400
Received: by lbbgm6 with SMTP id gm6so1318653lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 16:30:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207101619230.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>, ceph-devel@vger.kernel.org

On Tue, Jul 10, 2012 at 4:25 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 11 Jul 2012, Sz?kelyi Szabolcs wrote:
>> > >> The problem is that the mount.ceph command doesn't understand k=
eyrings;
>> > >> it
>> > >> only understands secret=3D and secretfile=3D.  There is a longs=
tanding
>> > >> feature
>> > >> bug open for this
>> > >>
>> > >>       http://tracker.newdream.net/issues/266
>> > >>
>> > >> but it hasn't been prioritized.  Sorry for the confusion!  It w=
ill happen
>> > >> soon.
>> > >>
>> > >> In the meantime, you need
>> > >>
>> > >>        -o secretfile=3D/path/to/secretfile,name=3Daccess_fs
>> > >
>> > > Is this also true for the FUSE client? I have obscure memories a=
bout big
>> > > differences between the kernel and the FUSE client, for example =
the latter
>> > > being able to read ceph.conf, and get the necessary info, includ=
ing the
>> > > keyring file, from there. Maybe I didn't emphasize it, but that'=
s what I'm
>> > > using.
>> >
>> > When using ceph-fuse, you want to specify the name with
>> > --name=3Daccess_fs ? no -o required.
>>
>> Okay, so I don't need the "client." prefix for the key name, but how=
 can I
>> specify the --name=3D option in fstab? Or is it possible to specify =
it in
>> ceph.conf, so it can be read by ceph-fuse when called by mount?
>
> Er sorry, you actually want either --id foo or --name client.foo (the=
y are
> equivalent) when dealing with ceph-fuse (or other userland daemons/to=
ols).

Nope =97=A0I checked this locally before sending it out. --name foo wor=
ked
out fine. Although I certainly can't keep straight when we require the
type prefix versus when it's added for us. *sigh*


> I'm not sure what the best way of putting fuse-based file systems in =
fstab
> is, though.  One way or another, though, ceph-fuse needs to be told o=
n the
> command line who to authenticate as (and which sections of ceph.conf =
to
> pay attention to).

This is my concern, too. I don't think you can specify default IDs for
ceph-fuse right now. :/

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
