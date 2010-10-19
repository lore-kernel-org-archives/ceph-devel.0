From: "Colin P. McCabe" <colinm@hq.newdream.net>
Subject: a SimpleMessenger fix
Date: Mon, 18 Oct 2010 17:39:18 -0700
Message-ID: <AANLkTi=TXSiqp3B+yVdGY86bGP1kAykugQcvCxHi=aph@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41504 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab0JSAjT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Oct 2010 20:39:19 -0400
Received: by fxm4 with SMTP id 4so1185133fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Oct 2010 17:39:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

cc'ing list

On Mon, Oct 18, 2010 at 5:12 PM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> On Mon, Oct 18, 2010 at 4:57 PM, Colin P. McCabe <colinm@hq.newdream.=
net> wrote:
>> Hi guys,
>>
>> See if you agree with this patch. My understanding is that if we're
>> doing a non-replace open operation, "existing" should always be zero=
=2E
>> However, it is possible that it is unintentionally set to something
>> else because of a previous run through the while(1) loop. This shoul=
d
>> fix that.
>>
>> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
>> index f826448..277acdb 100644
>> --- a/src/msg/SimpleMessenger.cc
>> +++ b/src/msg/SimpleMessenger.cc
>> @@ -782,6 +782,7 @@ int SimpleMessenger::Pipe::accept()
>>      } else {
>>        // new session
>>        dout(10) << "accept new session" << dendl;
>> +      existing =3D NULL;
>>        goto open;
>>      }
>>      assert(0);
>> --
>> 1.6.6.1
>>
> I'm pretty sure that actually can't happen -- the existing pipe isn't
> removed from queues[1] until after you've exited the loop. :) No
> reason we can't make it explicit, though!
> -Greg
>
> [1]:
> =A0replace:
> =A0replace =3D true;
> =A0if (connect.features & CEPH_FEATURE_RECONNECT_SEQ) {
> =A0 =A0reply_tag =3D CEPH_MSGR_TAG_SEQ;
> =A0}
> =A0dout(10) << "accept replacing " << existing << dendl;
> =A0existing->stop();
> =A0existing->unregister_pipe();
>
> =A0if (!existing->policy.lossy) { /* if we're lossy, we can lose mess=
ages and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
should let the daemon handle it itself.
> =A0 =A0Otherwise, take over other Connection so we don't lose older m=
essages */
> =A0 =A0existing->connection_state->clear_pipe();
> =A0 =A0existing->connection_state->pipe =3D get();
> =A0 =A0existing->connection_state->put();
> =A0 =A0existing->connection_state =3D NULL;
> =A0}
>

Well, what if the while(1) loop executes two times. The first time, we
take the branch

>    if (messenger->rank_pipe.count(peer_addr)) {
>      existing =3D messenger->rank_pipe[peer_addr];
>   ...etc etc...

but then for some reason we "goto reply", which brings us back up to
the top of the loop.
Then, the next time, we take the other branch of the if statement, and
end up doing "goto open". (You would know better than I whether it is
possible for us to take the other branch the second time around.
However, since we've dropped the messenger lock before doing "goto
reply", it seems reasonable to me that the messenger's state might
have changed).
Meanwhile, "existing" is still set to the value it had during the
previous loop iteration.

Then tcp_write fails, and we encounter:
>    if (existing)
>      existing->pipe_lock.Unlock();

Which tries to unlock a mutex that we don't have.

Anyway, that's the theory. I guess like you said, we should take the
patch since it clarifies things.

cheers,
Colin McCabe
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
