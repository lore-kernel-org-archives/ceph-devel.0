From: Gregory Farnum <greg@gregs42.com>
Subject: Re: cephfs root_squash, multitenancy
Date: Fri, 13 Feb 2015 15:57:47 -0800
Message-ID: <CAC6JEv_dk=RKW_gF25MJHLeJ4BrKXAaep-omOZnq0WMdDH8aKg@mail.gmail.com>
References: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
	<CAC6JEv8ACd+udEODdbBUEfAXv03w=OjFEVdrPHsp57Z8svSQ5w@mail.gmail.com>
	<alpine.DEB.2.00.1502131141170.3035@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43851 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbbBMX5t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Feb 2015 18:57:49 -0500
Received: by iebtr6 with SMTP id tr6so12704230ieb.10
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 15:57:48 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id s10sm4150107igr.2.2015.02.13.15.57.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2015 15:57:47 -0800 (PST)
Received: by iebtr6 with SMTP id tr6so12704194ieb.10
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 15:57:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502131141170.3035@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 13, 2015 at 3:35 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 13 Feb 2015, Gregory Farnum wrote:
>> On Fri, Feb 13, 2015 at 5:05 AM, Sage Weil <sweil@redhat.com> wrote:
>> > Got this from JJ:
>> >
>> >> The SA expanded on this by stating that there are basically three=
 main
>> >> scenarios here:
>> >>
>> >> 1) We trust the UID/GID in a controlled environment. In which cas=
e we
>> >> can safely rely on the POSIX permissions. As long as root_squash =
is
>> >> available this would be fine.
>> >
>> > I think adding a root_squash option to client/Client.cc and the ce=
ph.ko
>> > should be pretty easy...
>> >
>> >> 2) Multi-tenant systems. In these cases being able to create keyr=
ings
>> >> which limit access to specified directories would be ideal.
>> >
>> > This is mainly enforcing uid/gid and mount path in MDSAuthCap, and=
 not
>> > unlike what we'll need for OpenStack Manila.  I think it's somethi=
ng like
>> >
>> >  1- establish mount root inode ref when session is opened/authenti=
cated
>> >  2- verify in reply path that any inode we reference is beneath th=
at point
>> >  3- special case inodes in stray directory, hopefully in some secu=
re-ish
>> > way based on where they lived previously.  (not sure how this'll w=
ork...)
>>
>> This concerns me:
>> 1) We have nothing to control access to raw objects, so there is som=
e
>> security against accidents here, but not against malicious code user=
s.
>
> Yeah.  There's no complete solution without both pieces, but one of t=
hem
> has to come first.
>
>> 2) Path verification is going to be tricky to handle with symlinks a=
nd
>> things. Moving it into the reply path as you discuss makes one set o=
f
>> decisions on that (I'm not sure how flexibly?)
>
> Symlinks at least are easy: they are resolved on the client side in t=
he
> VFS (above ceph-fuse/libcephfs or ceph.ko).  As far as the file syste=
m is
> concerned symlinks are just a special type of file with a max size of
> PATH_MAX.

Whoops, right. I meant hard links. :)

>
> Remote links will be the tricky ones.  It would be nice if this was a
> simple check in the rdlock_* etc helpers in Server.cc but for hard li=
nks
> it would be one step past that.  On the other hand, it may make sense
> that if there is a hard link you get to see the file... in which case=
 the
> hard part will actually making sure that we allow it if the dentry is
> inside the allowed subtree.
>
> I said reply path before but now up-front checks in Server.cc seem mo=
re
> sensible.  :/ I need to spend some more time reading the code.

Up-front checks have been how we've more often proposed this, yes. I'd
just like a mechanism that isn't specialized for every op type =E2=80=94=
 for
instance, probably if there's a hard link you should be able to see
the file. But then we need code in the handle_client_link function to
make sure clients don't create links to files they can't already
access. (The target is just a filepath encoded by the client.)

Hrm, actually, maybe that just happens automatically if we put the
permission-checking code in Server::rdlock_path_pin_ref and/or
MDCache::path_traverse. That sounds familiar...

I think I've discussed this before in the context of external
contributors or a blueprint:
https://wiki.ceph.com/Planning/Sideboard/Client_Security_for_CephFS
and https://wiki.ceph.com/Planning/CDS/Dumpling/Etherpad_Snapshots/1G%3=
A_Client_Security_for_CephFS
might be helpful to come up to speed on this topic, but I think
there's a more extensive discussion somewhere from early last summer.
:/

Up-front actually doesn't sound *too* hard to me, but that still
leaves the testing, which honestly scares me more.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
