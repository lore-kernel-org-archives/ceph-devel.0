From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: Consistency vs efficiency
Date: Thu, 21 Jul 2011 10:36:46 -0700
Message-ID: <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
	<Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45467 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1GURgq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 13:36:46 -0400
Received: by ywe9 with SMTP id 9so768285ywe.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 10:36:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks for the response Sage. We are using 2.6.39 kernel and in the
"ceph_lookup" method, i see that there is a shortcut for deciding
ENOENT but after the MDS lookup, i dont see a d_add. I am sure i am
missing something here.

thanks again
Jojy

On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> Hi
>> =C2=A0 I just started looking at the ceph code in kernel and had a q=
uestion
>> about performance considerations for lookup operations. I noticed th=
at
>> for every operation (say copying a directory), the root dentry is
>> "looked" up multiple times and since they all go to MDS for the actu=
al
>> lookup operation, it effects the performance. I am sure consistency =
is
>> the winner here. Is there any plan to improve this, maybe by having
>> MDS push the capability down to the clients when the dentry is
>> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
>> modified. This was the client node can cache the lookup operation an=
d
>> does not have to make a round trip to the MDS.
>
> In general, the MDS has two ways of keeping a client's cached dentry
> consistent:
>
> =C2=A0- it can issue the FILE_SHARED capability bit on the parent dir=
ectory,
> which means the entire directory is static and the client can cache
> dentry.
> =C2=A0- if it can't do that, it will issue a per-dentry lease
>
> There is an additional 'complete' bit that is used to indicate on the
> client that it has the _entire_ directory in cache. =C2=A0If set, it =
can do
> negative lookups and readdir without hitting the MDS. =C2=A0That's cu=
rrently
> broken, pending the addition of a d_prune dentry_operation (see
> linux-fsdevel email from July 8).
>
> Anyway, long story short, if you're seeing repeated lookups on a dent=
ry
> that isn't changing, something is broken. =C2=A0Can you describe the =
workload
> in more detail? =C2=A0Which versions of the client and mds are you ru=
nning?
>
> sage
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
