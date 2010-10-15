From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v6)
Date: Thu, 14 Oct 2010 17:30:21 -0700
Message-ID: <AANLkTi=r+CAz2UF=e-FaC-zdy1ct_Qj2-2SG8vEKTMm0@mail.gmail.com>
References: <20101012231854.GA4535@dell.home>
	<4CB4E7C3.8090908@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51664 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0JOAaX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Oct 2010 20:30:23 -0400
In-Reply-To: <4CB4E7C3.8090908@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

See my comments below, updated patch will follow later:

On Tue, Oct 12, 2010 at 3:57 PM, Anthony Liguori <anthony@codemonkey.ws=
> wrote:
=2E..
>> +
>> +static int rbd_parsename(const char *filename, char *pool, char **s=
nap,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *name)
>> +{
>> + =A0 =A0const char *rbdname;
>> + =A0 =A0char *p;
>> + =A0 =A0int l;
>> +
>> + =A0 =A0if (!strstart(filename, "rbd:",&rbdname)) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
>>
>
> Passing strings that are expected to be of a certain size is usually =
bad
> form. =A0Probably better to pass in the capacity of pool as an additi=
onal
> argument.

Yep. Rewrote the function, now gets explicit buffer size for each param=
=2E

>
> The limits are really weird here. =A0 Is this a RBD limit or just an =
internal
> thing?

These are the limits that are used elsewhere for rbd.

>
> So snap ends up pointing to a substring in name? =A0This memory alloc=
ation is
> super frail. =A0I'd suggest rewriting this to make it more robust suc=
h that
> all the strings had clear allocation life cycles. =A0I'd be amazed if=
 you
> didn't have an overflow/leak today.

=46ixed that, was a bad practice.

>> + =A0 =A0*id =3D out[0];
>> + =A0 =A0le64_to_cpus(out);
>>
>
> You're doing the assignment of the return value before you actually d=
o the
> endian conversion.

=46ixed.

>> +
>> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX=
);
>>
>>
>
> sizeof(n) is more defensive.

Changed all of these.

>> + =A0 =A0do {
>> + =A0 =A0 =A0 =A0if ((ret =3D read(s->fds[RBD_FD_READ],&rcb, sizeof(=
rcb)))> =A00) {
>>
>
> This is sufficiently exotic that it needs a comment. =A0I think most =
people's
> first reaction is that the code is a bug and that it should be 'rcb,
> sizeof(*rcb)'. =A0Passing pointers over a socket is unusual.

Added a comment.

>> +
>> + =A0 =A0return;
>>
>
> The return is unnecessary.

Yeah.

>> + =A0 =A0r =3D rados_stat(s->header_pool, n,&len, NULL);
>> + =A0 =A0if (r< =A00)
>> + =A0 =A0 =A0 =A0goto failed;
>>
>
> Missing {}s here and many other places. =A0Please make sure you're fo=
llowing
> CODING_STYLE.
=46ixed these and some others.

>> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char *snap;
>> + =A0 =A0char *hbuf =3D NULL;
>> + =A0 =A0int r;
>> +
>> + =A0 =A0if (rbd_parsename(filename, pool,&snap, s->name)< =A00) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>>
>
> In rbd_parsename() you assume pool is 2*RBD_MAX_SEG_NAME_SIZE and her=
e it's
> only RBD_MAX_SEG_NAME_SIZE.

No more such an assumption. pool is only RBD_MAX_SEG_NAME_SIZE.

>> + =A0 =A0if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
>> + =A0 =A0 =A0 =A0error_report("Unknown image version %s", hbuf + 68)=
;
>> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
>> + =A0 =A0 =A0 =A0goto failed;
>> + =A0 =A0}
>>
>
> Is strncmp really the right function as opposed to memcmp?

Changed to memcpy.

>> + =A0 =A0fcntl(s->fds[0], F_SETFL, O_NONBLOCK);
>> + =A0 =A0fcntl(s->fds[1], F_SETFL, O_NONBLOCK);
>>
>
> You set this to be O_NONBLOCK but in rbd_aio_event_reader you're not
> gracefully handling EAGAIN and partial reads.

Handling EAGAIN now for both reads and writes.

>> + =A0 =A0RbdHeader1 *header;
>> +
>> + =A0 =A0header =3D (RbdHeader1 *) hbuf;
>>
>
> Mixing variable definitions with code (didn't I mention this in the l=
ast
> review?).

I believe you did. Fixed it now.

>> + =A0 =A0while (1) {
>> + =A0 =A0 =A0 =A0qemu_free(outbuf);
>> + =A0 =A0 =A0 =A0outbuf =3D qemu_malloc(len);
>> +
>> + =A0 =A0 =A0 =A0r =3D rados_exec(s->header_pool, n, "rbd", "snap_li=
st", NULL, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outbuf, len);
>> + =A0 =A0 =A0 =A0if (r< =A00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0error_report("rbd.snap_list execution faile=
d failed: %s",
>> strerror(-r));
>> + =A0 =A0 =A0 =A0 =A0 =A0return r;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0if (r !=3D len)
>> + =A0 =A0 =A0 =A0 =A0 =A0break;
>> +
>> + =A0 =A0 =A0 =A0len *=3D 2;
>> + =A0 =A0}
>>
>
> Is this really the only way to figure out how large the buffer should=
 be??

This is the easiest way. Was trying to avoid reading the rbd header
explicitly for that. Now reading size information from the header, so
that we have an educated guess at what the size would be, however,
this is racy and we'll still loop in case the buffer was too small
(e.g., size was changed after reading the header).

>> +struct rbd_obj_header_ondisk {
>> + =A0 =A0char text[40];
>> + =A0 =A0char block_name[RBD_MAX_BLOCK_NAME_SIZE];
>> + =A0 =A0char signature[4];
>> + =A0 =A0char version[8];
>> + =A0 =A0struct {
>> + =A0 =A0 =A0 =A0uint8_t order;
>> + =A0 =A0 =A0 =A0uint8_t crypt_type;
>> + =A0 =A0 =A0 =A0uint8_t comp_type;
>> + =A0 =A0 =A0 =A0uint8_t unused;
>> + =A0 =A0} __attribute__((packed)) options;
>> + =A0 =A0uint64_t image_size;
>> + =A0 =A0uint64_t snap_seq;
>> + =A0 =A0uint32_t snap_count;
>> + =A0 =A0uint32_t reserved;
>> + =A0 =A0uint64_t snap_names_len;
>> + =A0 =A0struct rbd_obj_snap_ondisk snaps[0];
>> +} __attribute__((packed));
>> +
>> +
>> +#endif
>>
>
> These types don't match QEMU CODING_STYLE.
>

Might be, however, we also sync this file in two other projects that
have other coding style. It'd be easier for us to keep it as is.


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
