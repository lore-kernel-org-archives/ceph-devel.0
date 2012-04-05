From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: defaults paths
Date: Thu, 5 Apr 2012 11:37:43 +0400
Message-ID: <CABYiri9reZTxDTAchovCyuBT6x1OiZYgB72qj=YpzpnMD+WqJw@mail.gmail.com>
References: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net>
 <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be> <CABYiri_sVOpvbZnJ7rEBsrtDtW+qzo-vSyVLZjEa9gcv8j-+hA@mail.gmail.com>
 <51BE8674-B8FE-41D0-B284-6D99669CD4CA@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54725 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2DEHiG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 03:38:06 -0400
Received: by wgbdr13 with SMTP id dr13so1019022wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 00:38:03 -0700 (PDT)
In-Reply-To: <51BE8674-B8FE-41D0-B284-6D99669CD4CA@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

In ceph case, such layout breakage may be necessary in almost all
installations(except testing), comparing to almost all general-purpose
server software which need division like that only in very specific
setups.

On Thu, Apr 5, 2012 at 11:28 AM, Bernard Grymonpon <bernard@openminds.b=
e> wrote:
> I feel it's up to the sysadmin to mount / symlink the correct storage=
 devices on the correct paths - ceph should not be concerned that some =
volumes might need to sit together.
>
> Rgds,
> Bernard
>
> On 05 Apr 2012, at 09:12, Andrey Korolyov wrote:
>
>> Right, but probably we need journal separation at the directory leve=
l
>> by default, because there is a very small amount of cases when speed
>> of main storage is sufficient for journal or when resulting speed
>> decrease is not significant, so journal by default may go into
>> /var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
>> the fast disk.
>>
>> On Thu, Apr 5, 2012 at 10:57 AM, Bernard Grymonpon <bernard@openmind=
s.be> wrote:
>>>
>>> On 05 Apr 2012, at 08:32, Sage Weil wrote:
>>>
>>>> We want to standardize the locations for ceph data directories, co=
nfigs,
>>>> etc. =C2=A0We'd also like to allow a single host to run OSDs that =
participate
>>>> in multiple ceph clusters. =C2=A0We'd like easy to deal with names=
 (i.e., avoid
>>>> UUIDs if we can).
>>>>
>>>> The metavariables are:
>>>> cluster =3D ceph (by default)
>>>> type =3D osd, mon, mds
>>>> id =3D 1, foo,
>>>> name =3D $type.$id =3D osd.0, mds.a, etc.
>>>>
>>>> The $cluster variable will come from the command line (--cluster f=
oo) or,
>>>> in the case of a udev hotplug tool or something, matching the uuid=
 on the
>>>> device with the 'fsid =3D <uuid>' line in the available config fil=
es found
>>>> in /etc/ceph.
>>>>
>>>> The locations could be:
>>>>
>>>> ceph config file:
>>>> =C2=A0/etc/ceph/$cluster.conf =C2=A0 =C2=A0 (default is thus ceph.=
conf)
>>>>
>>>> keyring:
>>>> =C2=A0/etc/ceph/$cluster.keyring =C2=A0(fallback to /etc/ceph/keyr=
ing)
>>>>
>>>> osd_data, mon_data:
>>>> =C2=A0/var/lib/ceph/$cluster.$name
>>>> =C2=A0/var/lib/ceph/$cluster/$name
>>>> =C2=A0/var/lib/ceph/data/$cluster.$name
>>>> =C2=A0/var/lib/ceph/$type-data/$cluster-$id
>>>>
>>>> TV and I talked about this today, and one thing we want is for ite=
ms of a
>>>> given type to live together in separate directory so that we don't=
 have to
>>>> do any filtering to, say, get all osd data directories. =C2=A0This=
 suggests the
>>>> last option (/var/lib/ceph/osd-data/ceph-1,
>>>> /var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.
>>>>
>>>> Another option would be to make it
>>>>
>>>> /var/lib/ceph/$type-data/$id
>>>>
>>>> (with no $cluster) and make users override the default with someth=
ing that
>>>> includes $cluster (or $fsid, or whatever) in their $cluster.conf i=
f/when
>>>> they want multicluster nodes that don't interfere. =C2=A0Then we'd=
 get
>>>> /var/lib/ceph/osd-data/1 for non-crazy people, which is pretty eas=
y.
>>>
>>> As a osd consists of data and the journal, it should stay together,=
 with all info for that one osd in one place:
>>>
>>> I would suggest
>>>
>>> /var/lib/ceph/osd/$id/data
>>> and
>>> /var/lib/ceph/osd/$id/journal
>>>
>>> ($id could be replaced by $uuid or $name, for which I would prefer =
$uuid)
>>>
>>> Rgds,
>>> Bernard
>>>
>>>>
>>>> Any other suggestions? =C2=A0Thoughts?
>>>> sage
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
