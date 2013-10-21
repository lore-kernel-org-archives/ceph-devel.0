From: Gregory Farnum <greg@inktank.com>
Subject: Re: Removing disks / OSDs
Date: Mon, 21 Oct 2013 10:17:20 -0700
Message-ID: <CAPYLRzjMR-4rf46OuQ46dt7Er+ebWhHuq=PFi0pcpFX45qcwdA@mail.gmail.com>
References: <52655309.8070500@dachary.org>
	<CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>
	<52655CE6.9000203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35903 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3JURRW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 13:17:22 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so6762834wgg.28
        for <ceph-devel@vger.kernel.org>; Mon, 21 Oct 2013 10:17:21 -0700 (PDT)
In-Reply-To: <52655CE6.9000203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 21, 2013 at 9:57 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 21/10/2013 18:49, Gregory Farnum wrote:
>> I'm not quite sure what questions you're actually asking here...
>
> I guess I was asking if my understanding was correct.
>
>> In general, the OSD is not removed from the system without explicit
>> admin intervention. When it is removed, all traces of it should be
>> zapped (including its key), so it can't reconnect.
>
> Ok. So reusing osd ids is not an issue. If you reconnect a disk after=
 osd rm the id it had, you get what you deserve and you can zap the dis=
k so that it is formated again. Is it what you mean ?

I was actually under the impression that "osd rm" would, itself, clear
out the keys as well as the osd map state, but it does not do so. That
looks like a serious bug! http://tracker.ceph.com/issues/6605
-Greg

>
>> If it hasn't been removed, then indeed it will continue working
>> properly even if moved to a different box.
>
> Cool.
>
> That makes it real simple from the point of view of tools like puppet=
 :-)
>
> Cheers
>
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Mon, Oct 21, 2013 at 9:15 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Ceph,
>>>
>>> In the context of the ceph puppet module ( https://wiki.openstack.o=
rg/wiki/Puppet-openstack/ceph-blueprint ) I tried to think about what s=
hould be provided to deal with disks / OSDs when they are removed or mo=
ved around.
>>>
>>> Here is a possible scenario:
>>>
>>> * Machine A dies and contains OSD 42
>>> * ceph osd rm 42 is done to get rid of the OSD
>>> * ceph-prepare is called on a new disk and gets OSD id 42
>>>
>>> ceph/src/mon/OSDMonitor.cc
>>>
>>>     // allocate a new id
>>>     for (i=3D0; i < osdmap.get_max_osd(); i++) {
>>>       if (!osdmap.exists(i) &&
>>>           pending_inc.new_up_client.count(i) =3D=3D 0 &&
>>>           (pending_inc.new_state.count(i) =3D=3D 0 ||
>>>            (pending_inc.new_state[i] & CEPH_OSD_EXISTS) =3D=3D 0))
>>>         goto done;
>>>     }
>>>
>>> * The disk of machine A is still good and is plugged into machine C
>>> * the udev logic sees it has the ceph magic uuid and contains a wel=
l formed osd file system and runs the osd daemon on it. The osd daemon =
fails and dies because its key does not match. It will try again and fa=
il in the same way when the machine reboots.
>>>
>>> If the osd id was not reused, the disk would find its way back in t=
he cluster and be reused without manual intervention. Since ceph-disk u=
ses the osd uuid to create the disk, it does not matter that it has bee=
n removed : https://github.com/ceph/ceph/blob/master/src/ceph-disk#L458=
 . I'm not sure to understand how the key that was previously registere=
d is re-imported. If I understand correctly it is created with ceph-osd=
 --mkkey https://github.com/ceph/ceph/blob/master/src/ceph-disk#L1301 a=
nd stored in the osd tree at the location specified by --keyring https:=
//github.com/ceph/ceph/blob/master/src/ceph-disk#L1307 .
>>>
>>> At this point my understanding is that (as long as OSD ids are not =
reused), removing a disk or moving it from machine to machine, even ove=
r a long period of time does not require any action. The OSD id is an i=
nt which is probably large enough for any kind of cluster in the near f=
uture. The OSD ids that are not used and not removed could be cleaned f=
rom time to time to garbage collect the space they use.
>>>
>>> Please let me know if I've missed something :-)
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people d=
o nothing.
>>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
