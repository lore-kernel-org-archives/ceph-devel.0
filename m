From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 09:39:03 -0500
Message-ID: <553CF887.6000803@ieee.org>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36776 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbbDZOjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 10:39:09 -0400
Received: by pdea3 with SMTP id a3so100625834pde.3
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 07:39:08 -0700 (PDT)
In-Reply-To: <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 04/26/2015 09:28 AM, Douglas Fuller wrote:
> Alex,
>
> I think you are correct in both your understanding and your
> impression of the approach.

OK, good to hear.

>> On Apr 26, 2015, at 4:44 AM, Ilya Dryomov <idryomov@gmail.com>
>> wrote:
>>
>> On Sun, Apr 26, 2015 at 9:29 AM, Alex Elder <elder@ieee.org>
>> wrote:
>>> On 04/24/2015 08:22 AM, Douglas Fuller wrote:
>>>>
>>>> Support multiple class op calls in one ceph_msg and consolidate
>>>> rbd header read and refresh processes to use this feature to
>>>> reduce the number of ceph_msgs sent for that process. Refresh
>>>> features on header refresh and begin returning EIO if features
>>>> have changed since mapping.
>>>
>>> This sounds pretty expensive.  For every class operation you are
>>> copying the received data two extra times.
>
> I=E2=80=99d really like a solution to this, but I don=E2=80=99t think=
 one is
> available given the constraints.

Now that I know I understand it, I will at least provide
some review comments on the patches.  I'll also think about
it a little.  My instinct says there should be no need to
make the copies, but the devil will be in the details.

>>> Will you please correct me where I'm wrong above, and maybe give
>>> a little better high-level explanation of what you're trying to
>>> do?  I see in patch 1 you mention a problem with short reads, and
>>> there may be a simpler fix than that (to begin with).  But beyond
>>> that, if you're trying to incorporate more ops in a message,
>>> there may be better ways to go about that as well.
>>
>> Yeah, the only objective of this was to pack more call ops into an
>> osd_request in order to reduce the number of network RTs during rbd
>> map and refresh.  The fundamental problem the first patch is trying
>> to work around is the first ceph_msg_data item consuming all reply
>> buffers instead of just its own.  We have to preallocate response
>> buffers and if the preallocated response buffer for the first op is
>> large enough (it always is) it will consume the entire ceph_msg,
>> along with replies to other ops.
>>
>> My understanding is that the first patch is supposed to be a
>> specific workarond for just that - I think it's noted somewhere
>> that it will break on reads combined with call ops or similar.
>
> That=E2=80=99s correct. This patch only works around that short respo=
nse
> issue in this specific corner case. It does not fix cases where call
> ops returning data could be arbitrarily combined with reads or writes
> (and apparently they never have been, because that would not work).
> It should not introduce additional cases of breakage, though.

I knew when we added support for copyup that we were kind of
kludging things to allow *just one* more op in a message.  Then
the discard support added another, but in both of these cases
it was not done in a nice, general way.  The "right" way is
to generalize it, but if that was easy it would have been
done by now.

> I was told that the preferred way to proceed for now was to avoid
> changing the osd_client interface and to handle this case in
> osd_client instead of the messaging layer. Given those constraints,
> it was agreed in the standups and on #ceph-devel that it should be
> done this way.

Sorry, I haven't been keeping up with all the activity on the
mailing list.  I pay closest attention to patches to the kernel
code.

> We can=E2=80=99t know the actual response sizes until they are decode=
d in
> osd_client. Therefore, we can=E2=80=99t copy them directly to the use=
r
> buffers off the wire. That costs us one extra copy. The other copy is
> required because pagevec.c does not provide an interface for copying
> arbitrary data between two page vectors.

That could probably be changed, but that's a separate issue
(and somewhat out of your hands as far as getting it done when
you need it).

>> I too have my efficiency concerns and I raised them in one of the
>> standups but the argument was that this is only going to be used
>> for header init/refresh, not copyup, so the overhead is negligible.
>> I'm still not sold on the copying everything twice though and was
>> going to try to see if there is a simple way to special case this
>> even more and make the diffstat smaller.
>
> You and I agreed in that particular standup discussion; I don=E2=80=99=
t like
> it, either. I would prefer a general-case solution that avoids
> introducing so much extra overhead, especially for such a small
> amount of data (really just a few bytes).
>
> If there=E2=80=99s a way to handle this with a better method, I=E2=80=
=99m all ears. I
> had thought of taking advantage of the fact that the sum total of all
> this data will never exceed a single page, but that seems to me to
> require working around even more functionality for what is,
> essentially, a corner case.

OK, well I'll go look at that code path again to see if I can
come up with any bright ideas.

Thanks for the explanation.

					-Alex
> -Doug
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
