From: Gregory Farnum <greg@gregs42.com>
Subject: Re: cephfs root_squash, multitenancy
Date: Fri, 13 Feb 2015 11:23:06 -0800
Message-ID: <CAC6JEv8ACd+udEODdbBUEfAXv03w=OjFEVdrPHsp57Z8svSQ5w@mail.gmail.com>
References: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46891 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbBMTXL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Feb 2015 14:23:11 -0500
Received: by iecvy18 with SMTP id vy18so21795625iec.13
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 11:23:10 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id b64sm4946370iob.42.2015.02.13.11.23.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2015 11:23:10 -0800 (PST)
Received: by iebtr6 with SMTP id tr6so11263589ieb.7
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 11:23:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 13, 2015 at 5:05 AM, Sage Weil <sweil@redhat.com> wrote:
> Got this from JJ:
>
>> The SA expanded on this by stating that there are basically three ma=
in
>> scenarios here:
>>
>> 1) We trust the UID/GID in a controlled environment. In which case w=
e
>> can safely rely on the POSIX permissions. As long as root_squash is
>> available this would be fine.
>
> I think adding a root_squash option to client/Client.cc and the ceph.=
ko
> should be pretty easy...
>
>> 2) Multi-tenant systems. In these cases being able to create keyring=
s
>> which limit access to specified directories would be ideal.
>
> This is mainly enforcing uid/gid and mount path in MDSAuthCap, and no=
t
> unlike what we'll need for OpenStack Manila.  I think it's something =
like
>
>  1- establish mount root inode ref when session is opened/authenticat=
ed
>  2- verify in reply path that any inode we reference is beneath that =
point
>  3- special case inodes in stray directory, hopefully in some secure-=
ish
> way based on where they lived previously.  (not sure how this'll work=
=2E..)

This concerns me:
1) We have nothing to control access to raw objects, so there is some
security against accidents here, but not against malicious code users.
2) Path verification is going to be tricky to handle with symlinks and
things. Moving it into the reply path as you discuss makes one set of
decisions on that (I'm not sure how flexibly?)
3) Cleanup in the case of failed requests would be pretty difficult =E2=
=80=94
we don't want to take away caps from other clients if the permissions
check failed, we have to "disappear" any which we were planning to
give out with the denied request, etc. And much of that work (eg the
cap revocation) happens well before the client gets any kind of reply,
for instance gathering data for stats. :(

That doesn't make any of these problems intractable, but I don't think
it's going to be a quick patch series and it will require a lot of
testing with new mechanisms that don't exist yet.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
