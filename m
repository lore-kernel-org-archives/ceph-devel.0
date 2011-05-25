From: huang jun <hjwsm1989@gmail.com>
Subject: Re: dnl status in mds rejoin operation
Date: Wed, 25 May 2011 09:01:32 +0800
Message-ID: <BANLkTiny0VEjq_1K7J-TiNDFSVc73BiXzg@mail.gmail.com>
References: <BANLkTikG1C1WDEvSmpA+QEaxvY-o5ruf1g@mail.gmail.com>
	<Pine.LNX.4.64.1105241651140.9499@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36059 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1EYBBd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 21:01:33 -0400
Received: by wwa36 with SMTP id 36so7907233wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 18:01:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105241651140.9499@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thanks,sage
I will look into it soon

2011/5/25 Sage Weil <sage@newdream.net>:
> On Tue, 24 May 2011, huang jun wrote:
>> hi,all
>> =A0 =A0There is an assert(dnl->is_primary()) in function "rejoin_wal=
k()".
>> why should the dnl must be primary if we want to =A0continue rejoin
>> operation? or the assert() crashed.
>
> The rejoin_walk() method traverse subtrees for which we are _not_ aut=
h,
> and the only dentries and inodes we should have in those subtrees aft=
er
> recovery are ancestors of subtrees that we are auth for, which implie=
s
> they are primary. =A0If it encounters a non-primary dentry here, ther=
e is
> a bug earlier in recovery.. probably in trim_non_auth()?
>
>> =A0 =A0I want to know whether the status of the replica subtree root
>> directory's dentry should be primary?
>
> Directory inode parent dentries will always be primary; multiple hard
> links to a directory are not allowed.
>
>> =A0 =A0And =A0we assume one dentry in directory is a remote link ,th=
en place
>> this dentry in a fragment, can we create the replicas of this fragme=
nt
>> in other MDSs?
>
> Any dentry can be replicated (primary, remote, or null) once the MDS =
is
> active.
>
> Does that answer your question?
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
