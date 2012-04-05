From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Recommended btrfs mount options
Date: Thu, 05 Apr 2012 14:56:25 +0200
Message-ID: <4F7D9679.5050006@univ-nantes.fr>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com> <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net> <or39dful05.fsf@livre.localdomain> <Pine.LNX.4.64.1111230704560.5214@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-tls1.univ-nantes.fr ([193.52.101.145]:57923 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2DENGy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 09:06:54 -0400
In-Reply-To: <Pine.LNX.4.64.1111230704560.5214@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

Le 23/11/2011 16:13, Sage Weil a =E9crit :
> On Wed, 23 Nov 2011, Alexandre Oliva wrote:
>> On Nov 22, 2011, Sage Weil<sage@newdream.net>  wrote:
>>
>>> On Tue, 22 Nov 2011, Christian Brunner wrote:
>>
>>>> - compression: I'm using lzo compression right now, as my CPUs in =
the
>>>> OSD nodes where idle most of the time and it is improving throughp=
ut
>>>> quite a bit.
>>
>>> The caveat here is that there is a corner case with inline extents =
and the
>>> clone ioctl that isn't implemented.
>>
>> What happens when you trigger that case?  Crash or corruption?
>>
>> I ask because I've been running with zlib compression, and I haven't
>> noticed any problems along these lines, though I haven't got to a po=
int
>> in which I'm doing more than rsyncing whole trees into the filesyste=
m
>> yet.
>
> Took another look at this.  The ioctl will return EINVAL from
> fs/btrfs/ioctl.c:2416:
>
> 				if (comp&&  (skip || trim)) {
> 					ret =3D -EINVAL;
> 					btrfs_end_transaction(trans, root);
> 					goto out;
> 				}
>
> If os/FileStore.cc::_do_clone_range() sees EINVAL, it falls back to d=
oing
> a copy.  That may not be ideal in some cases, but at least it's
> "correct".  For example,
>
> 0-8192 compressed inline
> 8192-100MB normal extent
>
> and we clone 4k - 100MB, and get EINVAL, we ideally wouldn't fall bac=
k to
> naively copying 100MB.  For RBD, those blocks are 4MB by default, so =
it's
> not a big deal.
>
> So you should be okay here.
>
> sage
>

So, right now, in recent ceph versions (Using 0.44.1 for the moment),=20
does using compress=3Dlzo in btrfs IS considered stable ?

Cheers ,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
