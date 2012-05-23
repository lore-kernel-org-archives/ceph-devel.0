From: Gregory Farnum <greg@inktank.com>
Subject: Re: I have some problem to mount ceph file system
Date: Wed, 23 May 2012 14:30:19 -0700
Message-ID: <CAPYLRzi8cDg7nQRGnK8iytD8SuCwkB5qVr+fWuUDm2o1_ckQfA@mail.gmail.com>
References: <loom.20120523T104810-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44236 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864Ab2EWVaV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 17:30:21 -0400
Received: by lbbgm6 with SMTP id gm6so5415633lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 14:30:20 -0700 (PDT)
In-Reply-To: <loom.20120523T104810-478@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Frank <frankwoo.scc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 23, 2012 at 1:51 AM, Frank <frankwoo.scc@gmail.com> wrote:
> Hello
> I have a question about ceph.
>
> When I mount ceph, I do the command as follow :
>
> # mount -t ceph -o name=3Dadmin,secret=3DXXXXXX 10.1.0.1:6789/ /mnt/c=
eph -vv
>
> now I create an user "foo" and make a secretkey by ceph-authtool like=
 that :
>
> # ceph-authtool /etc/ceph/keyring.bin -n client.foo --gen-key
>
> then I add the key into ceph :
>
> # ceph auth add client.foo osd 'allow *' mon 'allow *' mds 'allow' -i
> /etc/ceph/keyring.bin
>
> so i can mount ceph by foo :
>
> # mount -t ceph -o name=3Dfoo,secret=3DXOXOXO 10.1.0.1:6789/ /mnt/cep=
h -vv
>
> my question is if i don't want "foo" that has permission to mount 10.=
1.0.1:6789/
>
> HOW TO DO IT=EF=BC=9F
>
> if there is a directory "foo"
>
> I want he can mount 10.1.0.1:6789:/foo/
>
> but have no access to mount 10.1.0.1:6789:/

I'm afraid that's not an option with Ceph right now, that I'm aware
of. It was built and designed for a trusted set of servers and
clients, and while we're slowly carving out areas of security, this
isn't one we've done yet.
If it's an important feature for you, you should create a feature
request in the tracker (tracker.newdream.net) for it, which we will
prioritize and work on once we've moved to focus on the full
filesystem. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
