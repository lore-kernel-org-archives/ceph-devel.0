From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Ceph Write Path Improvement
Date: Thu, 10 Sep 2015 11:20:53 -0600
Message-ID: <CAANLjFpK8GSizQuQ9nJqV61bXrwSQ4sWg=jyD9_aDK1ChddXQg@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE354DD@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAANLjFpmO+rGnEFM5+u6piVoa4YqvoVCcTWjYOQJ2cXEEk7T-g@mail.gmail.com>
	<55E87862.5060809@redhat.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE36FF9@SACMBXIP01.sdcorp.global.sandisk.com>
	<3649A15A2562B54294DE14BCE5AC79120B5AEB14@FMSMSX119.amr.corp.intel.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE4108F@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36237 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbIJRUz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 13:20:55 -0400
Received: by vkfp126 with SMTP id p126so12967512vkf.3
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 10:20:54 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE4108F@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

This is great work. Thanks for sharing. I'm looking forward to the
resolution of the scale out issues!
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Sep 9, 2015 at 6:33 PM, Somnath Roy  wrote:
> Hi,
> Here is the updated presentation we discussed in the performance meet=
ing today with performance data incorporated for the scenario where bot=
h journal/data on the same SSD.
>
> https://docs.google.com/presentation/d/15-Uqk0b4s1fVV1cG1G6Kba9xafcnI=
oLvfq8LUY7KBL0/edit#slide=3Did.p4
>
>
> Here is the summary:
> --------------------------
>
> For 4K :
> =E2=80=93       ~2.5X IOPs improvement, ~2.68X latency improvement wi=
th NVRAM as journal
> =E2=80=93       ~2.2X IOPS improvement, ~2.3X latency improvement  wi=
thout NVRAM as journal
> =E2=80=93       More stable performance with NVRAM as journal
> For 16K:
> =E2=80=93       ~2.3X IOPS improvement, ~2.47X latency improvement wi=
th NVRAM as journal
> =E2=80=93       ~1.9X IOPS improvement, ~2X latency improvement  with=
out NVRAM as journal
> =E2=80=93       More stable performance with NVRAM as journal
> For 64K:
> =E2=80=93       ~2X BW improvement, ~2X latency improvement with NVRA=
M as journal
> =E2=80=93       ~1.5X BW improvement, ~1.5X latency improvement  with=
out NVRAM as journal
> =E2=80=93       More stable performance with NVRAM as journal
> For 4M:
> =E2=80=93       ~1.5X BW improvement, ~1.6X latency improvement with =
NVRAM as journal
> =E2=80=93       ~1.1X BW improvement, ~1.2X latency improvement  with=
out NVRAM as journal
>
> For Mixed workload:
> ------------------------
> QD =3D 8 :
>         ~1.6X IOPs improvement, ~1.6X latency improvement with NVRAM =
as journal
>         ~1.5X IOPs improvement, ~1.5X latency improvement without NVR=
AM as journal
>         More stable performance with NVRAM as journal
>
> QD =3D 80 :
>         ~2.7X IOPs improvement, ~2.8X latency improvement with NVRAM =
as journal
>         ~2.4X IOPs improvement, ~2.5X latency improvement without NVR=
AM as journal
>         More stable performance with NVRAM as journal
>
> Will try to send out a pull request by next week.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, September 03, 2015 1:06 PM
> To: 'Blinick, Stephen L'
> Cc: ceph-devel
> Subject: RE: Ceph Write Path Improvement
>
> Stephen,
> It's a 1 RBD volume (preconditioned) of 2 TB size from one physical c=
lient box.
> fio-rbd script I am running with 10 jobs and each with 64 QD.
> For mixed workload it is with QD =3D 8 and num_job=3D 1 and 10.
>
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Blinick, Stephen L [mailto:stephen.l.blinick@intel.com]
> Sent: Thursday, September 03, 2015 1:02 PM
> To: Somnath Roy
> Cc: ceph-devel
> Subject: RE: Ceph Write Path Improvement
>
> Somnath -- thanks for publishing all the data, will be great to look =
at it offline.  I didn't find this info:  How many RBD volumes, and wha=
t size, did you use for your mixed tests?  Was it just one RBD w/ num_j=
obs=3D1 & 10?  Also how many client systems were necessary to drive the=
 workload on the 4 storage nodes?
