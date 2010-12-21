From: Sassy Natan <sassyn@gmail.com>
Subject: Re: v0.24 released
Date: Tue, 21 Dec 2010 10:46:31 +0200
Message-ID: <AANLkTik91T8uLte6eYcpo-eq2ikPQJ-gxrHdu060GiWz@mail.gmail.com>
References: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
 <AANLkTikz3=Zbf09F9brLcT2FxWyVwOFq+oVRgaszHsoa@mail.gmail.com> <1292920563.2297.2.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:57818 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab0LUIqx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 03:46:53 -0500
Received: by fxm18 with SMTP id 18so4030442fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 00:46:52 -0800 (PST)
In-Reply-To: <1292920563.2297.2.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Ravi Pinjala <pstatic@gmail.com>, ceph-devel@vger.kernel.org

Wido,
It depend if the libcrypto++X is not hard coded in the control file.

If not, and the control file is dynamically built, then the build will =
be fine
if yes, please grep all file under the Debian folder to see if u have
the libcrypto++7 hard coded somewhere then rebuild as Wido suggested.

Sassy

On Tue, Dec 21, 2010 at 10:36 AM, Wido den Hollander <wido@widodh.nl> w=
rote:
> Hi Ravi,
>
> Indeed, Ubuntu 10.10 has the libcrypto++8 package, but you could alwa=
ys
> build from the source, not that hard.
>
> apt-get install dpkg-dev
> git clone git://ceph.newdream.net/git/ceph.git
> cd ceph
> git checkout -b rc origin/rc
> dpkg-buildpackage
>
> It will then need some dependencies, just install those. Afterwards y=
ou
> should end up with a few nice .deb files!
>
> Wido
>
> On Mon, 2010-12-20 at 21:15 -0800, Ravi Pinjala wrote:
>> The debian package doesn't install on ubuntu 10.10 - it depends on
>> libcrypto++7, which seems not to be available anymore. (Makes me mis=
s
>> Gentoo :( )
>>
>> --Ravi
>>
>> On Mon, Dec 20, 2010 at 6:28 PM, Sage Weil <sage@newdream.net> wrote=
:
>> > We've released v0.24, just in time for the holidays! =A0Big change=
s this
>> > time around include:
>> >
>> > =A0* mds: many fixes with clustered failure recovery
>> > =A0* mds: bloom filter to reduce directory reads
>> > =A0* mds: configurable directory hash functions (for fragmentation=
)
>> > =A0* rbd: import/export tools are smart about holes (i.e., use FIE=
MAP)
>> > =A0* osd: many recovery improvements, mostly making data available=
 more
>> > =A0 quickly
>> > =A0* osd: automatic background scrubbing when load is low
>> > =A0* osd: fixes with dedicated backend replication network
>> > =A0* osd: use new (2.6.37) btrfs ioctls for async snapshot creatio=
n
>> > =A0* replaced openssl dependency with libcrypto++ (licensing issue=
)
>> > =A0* librados: "zero-copy" reads
>> > =A0* misc bug fixes, man pages, and code cleanup
>> >
>> > The focus for the next release (v0.25) is on OSD and MDS stability=
,
>> > directory fragmentation recovery, and fsck preliminaries; see the =
roadmap
>> > for more details.
>> >
>> > Relevant URLs:
>> > =A0* Direct download at: http://ceph.newdream.net/download/ceph-0.=
24.tar.gz
>> > =A0* For Debian packages, see http://ceph.newdream.net/wiki/Debian
>> >
>> > sage
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
