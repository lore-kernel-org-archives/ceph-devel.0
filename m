From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A new rados api set_client_priority
Date: Mon, 14 Sep 2015 16:06:36 -0700
Message-ID: <CAJ4mKGbPCt4HnOJaB16AsZs8g-5gYpQgqDh+nsaDSq_YgZhrcw@mail.gmail.com>
References: <CAEv+sP6jsqAitvGnWxbtZdcFtof2V7NB_C583w2JZnOjf7T4EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35223 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbINXGi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 19:06:38 -0400
Received: by wicge5 with SMTP id ge5so4700112wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2015 16:06:37 -0700 (PDT)
In-Reply-To: <CAEv+sP6jsqAitvGnWxbtZdcFtof2V7NB_C583w2JZnOjf7T4EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?556/5aSp5ZaE?= <qutianshan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 10, 2015 at 2:43 AM, =E7=9E=BF=E5=A4=A9=E5=96=84 <qutiansha=
n@gmail.com> wrote:
> Hi,
>   I'm working on the topic
> <http://tracker.ceph.com/projects/ceph/wiki/Messenger_-_priorities_fo=
r_Client>
> , first step I add a new rados api set_client_priority, then I will d=
o
> more test to get the idea of how to balance the performance.
>    code is in the pr <https://github.com/ceph/ceph/pull/5602>,
> originally client read the config to get priority.
>    Is the api ok?

The API looks fine at first glance, but I continue to be concerned
about exposing priorities like this. Right now they behave fairly
oddly. For instance:
1) If you have multiple message priorities on the same client, the
higher-priority ones always get sent out if there are any.
2) When receiving messages, the higher-priority ones in the queue are
always delivered ahead of lower-priority ones
2b) ...unless the ms_fast_dispatch interface is involved (as with
client<->OSD communication), in which case priority is ignored by the
receiving messenger and it's just dispatched instantly.
3) The priority is used internally by the OSD for a proper tokenized
delivery scheme.

I think for QOS like this you're most interested in the third option,
but simply setting message priority like this will also apply to the
monitors and MDSes (and do potentially strange things!), and without
guards on the results users could do stuff like set their priority to
the max value and basically crowd out everybody else in the cluster.
=2E..come to think of it, that's probably an attack they could do
currently if they've got a RADOS key they control. But it's at least
*difficult* to do accidentally since the interfaces generally aren't
exposed. ;)

So before merging something like this I'd like to see us have a more
complete solution carved out:
0) Identify if we even want message priority and in-daemon processing
priority to be conflated.
1) What does the messenger do? Make it as consistent as possible,
probably with tokenization like the OSD has. (This won't be difficult
code-wise as we're already using PrioritizedQueue, but we use the
"strict" portion of it for all messages right now.) Make sure stuff
doesn't break.
2) Establish a way to specify different priorities for different
daemons. Just because somebody gets faster data IO doesn't mean they
get faster MDS access. Everybody should probably be equal to the
monitors. ...and this is one of the things that the proposed API would
need to be changed to support.
3) Add capabilities support for specifying priority limits, along with
a reasonable default. Check these on message receipt. (...and reject
messages outside the bounds? Move them in-bounds?)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
