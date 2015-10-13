From: Jeremy Hanmer <jeremy.hanmer@dreamhost.com>
Subject: Re: pre-Infernalis ceph-disk bug
Date: Tue, 13 Oct 2015 15:51:59 -0700
Message-ID: <CAKRUTFBKhAr+K1Nt-fRmv3d3fwVH9PQxK27gP--zEcaT78OFmg@mail.gmail.com>
References: <CAKRUTFCOucYJL-fqNoSA69V6ACjNNEr4hTskmcv=H1v+XSsoFA@mail.gmail.com>
	<561D8646.9050404@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36832 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbJMWwA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 18:52:00 -0400
Received: by qkht68 with SMTP id t68so15435893qkh.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 15:52:00 -0700 (PDT)
In-Reply-To: <561D8646.9050404@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Cool, I'll try to clean things up and submit a PR (probably one for
<Infernalis and one for Infernalis, assuming it's still broken).

I'm 99% certain I ruled out any udev silliness by throwing a bunch of
settle calls every place I thought might make some theoretical sense.
No number of those calls ever resulted in a properly functioning
partprobe call.

On Tue, Oct 13, 2015 at 3:31 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> On 14/10/2015 00:02, Jeremy Hanmer wrote:
>> I think I've found a bug in ceph-disk when running on Ubuntu 14.04
>> (and I believe 12.04 as well, but haven't confirmed) and using
>> --dmcrypt.
>>
>> The problem is that when update_partition() is called, partprobe is
>> used to re-read the partition table (as opposed to partx on all othe=
r
>> distros) and it appears that it isn't smart/thorough enough to updat=
e
>> all of the device's metadata. Specifically, ID_PART_ENTRY_TYPE isn't
>> updated:
>>
>> root@ceph-osd03:~# udevadm info --query=3Denv --name=3D/dev/vdd1 | g=
rep
>> ID_PART_ENTRY_TYPE
>> ID_PART_ENTRY_TYPE=3D89c57f98-2fe5-4dc0-89c1-5ec00ceff2be
>>
>> running `partx -u` rather than `partprobe` does the appropriate thin=
g:
>>
>> root@ceph-osd03:~# partx -u /dev/vdd1
>> root@ceph-osd03:~# udevadm info --query=3Denv --name=3D/dev/vdd1 | g=
rep
>> ID_PART_ENTRY_TYPE
>> ID_PART_ENTRY_TYPE=3D4fbd7e29-9d25-41b8-afd0-5ec00ceff05d
>>
>>
>> I have an experimental patch here that Works For Me, but Sage wanted
>> me to ping the list for input:
>>
>> https://github.com/fzylogic/ceph/commit/8c83f75392d68fbec7def8aa61f2=
0b2c9c237571
>>
>>
>> I also want to test the new Infernalis code for this same bug (after=
 a
>> cursory check, I strongly suspect it's there as well), but it'll tak=
e
>> a little bit to get another test cluster up to confirm.
>
> There has been many changes in infernalis, most of them to make it mo=
re robust. It would be great if you could try to reproduce the problem =
you had with infernalis.
>
> Your patch looks good and you could also remove https://github.com/fz=
ylogic/ceph/blob/8c83f75392d68fbec7def8aa61f20b2c9c237571/src/ceph-disk=
#L1505 which will happen immediately after the function returns.
>
> An alternate fix would be to udevadm settle before https://github.com=
/fzylogic/ceph/blob/8c83f75392d68fbec7def8aa61f20b2c9c237571/src/ceph-d=
isk#L985 and after it to avoid races. I think the reason why partprobe =
does not appear to work is because it triggers udev events that race wi=
th udev events triggered by sgdisk while creating the partition.
>
> Cheers
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
