From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 17:39:35 +0000
Message-ID: <09ad1f6790ff4860b364c49b2a28269f@R01UKEXCASM115.r01.fujitsu.local>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <56FD4FEC.4060000@mirantis.com>
 <CY1PR0201MB1897E7C6A58679883F375F60E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56FD5BE0.4040801@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.150]:21211 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753225AbcCaRqZ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Mar 2016 13:46:25 -0400
In-Reply-To: <56FD5BE0.4040801@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Igor Fedotov
> Sent: Thursday, March 31, 2016 7:18 PM
>=20
> On 31.03.2016 19:32, Allen Samuels wrote:
> >> But do we really need to store checksums as metadata? What's about
> >> pre(post)fixing 4K-4(?) blob with the checksum and store this pair=
 to
> >> the disk. IMO we always need checksum values along with blob data
> >> thus let's store and read them together. This immediately eliminat=
es
> >> the question about the granularity and corresponding overhead... H=
ave
> >> I missed something?
> > If you store them inline with the data then nothing lines up on bou=
ndaries
> that the HW designers expect and you end up doing things like extra-c=
opying
> of every data buffer. This will kill performance.
>=20
> Perhaps you are right.
>=20
> But not sure I fully understand what HW designers you mean here. Are =
you
> considering the case when Ceph is embedded into some hardware and
> incoming RW requests  always operate aligned data and supposed to hav=
e
> the same alignment for data saved to disk?

> IMHO proper data alignment in the incoming requests is a particular
> case. Generally we don't have such a trait. Moreover compression
> completely destroys it if any. Thus in many cases we can easily appen=
d
> an additional data portion containing a checksum.

Devices - in general - store data in sectors (or blocks) of particular =
sizes, with 512 bytes for most HDDs and 4096 bytes for many SSDs and ma=
ny large capacity HDDs ("advanced-format", as one company calls it). Fo=
r that reason, when you're doing direct I/O, you read/write in multiple=
s of those sectors/blocks, and anything below that will result in bad p=
erformance because you need to read entire sector anyway (no way to do =
partial-sector read), discard any unnecessary data and realign to match=
 destination (or pad buffer with some value and write entire value, whi=
ch means you need copy data from caller into that temp buffer before do=
ing write).=20
Putting checksum in front of data will prevent direct-to-destination re=
ads (i.e. read(..dest, 4096)) and zero-copy write, because front of des=
t will contain checksum - you'll need to read into temp buffer, move ch=
ecksum into its storage and move actual data to destination which means=
 read and up to two memmoves. If you'll put checksum *past* data, you c=
an read data directly into dest buffer, but you need to make sure that =
dest buffer is sizeof(checksum) larger than consumer expects and finall=
y move checksum somewhere else -- better, but bug-prone.
Having checksums in separate storage may incur extra I/O (as Allen wrot=
e), but removes both issues mentioned.

With best regards / Pozdrawiam
Piotr Da=B3ek

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
