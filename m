From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: global_init fails when only specifying monitor address
Date: Sat, 28 Apr 2012 18:10:42 -0700
Message-ID: <CA+qbEUMucp8tpF_ofTrinvE1e7Krue1gT164H04UQOkDueYuqQ@mail.gmail.com>
References: <4F994883.3060805@widodh.nl>
	<Pine.LNX.4.64.1204260932260.6109@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45099 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab2D2BKo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Apr 2012 21:10:44 -0400
Received: by wibhj6 with SMTP id hj6so1768368wib.1
        for <ceph-devel@vger.kernel.org>; Sat, 28 Apr 2012 18:10:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204260932260.6109@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There's no technical reason why you can't simply remove these lines:

>  if (ret =3D=3D -EDOM) {
>    dout_emergency("global_init: error parsing config file.\n");
>    _exit(1);
>  }

Without a configuration file, you'll just get the defaults for
everything.  Wido, it sounds like that is what you're already doing by
passing in "-c /dev/null"

So why didn't we do that in the first place?  It was basically a
philosophical reason.  We have a section in the configuration file for
clients.  If clients don't use that section, then it would seem kind
of pointless to have it.  If I were a system administrator, I might be
annoyed by accidentally failing to set CEPH_CONF in my .bashrc, and
getting a bunch of defaults flooding in when I ran /usr/bin/ceph (or
some other tool).

With that being said, there is a case to be made that we should let
people run without a configuration file if they so desire.  Most UNIX
utilities will run with out without a configuration file, so maybe
that's what cephtool and similar utilities should do.  Your call.


Unrelated:
It might be a good time to get rid of that chunk of code in
md_config_t::parse_config_files_impl that does "Warn about section
names that look like old-style section names."  It's been a while
since that actually mattered, I believe.

Colin


On Thu, Apr 26, 2012 at 9:33 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 26 Apr 2012, Wido den Hollander wrote:
>> Hi,
>>
>> I tried to connect to a small Ceph setup on my desktop without cephx=
 and that
>> failed:
>>
>> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 -s
>> global_init: unable to open config file.
>> root@stack01:~#
>>
>> I however worked with:
>>
>> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 -c /dev/null -s
>> 2012-04-26 14:55:33.828524 =A0 =A0pg v148: 594 pgs: 594 active+clean=
; 0 bytes
>> data, 7740 KB used, 70571 MB / 76800 MB avail
>> 2012-04-26 14:55:33.829622 =A0 mds e1: 0/0/1 up
>> 2012-04-26 14:55:33.836144 =A0 osd e14: 3 osds: 3 up, 3 in
>> 2012-04-26 14:55:33.886429 =A0 log 2012-04-26 14:52:50.674430 osd.1
>> [2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6807/28366 12 : [INF] 1.2b scr=
ub ok
>> 2012-04-26 14:55:33.892423 =A0 mon e1: 1 mons at
>> {desktop=3D[2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6789/0}
>> root@stack01:~#
>>
>> I quick look at global_init.cc showed me why this happened, it simpl=
y looks
>> for a configuration file to open and when it can't it fails.
>>
>> But if a monitor address is set, a config file shouldn't be mandator=
y.
>>
>> It could be accomplished rather simple by setting the flag
>> CINIT_FLAG_NO_DEFAULT_CONFIG_FILE if a mon_host has been set, but to=
 do that
>> conf->parse_argv(args); should move a few lines up.
>>
>> Comments? Thoughts?
>
> I wonder if the simplest thing to do is:
>
> =A0- never error out on missing config in the default search path
> =A0- always error out on missing config if it was explicitly specifie=
d via
> =A0 -c foo or CEPH_CONF in environment.
>
> ?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
