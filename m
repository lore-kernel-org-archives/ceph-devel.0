From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH]: set up rbd snapshot handling
Date: Wed, 11 Jan 2012 11:48:58 -0800
Message-ID: <CAF3hT9BTToQNCDg73VdRS8sL09mLP1rHYxV7ZYO3qpRXzLAsZQ@mail.gmail.com>
References: <CAF3hT9Cu0BZQfrgCpBRRaPHyfSy3V-A=jJLe3qGr4UoFMcniOQ@mail.gmail.com>
	<20120111100004.GA30381@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55400 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757795Ab2AKTtA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 14:49:00 -0500
Received: by ggdk6 with SMTP id k6so563213ggd.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2012 11:48:59 -0800 (PST)
In-Reply-To: <20120111100004.GA30381@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, stefanha@gmail.com

On Wed, Jan 11, 2012 at 1:58 AM, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> On Tue, Jan 10, 2012 at 8:01 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> +static int qemu_rbd_snap_remove(BlockDriverState *bs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con=
st char *snapshot_name)
>> +{
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0int r;
>> +
>> + =A0 =A0r =3D rbd_snap_remove(s->image, snapshot_name);
>> + =A0 =A0if (r < 0) {
>> + =A0 =A0 =A0 =A0error_report("failed to remove snap: %s", strerror(=
-r));
>> + =A0 =A0 =A0 =A0return r;
>
> There's no need to report an error message here. =A0This function sho=
uld
> return -errno and let the caller decide how to show the error to the
> user. =A0If you look at callers in the codebase they already print an
> equivalent error message.
>
> Stefan

Oh yep, guess I was a little too formulaic. Resend in a moment...

On Wed, Jan 11, 2012 at 2:00 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>> +static int qemu_rbd_snap_remove(BlockDriverState *bs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con=
st char *snapshot_name)
>> +{
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0int r;
>> +
>> + =A0 =A0r =3D rbd_snap_remove(s->image, snapshot_name);
>
>> + =A0 =A0r =3D rbd_snap_rollback(s->image, snapshot_name);
>
> Have these functions been available since day 1 in librbd or should t=
hey
> get a version checks like the cache flush call?

Day 1. :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
