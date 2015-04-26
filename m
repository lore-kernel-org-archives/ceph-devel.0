From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 10:28:50 -0400
Message-ID: <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbbDZO25 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 10:28:57 -0400
In-Reply-To: <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Alex,

I think you are correct in both your understanding and your impression =
of the approach.

> On Apr 26, 2015, at 4:44 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Sun, Apr 26, 2015 at 9:29 AM, Alex Elder <elder@ieee.org> wrote:
>> On 04/24/2015 08:22 AM, Douglas Fuller wrote:
>>>=20
>>> Support multiple class op calls in one ceph_msg and consolidate rbd=
 header
>>> read and refresh processes to use this feature to reduce the number=
 of
>>> ceph_msgs sent for that process. Refresh features on header refresh=
 and
>>> begin returning EIO if features have changed since mapping.
>>=20
>> This sounds pretty expensive.  For every class operation
>> you are copying the received data two extra times.

I=E2=80=99d really like a solution to this, but I don=E2=80=99t think o=
ne is available given the constraints.

>> Will you please correct me where I'm wrong above, and
>> maybe give a little better high-level explanation of
>> what you're trying to do?  I see in patch 1 you mention
>> a problem with short reads, and there may be a simpler
>> fix than that (to begin with).  But beyond that, if
>> you're trying to incorporate more ops in a message,
>> there may be better ways to go about that as well.
>=20
> Yeah, the only objective of this was to pack more call ops into an
> osd_request in order to reduce the number of network RTs during rbd m=
ap
> and refresh.  The fundamental problem the first patch is trying to wo=
rk
> around is the first ceph_msg_data item consuming all reply buffers
> instead of just its own.  We have to preallocate response buffers and
> if the preallocated response buffer for the first op is large enough
> (it always is) it will consume the entire ceph_msg, along with replie=
s
> to other ops.
>=20
> My understanding is that the first patch is supposed to be a specific
> workarond for just that - I think it's noted somewhere that it will
> break on reads combined with call ops or similar.

That=E2=80=99s correct. This patch only works around that short respons=
e issue in this specific corner case. It does not fix cases where call =
ops returning data could be arbitrarily combined with reads or writes (=
and apparently they never have been, because that would not work). It s=
hould not introduce additional cases of breakage, though.

I was told that the preferred way to proceed for now was to avoid chang=
ing the osd_client interface and to handle this case in osd_client inst=
ead of the messaging layer. Given those constraints, it was agreed in t=
he standups and on #ceph-devel that it should be done this way.

We can=E2=80=99t know the actual response sizes until they are decoded =
in osd_client. Therefore, we can=E2=80=99t copy them directly to the us=
er buffers off the wire. That costs us one extra copy. The other copy i=
s required because pagevec.c does not provide an interface for copying =
arbitrary data between two page vectors.

> I too have my efficiency concerns and I raised them in one of the
> standups but the argument was that this is only going to be used for
> header init/refresh, not copyup, so the overhead is negligible.  I'm
> still not sold on the copying everything twice though and was going t=
o
> try to see if there is a simple way to special case this even more an=
d
> make the diffstat smaller.

You and I agreed in that particular standup discussion; I don=E2=80=99t=
 like it, either. I would prefer a general-case solution that avoids in=
troducing so much extra overhead, especially for such a small amount of=
 data (really just a few bytes).

If there=E2=80=99s a way to handle this with a better method, I=E2=80=99=
m all ears. I had thought of taking advantage of the fact that the sum =
total of all this data will never exceed a single page, but that seems =
to me to require working around even more functionality for what is, es=
sentially, a corner case.

-Doug


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