>
> I saw the same behavior quite a while back when playing with ramdisk =
journal... Not a lot of improvement.
>
> Thanks,
>
> Stephen
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Somnath Roy
> Sent: Thursday, September 3, 2015 10:42 AM
> To: Mark Nelson; Robert LeBlanc
> Cc: ceph-devel
> Subject: RE: Ceph Write Path Improvement
>
> Yes, As Mark said I will collect all the data and hopefully I can pre=
sent in the next performance meeting.
> BTW, I have tested with Hammer code base + NvRAM journal initially, b=
ut that performance is very spiky with ~10% performance gain (at max). =
I thought there is no point of collecting more data with that config.
> That's why I have introduced a new throttling scheme that should bene=
fit in all the scenarios.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, September 03, 2015 9:42 AM
> To: Robert LeBlanc; Somnath Roy
> Cc: ceph-devel
> Subject: Re: Ceph Write Path Improvement
>
> On 09/03/2015 11:23 AM, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> Somnath,
>>
>> I'm having a hard time with your slide deck. Am I understanding
>> correctly that the default Hammer install was performed on SSDs with
>> co-located journals, but the optimized code was performed on the sam=
e
>> SSDs but the journal was in NVRAM? If so I'm having a hard time
>> understanding how these tests can be comparable. I really like the
>> performance gains you are seeing, but I'm trying to understand how
>> much the optimized code alone helps performance.
>
> Hi Robert,
>
> We talked about this a bit at the weekly performance meeting.  I thin=
k Somnath just hasn't gotten a chance to do those tests yet and is plan=
ning on doing them in the coming weeks.  I believe he started out with =
hammer on the SSDs and then tried to figure out how to tweak things to =
make the NVRAM configuration perform better.  Now he has to go back and=
 retest the original configuration but with the new code.
>
> Mark
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
>    =EC=B9=BB  & ~ &    +-  =DD=B6   w  =CB=9B   m    ^  b  ^n r   z  =
  h    &    G   h  ( =E9=9A=8E =DD=A2j"     m     z =DE=96   f   h   ~ =
m

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV8bvwCRDmVDuy+mK58QAAii0QAJRExHq2QlmLwI7rOD8K
JeXJ+rWJlP6CluRmuS3nN2UwT+hwxzzokyA4vzqhe0lvQkiiVPKXnuSp3hlo
U6uPjSigR0XwXdXq8nlIr51lXByB7/dbWUu62HORgi350nY1I2NzLDLUo8Hx
qxBrC4ZkH/h2+pfU2ann5nOBqe/0EM0NlbI0VQUvCo3M5il5GbqVWq/ZHDKj
LnrQtiz/QEWhq0xnJWdYlhFzkpGGNszdoHCzmSL/oGDbEpzDp6RxjF4YB1e8
Cf1xTDwmdZf3SJKKVsPbpmWG8/F3O6PKf4sbbWdo20DBYmrBbnpFWtJEr6q0
TKr2bXycSza7TNhoBNR+TGVyDuHDxnpMGneIN/NtVffwHn5dASPvveC2Y2OE
fRWccfDeaEXESfrwzMPWFk1n+ty6hpLvClyQaXenb2POmSSJ3VN9kxye8x0U
/7DiwJNWj1YaIgWGlpbOmQSWX2/PrI++MNRIB7ck0O1LG7ERhPUwdgYRahZ7
ImN8JfvOdUb7b160hdRAKpepNElfAeIkJKRlC6+6mZsOqw53Oa0MZtYMSzwU
3VbwBeJWqUS9itGCkqITNhtikdfKdWzIcwAGRPDFPqLqXWBs1twstN/ScPBa
fWDSbSjoi09LTAIsXrnLta44QZwuQDhEWUEhUcidtIbaD1t4kbCeGC+TKuA8
VluX
=3D/0NL
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
