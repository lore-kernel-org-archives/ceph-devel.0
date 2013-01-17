From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph from poc to production
Date: Thu, 17 Jan 2013 19:59:12 +0100
Message-ID: <E0AC2FCA-6970-4D1C-BFBB-CFFADFDEF06D@profihost.ag>
References: <50F6F471.7030108@profihost.ag> <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:49967 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab3AQS7P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 13:59:15 -0500
In-Reply-To: <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thx!

Am 17.01.2013 um 17:24 schrieb S=C3=A9bastien Han <han.sebastien@gmail.=
com>:

> Hi Stephan,
>=20
>> - Increase the osdmax value
>=20
> Well actually this doesn't seem to be necessary because when you issu=
e
> a "ceph osd create" the osdmax value is automatically incremented. It
> just that a while ago I saw on the ML or IRC that it was a good
> practice to do this. And this documentation
> http://ceph.com/docs/master/rados/operations/control/ says:
>=20
> "Set the max_osd parameter in the osd map. This is necessary when
> expanding the storage cluster."
>=20
> Maybe the doc is outdated on this option, I don't know.
>=20
>> - Set =E2=80=9Cfilestore flusher=E2=80=9D option to false, in your [=
osd] section
>=20
> During my benchmarks sessions I noticed that disabling this option
> brought way better performance, at least for old hardware. Fo recent
> hardware I haven't seen any difference, but I kept the habit to
> disable it. There are some discussions about this option on the ML. A=
s
> far as I can remember, it's harmless to disable it.
> From the doc here
> http://ceph.com/docs/master/rados/configuration/filestore-config-ref/=
:
>=20
> "The filestore flusher forces data from large writes to be written ou=
t
> using sync file range before the sync in order to (hopefully) reduce
> the cost of the eventual sync. In practice, disabling =E2=80=98filest=
ore
> flusher=E2=80=99 seems to improve performance in some cases."
>=20
> Cheers,
>=20
> --
> Regards,
> S=C3=A9bastien Han.
>=20
>=20
> On Wed, Jan 16, 2013 at 7:41 PM, Stefan Priebe <s.priebe@profihost.ag=
> wrote:
>>=20
>> Hello Sebastien,
>>  hello list,
>>=20
>> first nice article sebastien ;-) thanks for contributing.
>>=20
>> I've two question regarding the tips:
>>=20
>> Can somebody explain me why i should do this?:
>> - Increase the osdmax value
>> - Set =E2=80=9Cfilestore flusher=E2=80=9D option to false, in your [=
osd] section
>>=20
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
