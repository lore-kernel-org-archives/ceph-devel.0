From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Removing disks / OSDs
Date: Tue, 22 Oct 2013 10:15:53 +1300
Message-ID: <52659989.8070702@catalyst.net.nz>
References: <52655309.8070500@dachary.org>	<CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>	<52655CE6.9000203@dachary.org> <CAPYLRzjMR-4rf46OuQ46dt7Er+ebWhHuq=PFi0pcpFX45qcwdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:60371 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3JUVWI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 17:22:08 -0400
In-Reply-To: <CAPYLRzjMR-4rf46OuQ46dt7Er+ebWhHuq=PFi0pcpFX45qcwdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 22/10/13 06:17, Gregory Farnum wrote:
> On Mon, Oct 21, 2013 at 9:57 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>
>>
>> On 21/10/2013 18:49, Gregory Farnum wrote:
>>> I'm not quite sure what questions you're actually asking here...
>>
>> I guess I was asking if my understanding was correct.
>>
>>> In general, the OSD is not removed from the system without explicit
>>> admin intervention. When it is removed, all traces of it should be
>>> zapped (including its key), so it can't reconnect.
>>
>> Ok. So reusing osd ids is not an issue. If you reconnect a disk afte=
r osd rm the id it had, you get what you deserve and you can zap the di=
sk so that it is formated again. Is it what you mean ?
>
> I was actually under the impression that "osd rm" would, itself, clea=
r
> out the keys as well as the osd map state, but it does not do so. Tha=
t
> looks like a serious bug! http://tracker.ceph.com/issues/6605
> -Greg
>

=46WIW the docs here=20
http://ceph.com/docs/master/rados/operations/add-or-rm-osds/ say that=20
you need to do:

$ ceph osd crush remove osd.{osd.num}
$ ceph auth del osd.{osd-num}
$ ceph osd rm {osd-num}

Regards

>>
>>> If it hasn't been removed, then indeed it will continue working
>>> properly even if moved to a different box.
>>
>> Cool.
>>
>> That makes it real simple from the point of view of tools like puppe=
t :-)
>>
>> Cheers
>>
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>
>>>
>>> On Mon, Oct 21, 2013 at 9:15 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>> Hi Ceph,
>>>>
>>>> In the context of the ceph puppet module ( https://wiki.openstack.=
org/wiki/Puppet-openstack/ceph-blueprint ) I tried to think about what =
should be provided to deal with disks / OSDs when they are removed or m=
oved around.
>>>>
>>>> Here is a possible scenario:
>>>>
>>>> * Machine A dies and contains OSD 42
>>>> * ceph osd rm 42 is done to get rid of the OSD
>>>> * ceph-prepare is called on a new disk and gets OSD id 42
>>>>
>>>> ceph/src/mon/OSDMonitor.cc
>>>>
>>>>      // allocate a new id
>>>>      for (i=3D0; i < osdmap.get_max_osd(); i++) {
>>>>        if (!osdmap.exists(i) &&
>>>>            pending_inc.new_up_client.count(i) =3D=3D 0 &&
>>>>            (pending_inc.new_state.count(i) =3D=3D 0 ||
>>>>             (pending_inc.new_state[i] & CEPH_OSD_EXISTS) =3D=3D 0)=
)
>>>>          goto done;
>>>>      }
>>>>
>>>> * The disk of machine A is still good and is plugged into machine =
C
>>>> * the udev logic sees it has the ceph magic uuid and contains a we=
ll formed osd file system and runs the osd daemon on it. The osd daemon=
 fails and dies because its key does not match. It will try again and f=
ail in the same way when the machine reboots.
>>>>
>>>> If the osd id was not reused, the disk would find its way back in =
the cluster and be reused without manual intervention. Since ceph-disk =
uses the osd uuid to create the disk, it does not matter that it has be=
en removed : https://github.com/ceph/ceph/blob/master/src/ceph-disk#L45=
8 . I'm not sure to understand how the key that was previously register=
ed is re-imported. If I understand correctly it is created with ceph-os=
d --mkkey https://github.com/ceph/ceph/blob/master/src/ceph-disk#L1301 =
and stored in the osd tree at the location specified by --keyring https=
://github.com/ceph/ceph/blob/master/src/ceph-disk#L1307 .
>>>>
>>>> At this point my understanding is that (as long as OSD ids are not=
 reused), removing a disk or moving it from machine to machine, even ov=
er a long period of time does not require any action. The OSD id is an =
int which is probably large enough for any kind of cluster in the near =
future. The OSD ids that are not used and not removed could be cleaned =
from time to time to garbage collect the space they use.
>>>>
>>>> Please let me know if I've missed something :-)
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people =
do nothing.
>>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
