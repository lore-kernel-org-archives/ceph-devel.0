From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: defaults paths
Date: Thu, 5 Apr 2012 11:12:48 +0400
Message-ID: <CABYiri_sVOpvbZnJ7rEBsrtDtW+qzo-vSyVLZjEa9gcv8j-+hA@mail.gmail.com>
References: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net> <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57714 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab2DEHNK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 03:13:10 -0400
Received: by wejx9 with SMTP id x9so653501wej.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 00:13:09 -0700 (PDT)
In-Reply-To: <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Right, but probably we need journal separation at the directory level
by default, because there is a very small amount of cases when speed
of main storage is sufficient for journal or when resulting speed
decrease is not significant, so journal by default may go into
/var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
the fast disk.

On Thu, Apr 5, 2012 at 10:57 AM, Bernard Grymonpon <bernard@openminds.b=
e> wrote:
>
> On 05 Apr 2012, at 08:32, Sage Weil wrote:
>
>> We want to standardize the locations for ceph data directories, conf=
igs,
>> etc. =C2=A0We'd also like to allow a single host to run OSDs that pa=
rticipate
>> in multiple ceph clusters. =C2=A0We'd like easy to deal with names (=
i.e., avoid
>> UUIDs if we can).
>>
>> The metavariables are:
>> cluster =3D ceph (by default)
>> type =3D osd, mon, mds
>> id =3D 1, foo,
>> name =3D $type.$id =3D osd.0, mds.a, etc.
>>
>> The $cluster variable will come from the command line (--cluster foo=
) or,
>> in the case of a udev hotplug tool or something, matching the uuid o=
n the
>> device with the 'fsid =3D <uuid>' line in the available config files=
 found
>> in /etc/ceph.
>>
>> The locations could be:
>>
>> ceph config file:
>> =C2=A0/etc/ceph/$cluster.conf =C2=A0 =C2=A0 (default is thus ceph.co=
nf)
>>
>> keyring:
>> =C2=A0/etc/ceph/$cluster.keyring =C2=A0(fallback to /etc/ceph/keyrin=
g)
>>
>> osd_data, mon_data:
>> =C2=A0/var/lib/ceph/$cluster.$name
>> =C2=A0/var/lib/ceph/$cluster/$name
>> =C2=A0/var/lib/ceph/data/$cluster.$name
>> =C2=A0/var/lib/ceph/$type-data/$cluster-$id
>>
>> TV and I talked about this today, and one thing we want is for items=
 of a
>> given type to live together in separate directory so that we don't h=
ave to
>> do any filtering to, say, get all osd data directories. =C2=A0This s=
uggests the
>> last option (/var/lib/ceph/osd-data/ceph-1,
>> /var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.
>>
>> Another option would be to make it
>>
>> /var/lib/ceph/$type-data/$id
>>
>> (with no $cluster) and make users override the default with somethin=
g that
>> includes $cluster (or $fsid, or whatever) in their $cluster.conf if/=
when
>> they want multicluster nodes that don't interfere. =C2=A0Then we'd g=
et
>> /var/lib/ceph/osd-data/1 for non-crazy people, which is pretty easy.
>
> As a osd consists of data and the journal, it should stay together, w=
ith all info for that one osd in one place:
>
> I would suggest
>
> /var/lib/ceph/osd/$id/data
> and
> /var/lib/ceph/osd/$id/journal
>
> ($id could be replaced by $uuid or $name, for which I would prefer $u=
uid)
>
> Rgds,
> Bernard
>
>>
>> Any other suggestions? =C2=A0Thoughts?
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
