From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: Quota function of radosgw
Date: Tue, 31 May 2011 10:20:14 -0700
Message-ID: <BANLkTiniUg5njfxiOneg0Z6MZp19iHZ9qg@mail.gmail.com>
References: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
	<BANLkTikaeMSQ1PVoAopSxeqB5pmELuzGow@mail.gmail.com>
	<BANLkTimMsGNtOABRXFd24YeNumLM0gQzKw@mail.gmail.com>
	<BANLkTim8bUttOc-RLZ2XHe7e+5mreXOaBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54224 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1EaRUP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 13:20:15 -0400
Received: by vws1 with SMTP id 1so3433253vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 10:20:14 -0700 (PDT)
In-Reply-To: <BANLkTim8bUttOc-RLZ2XHe7e+5mreXOaBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 31, 2011 at 9:17 AM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> On Sat, May 28, 2011 at 7:45 PM, Sylar Shen <kimulaaa@gmail.com> wrot=
e:
>> Hi Gregory,
>> Thanks for your information very much!
>> Dropbox could limit the quota value of each user.
>> Does Dropbox implement the quota function by recording every size of
>> file in its own database?
>> Or Dropbox just controls the quota of each user by the client applic=
ation?
>> If Dropbox did neither of the two approaches above, how did they do?
>> Sorry it may be a little stupid question but I am curious about that=
=2E.....:p
> I really have no idea how Dropbox works; it's got no relation to Ceph
> except that I use it. ;)
>
>> By the way, the test of re-exporting NFS I did worked not bad.
>> And I am wondering since Ceph can re-export NFS, then can Ceph
>> re-export SAMBA that connects to windows?
> We don't have a samba re-export functionality, although you can just
> run samba on a Ceph mount if you like. And I think bchrisman is
> working on one, but you'd have to ask him about that. :)


Richard Sharpe and I have a VFS layer integrating Ceph (libceph) with
Samba that is just a stone's throw from basic functionality.
Current status:
mount/init, stat, opendir, readdir, and a few other operations are work=
ing.
We're chasing down what appears to be a few smaller problems related
to read/write.
We've also used to the acl_xattr module to avoid doing a bunch of acl
translations, though we could probably hit that in a second pass.
One future critical issue here is going to be the caching mechanism
and how it works with Samba's process model (process per connection).
This merits a discussion about how multiple libceph clients will work
together when run on the same host.

> -Greg
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
